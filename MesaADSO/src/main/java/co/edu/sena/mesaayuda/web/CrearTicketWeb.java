package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.modelo.Categoria;
import co.edu.sena.mesaayuda.modelo.Prioridad;
import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.modelo.estado.EstadoNuevo;

import co.edu.sena.mesaayuda.servicio.CategoriaService;
import co.edu.sena.mesaayuda.servicio.TicketService;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/crearTicket")
public class CrearTicketWeb extends HttpServlet {

    private TicketService ticketService;
    private CategoriaService categoriaService;

    // =========================================================
    // INICIALIZAR
    // =========================================================

    @Override
    public void init() {

        ticketService =
                (TicketService) getServletContext()
                        .getAttribute(
                                AppContextListener.TICKET_SERVICE
                        );

        categoriaService =
                (CategoriaService) getServletContext()
                        .getAttribute(
                                AppContextListener.CATEGORIA_SERVICE
                        );
    }

    // =========================================================
    // MOSTRAR FORMULARIO
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        // =====================================================
        // OBTENER USUARIO
        // =====================================================

        Usuario usuario =
                (Usuario) session.getAttribute("usuario");

        // =====================================================
        // VERIFICAR SESIÓN
        // =====================================================

        if (usuario == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/Login.jsp"
            );

            return;
        }

        // =====================================================
        // VERIFICAR SERVICES
        // =====================================================

        if (ticketService == null
                || categoriaService == null) {

            throw new ServletException(
                    "Los servicios de la aplicación no fueron inicializados."
            );
        }

        // =====================================================
        // CARGAR CATEGORÍAS
        // =====================================================

        List<Categoria> categorias =
                categoriaService.listarTodas();

        // =====================================================
        // CARGAR PRIORIDADES
        // =====================================================

        List<Prioridad> prioridades =
                ticketService.listarPrioridades();

        // =====================================================
        // ENVIAR DATOS AL JSP
        // =====================================================

        request.setAttribute(
                "categorias",
                categorias
        );

        request.setAttribute(
                "prioridades",
                prioridades
        );

        // =====================================================
        // ABRIR FORMULARIO
        // =====================================================

        request.getRequestDispatcher(
                "/CrearTicket.jsp"
        ).forward(
                request,
                response
        );
    }

    // =========================================================
    // CREAR TICKET
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession();

        // =====================================================
        // OBTENER USUARIO
        // =====================================================

        Usuario usuario =
                (Usuario) session.getAttribute("usuario");

        // =====================================================
        // VERIFICAR SESIÓN
        // =====================================================

        if (usuario == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/Login.jsp"
            );

            return;
        }

        try {

            // =================================================
            // RECIBIR DATOS
            // =================================================

            String titulo =
                    request.getParameter("titulo");

            String descripcion =
                    request.getParameter("descripcion");

            String categoriaParam =
                    request.getParameter("id_categoria");

            // =================================================
            // VALIDAR TÍTULO
            // =================================================

            if (titulo == null
                    || titulo.trim().isEmpty()) {

                throw new IllegalArgumentException(
                        "El título es obligatorio."
                );
            }

            // =================================================
            // VALIDAR DESCRIPCIÓN
            // =================================================

            if (descripcion == null
                    || descripcion.trim().isEmpty()) {

                throw new IllegalArgumentException(
                        "La descripción es obligatoria."
                );
            }

            // =================================================
            // VALIDAR CATEGORÍA
            // =================================================

            if (categoriaParam == null
                    || categoriaParam.trim().isEmpty()) {

                throw new IllegalArgumentException(
                        "Debe seleccionar una categoría."
                );
            }

            // =================================================
            // CONVERTIR CATEGORÍA
            // =================================================

            int idCategoria =
                    Integer.parseInt(
                            categoriaParam
                    );

            // =================================================
            // CREAR CATEGORÍA
            // =================================================

            Categoria categoria =
                    new Categoria();

            categoria.setId_categoria(
                    idCategoria
            );

            // =================================================
            // CREAR TICKET
            // =================================================

            Ticket ticket =
                    new Ticket();

            ticket.setTitulo(
                    titulo.trim()
            );

            ticket.setDescripcion(
                    descripcion.trim()
            );

            ticket.setCategoria(
                    categoria
            );

            ticket.setSolicitante(
                    usuario
            );

            ticket.setFecha_creacion(
                    new Date()
            );

            // =================================================
            // IMPORTANTE
            // =================================================
            // Se limpia cualquier prioridad que pueda venir
            // asignada por defecto desde Ticket.
            //
            // Esto permite que calcularPrioridad() analice
            // realmente el título y la descripción.

            ticket.setPrioridad(null);

            // =================================================
            // CALCULAR PRIORIDAD AUTOMÁTICAMENTE
            // ==============================qnb ===================

            Prioridad prioridad =
                    ticketService.calcularPrioridad(
                            ticket
                    );

            if (prioridad == null) {

                throw new IllegalArgumentException(
                        "No se pudo calcular la prioridad automáticamente."
                );
            }

            // =================================================
            // ASIGNAR PRIORIDAD CALCULADA
            // =================================================

            ticket.setPrioridad(
                    prioridad
            );

            // =================================================
            // ESTADO INICIAL
            // =================================================

            ticket.setEstado(
                    new EstadoNuevo()
            );

            // =================================================
            // ASIGNACIÓN AUTOMÁTICA DE AGENTE
            // =================================================

            Usuario agente =
                    ticketService.asignarAgente(
                            ticket
                    );

            ticket.setAgente(
                    agente
            );

            // =================================================
            // GUARDAR
            // =================================================

            boolean guardado =
                    ticketService.guardar(
                            ticket
                    );

            // =================================================
            // RESULTADO
            // =================================================

            if (guardado) {

                session.setAttribute(
                        "mensajeExito",
                        "Ticket creado correctamente."
                );

            } else {

                session.setAttribute(
                        "mensajeError",
                        "No se pudo crear el ticket."
                );
            }

            // =================================================
            // REDIRECCIÓN
            // =================================================

            response.sendRedirect(
                    request.getContextPath()
                            + "/crearTicket"
            );

        } catch (NumberFormatException e) {

            e.printStackTrace();

            session.setAttribute(
                    "mensajeError",
                    "La categoría seleccionada no es válida."
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/crearTicket"
            );

        } catch (IllegalArgumentException e) {

            e.printStackTrace();

            session.setAttribute(
                    "mensajeError",
                    e.getMessage()
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/crearTicket"
            );

        } catch (Exception e) {

            e.printStackTrace();

            session.setAttribute(
                    "mensajeError",
                    "Ocurrió un error al crear el ticket."
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/crearTicket"
            );
        }
    }
}