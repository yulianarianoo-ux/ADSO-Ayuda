package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.dto.TicketDTO;
import co.edu.sena.mesaayuda.mapper.TicketMapper;
import co.edu.sena.mesaayuda.modelo.Prioridad;
import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.modelo.estado.EstadoTicket;
import co.edu.sena.mesaayuda.modelo.estado.TransicionInvalidaException;
import co.edu.sena.mesaayuda.servicio.TicketService;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/atender")
public class AtenderTicketsWeb extends HttpServlet {

    private TicketService ticketService;

    // =====================================================
    // INICIALIZAR
    // =====================================================

    @Override
    public void init() throws ServletException {

        ticketService = (TicketService) getServletContext()
                .getAttribute(
                        AppContextListener.TICKET_SERVICE
                );

        if (ticketService == null) {

            throw new ServletException(
                    "TicketService no fue inicializado en el ServletContext."
            );
        }
    }

    // =====================================================
    // MOSTRAR TICKETS
    // =====================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // =================================================
        // VALIDAR SESIÓN
        // =================================================

        HttpSession session =
                request.getSession(false);

        if (session == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/Login.jsp"
            );

            return;
        }

        Usuario usuario =
                (Usuario) session.getAttribute(
                        "usuario"
                );

        if (usuario == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/Login.jsp"
            );

            return;
        }

        // =================================================
        // OBTENER AGENTE
        // =================================================

        int idAgente =
                usuario.getId_usuario();

        // =================================================
        // OBTENER FILTROS HTTP
        // =================================================

        String estadoParam =
                request.getParameter("estado");

        String prioridadParam =
                request.getParameter("prioridad");

        if (estadoParam == null
                || estadoParam.trim().isEmpty()) {

            estadoParam = "TODOS";
        }

        if (prioridadParam == null
                || prioridadParam.trim().isEmpty()) {

            prioridadParam = "TODAS";
        }

        estadoParam =
                estadoParam.trim();

        prioridadParam =
                prioridadParam.trim();

        // =================================================
        // BUSCAR TICKETS
        // =================================================
       

        List<Ticket> tickets =
                ticketService.listarTicketsParaAgente(
                        idAgente,
                        estadoParam,
                        prioridadParam
                );

        // =================================================
        // CONVERTIR MODELO → DTO
        // =================================================

        List<TicketDTO> ticketsDTO =
                tickets.stream()
                        .map(ticket -> {

                            TicketDTO dto =
                                    TicketMapper.toDTO(
                                            ticket
                                    );

                            dto.setHorasSLA(
                                    ticketService.calcularHorasSLA(
                                            ticket
                                    )
                            );

                            return dto;
                        })
                        .collect(Collectors.toList());

        // =================================================
        // CARGAR ESTADOS
        // =================================================

        List<EstadoTicket> estados =
                ticketService.listarEstados();

        // =================================================
        // CARGAR PRIORIDADES
        // =================================================

        List<Prioridad> prioridades =
                ticketService.listarPrioridades();

        // =================================================
        // ENVIAR INFORMACIÓN AL JSP
        // =================================================

        request.setAttribute(
                "tickets",
                ticketsDTO
        );

        request.setAttribute(
                "estados",
                estados
        );

        request.setAttribute(
                "prioridades",
                prioridades
        );

        request.setAttribute(
                "filtroEstadoActual",
                estadoParam
        );

        request.setAttribute(
                "filtroPrioridadActual",
                prioridadParam
        );

        // =================================================
        // MENSAJES
        // =================================================

        String mensajeExito =
                (String) session.getAttribute(
                        "mensajeExito"
                );

        String mensajeError =
                (String) session.getAttribute(
                        "mensajeError"
                );

        if (mensajeExito != null) {

            request.setAttribute(
                    "mensajeExito",
                    mensajeExito
            );

            session.removeAttribute(
                    "mensajeExito"
            );
        }

        if (mensajeError != null) {

            request.setAttribute(
                    "mensajeError",
                    mensajeError
            );

            session.removeAttribute(
                    "mensajeError"
            );
        }

        // =================================================
        // MOSTRAR JSP
        // =================================================

        request.getRequestDispatcher(
                "/AtenderTicket.jsp"
        ).forward(
                request,
                response
        );
    }

    // =====================================================
    // CAMBIAR ESTADO
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        // =================================================
        // DETECTAR AJAX
        // =================================================

        boolean esAjax =
                "XMLHttpRequest".equalsIgnoreCase(
                        request.getHeader(
                                "X-Requested-With"
                        )
                );

        // =================================================
        // OBTENER USUARIO
        // =================================================

        Usuario usuario =
                (Usuario) session.getAttribute(
                        "usuario"
                );

        // =================================================
        // VALIDAR SESIÓN
        // =================================================

        if (usuario == null) {

            if (esAjax) {

                response.setContentType(
                        "text/plain;charset=UTF-8"
                );

                response.setStatus(
                        HttpServletResponse.SC_UNAUTHORIZED
                );

                response.getWriter().write(
                        "error: sesión expirada, inicia sesión nuevamente."
                );

                return;
            }

            response.sendRedirect(
                    request.getContextPath()
                            + "/Login.jsp"
            );

            return;
        }

        // =================================================
        // OBTENER PARÁMETROS HTTP
        // =================================================

        String idTicketParam =
                request.getParameter(
                        "id_ticket"
                );

        String accionParam =
                request.getParameter(
                        "accion"
                );

        String mensajeResultado =
                null;

        boolean exito = false;

        try {

            // =================================================
            // VALIDAR ID
            // =================================================

            if (idTicketParam == null
                    || idTicketParam.trim().isEmpty()) {

                throw new IllegalArgumentException(
                        "No se recibió el ID del ticket."
                );
            }

            // =================================================
            // VALIDAR ACCIÓN
            // =================================================

            if (accionParam == null
                    || accionParam.trim().isEmpty()) {

                throw new IllegalArgumentException(
                        "No se recibió la acción a realizar."
                );
            }

            // =================================================
            // CONVERTIR ID
            // =================================================

            int idTicket =
                    Integer.parseInt(
                            idTicketParam.trim()
                    );

            int idAgente =
                    usuario.getId_usuario();

            // =================================================
            // VALIDAR PERTENENCIA
            // =================================================
           

            boolean perteneceAlAgente =
                    ticketService.perteneceAlAgente(
                            idTicket,
                            idAgente
                    );

            if (!perteneceAlAgente) {

                mensajeResultado =
                        "No tienes permiso para modificar este ticket.";

                session.setAttribute(
                        "mensajeError",
                        mensajeResultado
                );

                if (esAjax) {

                    response.setContentType(
                            "text/plain;charset=UTF-8"
                    );

                    response.setStatus(
                            HttpServletResponse.SC_FORBIDDEN
                    );

                    response.getWriter().write(
                            "error: "
                            + mensajeResultado
                    );

                    return;
                }

                response.sendRedirect(
                        request.getContextPath()
                                + "/atender"
                );

                return;
            }

            // =================================================
            // OBTENER ACCIÓN
            // =================================================

        String accion =
        accionParam
                .trim()
                .toLowerCase();

// =================================================
// EJECUTAR ACCIÓN
// =================================================

boolean actualizado =
        ticketService.cambiarEstado(
                idTicket,
                accion
        );

          
            // =================================================
            // RESULTADO
            // =================================================

            if (actualizado) {

                exito = true;

                mensajeResultado =
                        "El estado del ticket fue actualizado correctamente.";

                session.setAttribute(
                        "mensajeExito",
                        mensajeResultado
                );

            } else {

                mensajeResultado =
                        "No se pudo actualizar el estado del ticket.";

                session.setAttribute(
                        "mensajeError",
                        mensajeResultado
                );
            }

        } catch (TransicionInvalidaException e) {

            mensajeResultado =
                    e.getMessage();

            session.setAttribute(
                    "mensajeError",
                    mensajeResultado
            );

        } catch (NumberFormatException e) {

            mensajeResultado =
                    "El ID del ticket no es válido.";

            session.setAttribute(
                    "mensajeError",
                    mensajeResultado
            );

        } catch (IllegalArgumentException e) {

            mensajeResultado =
                    e.getMessage();

            session.setAttribute(
                    "mensajeError",
                    mensajeResultado
            );

        } catch (Exception e) {

            e.printStackTrace();

            mensajeResultado =
                    "Ocurrió un error al actualizar el ticket.";

            session.setAttribute(
                    "mensajeError",
                    mensajeResultado
            );
        }

        // =================================================
        // RESPUESTA AJAX
        // =================================================

        if (esAjax) {

            response.setContentType(
                    "text/plain;charset=UTF-8"
            );

            if (exito) {

                session.removeAttribute(
                        "mensajeExito"
                );

                response.getWriter().write(
                        "true"
                );

            } else {

                session.removeAttribute(
                        "mensajeError"
                );

                response.setStatus(
                        HttpServletResponse.SC_BAD_REQUEST
                );

                response.getWriter().write(
                        "error: "
                        + mensajeResultado
                );
            }

            return;
        }

        // =================================================
        // REDIRECCIÓN NORMAL
        // =================================================

        response.sendRedirect(
                request.getContextPath()
                        + "/atender"
        );
    }
}