package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.dto.TicketDTO;
import co.edu.sena.mesaayuda.mapper.TicketMapper;

import co.edu.sena.mesaayuda.modelo.Categoria;
import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;

import co.edu.sena.mesaayuda.servicio.CategoriaService;
import co.edu.sena.mesaayuda.servicio.TicketService;
import co.edu.sena.mesaayuda.servicio.UsuarioService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/tickets")
public class TicketWeb extends HttpServlet {

    private TicketService ticketService;
    private UsuarioService usuarioService;
    private CategoriaService categoriaService;

    // =====================================================
    // INICIALIZAR
    // =====================================================

    @Override
    public void init() throws ServletException {

        ticketService =
                (TicketService) getServletContext()
                        .getAttribute(
                                AppContextListener.TICKET_SERVICE
                        );

        usuarioService =
                (UsuarioService) getServletContext()
                        .getAttribute(
                                AppContextListener.USUARIO_SERVICE
                        );

        categoriaService =
                (CategoriaService) getServletContext()
                        .getAttribute(
                                AppContextListener.CATEGORIA_SERVICE
                        );

        if (ticketService == null) {

            throw new ServletException(
                    "TicketService no fue inicializado."
            );
        }

        if (usuarioService == null) {

            throw new ServletException(
                    "UsuarioService no fue inicializado."
            );
        }

        if (categoriaService == null) {

            throw new ServletException(
                    "CategoriaService no fue inicializado."
            );
        }
    }

    // =====================================================
    // GET - MOSTRAR TICKETS
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

        Usuario usuarioSesion =
                session != null
                        ? (Usuario) session.getAttribute("usuario")
                        : null;

        if (usuarioSesion == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/Login.jsp"
            );

            return;
        }

        // =================================================
        // VALIDAR ROL
        // =================================================

        if (usuarioSesion.getRol() == null
                || !"ADMINISTRADOR".equalsIgnoreCase(
                        usuarioSesion.getRol().getTipoRol())) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/Login.jsp"
            );

            return;
        }

        try {

            // =============================================
            // OBTENER TICKETS
            // =============================================

            List<Ticket> tickets =
                    ticketService.listarTodos();

            if (tickets == null) {
                tickets = new ArrayList<>();
            }

            // =============================================
            // CONVERTIR TICKETS A DTO
            // =============================================

            List<TicketDTO> ticketsDTO =
                    tickets.stream()
                            .filter(ticket -> ticket != null)
                            .map(TicketMapper::toDTO)
                            .collect(Collectors.toList());

            // =============================================
            // OBTENER CATEGORÍAS
            // =============================================

            List<Categoria> categorias =
                    categoriaService.listarTodas();

            if (categorias == null) {
                categorias = new ArrayList<>();
            }

            // =============================================
            // OBTENER AGENTES POR TICKET
            // =============================================
           

            Map<Integer, List<Usuario>> agentesPorTicket =
                    ticketService.listarAgentesPorTicket(
                            tickets
                    );

            // =============================================
            // ENVIAR DATOS AL JSP
            // =============================================

            request.setAttribute(
                    "tickets",
                    ticketsDTO
            );

            request.setAttribute(
                    "agentesPorTicket",
                    agentesPorTicket
            );

            request.setAttribute(
                    "categorias",
                    categorias
            );

            // =============================================
            // MOSTRAR JSP
            // =============================================

            request.getRequestDispatcher(
                    "/VerTickets.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            request.getSession().setAttribute(
                    "mensajeError",
                    "No fue posible cargar los tickets."
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/PanelPrincipal.jsp"
            );
        }
    }

    // =====================================================
    // POST
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession(false);

        Usuario usuarioSesion =
                session != null
                        ? (Usuario) session.getAttribute("usuario")
                        : null;

        // =================================================
        // VALIDAR SESIÓN
        // =================================================

        if (usuarioSesion == null) {

            request.getSession().setAttribute(
                    "mensajeError",
                    "Debes iniciar sesión."
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/Login.jsp"
            );

            return;
        }

        // =================================================
        // VALIDAR ROL
        // =================================================

        if (usuarioSesion.getRol() == null
                || !"ADMINISTRADOR".equalsIgnoreCase(
                        usuarioSesion.getRol().getTipoRol())) {

            request.getSession().setAttribute(
                    "mensajeError",
                    "No tienes permiso para realizar esta acción."
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/Login.jsp"
            );

            return;
        }

        // =================================================
        // OBTENER ACCIÓN
        // =================================================

        String action =
                request.getParameter("action");

        try {

            if ("reasignar".equals(action)) {

                reasignarAgente(
                        request,
                        response
                );

                return;
            }

            if ("cambiarEstado".equals(action)) {

                cambiarEstado(
                        request,
                        response
                );

                return;
            }

            if ("eliminar".equals(action)) {

                eliminarTicket(
                        request,
                        response
                );

                return;
            }

            session.setAttribute(
                    "mensajeError",
                    "La acción solicitada no es válida."
            );

        } catch (Exception e) {

            session.setAttribute(
                    "mensajeError",
                    "No fue posible ejecutar la acción solicitada."
            );
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/tickets"
        );
    }

    // =====================================================
    // REASIGNAR AGENTE
    // =====================================================

    private void reasignarAgente(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String idTicketParam =
                request.getParameter("id_ticket");

        String idAgenteParam =
                request.getParameter("id_agente");

        try {

            int idTicket =
                    Integer.parseInt(
                            idTicketParam
                    );

            int idAgente =
                    Integer.parseInt(
                            idAgenteParam
                    );

            boolean actualizado =
                    ticketService.reasignarAgente(
                            idTicket,
                            idAgente
                    );

            if (actualizado) {

                request.getSession().setAttribute(
                        "mensajeExito",
                        "El ticket fue reasignado correctamente."
                );

            } else {

                request.getSession().setAttribute(
                        "mensajeError",
                        "No se pudo reasignar el ticket."
                );
            }

        } catch (NumberFormatException e) {

            request.getSession().setAttribute(
                    "mensajeError",
                    "El ID del ticket o del agente no es válido."
            );

        } catch (Exception e) {

            request.getSession().setAttribute(
                    "mensajeError",
                    "No fue posible reasignar el ticket."
            );
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/tickets"
        );
    }

    // =====================================================
    // CAMBIAR ESTADO
    // =====================================================

    private void cambiarEstado(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String idTicketParam =
                request.getParameter("id_ticket");

        String accion =
                request.getParameter("accion");

        try {

            int idTicket =
                    Integer.parseInt(
                            idTicketParam
                    );

            boolean actualizado =
                    ticketService.cambiarEstado(
                            idTicket,
                            accion
                    );

            if (actualizado) {

                request.getSession().setAttribute(
                        "mensajeExito",
                        "El estado del ticket fue actualizado."
                );

            } else {

                request.getSession().setAttribute(
                        "mensajeError",
                        "No se pudo actualizar el estado del ticket."
                );
            }

        } catch (NumberFormatException e) {

            request.getSession().setAttribute(
                    "mensajeError",
                    "El ID del ticket no es válido."
            );

        } catch (IllegalArgumentException e) {

            request.getSession().setAttribute(
                    "mensajeError",
                    e.getMessage()
            );

        } catch (Exception e) {

            request.getSession().setAttribute(
                    "mensajeError",
                    "No fue posible cambiar el estado del ticket."
            );
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/tickets"
        );
    }

    // =====================================================
    // ELIMINAR TICKET
    // =====================================================

    private void eliminarTicket(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String idTicketParam =
                request.getParameter("id_ticket");

        try {

            int idTicket =
                    Integer.parseInt(
                            idTicketParam
                    );

            boolean eliminado =
                    ticketService.eliminarTicket(
                            idTicket
                    );

            if (eliminado) {

                request.getSession().setAttribute(
                        "mensajeExito",
                        "El ticket fue eliminado correctamente."
                );

            } else {

                request.getSession().setAttribute(
                        "mensajeError",
                        "No se pudo eliminar el ticket."
                );
            }

        } catch (NumberFormatException e) {

            request.getSession().setAttribute(
                    "mensajeError",
                    "El ID del ticket no es válido."
            );

        } catch (Exception e) {

            request.getSession().setAttribute(
                    "mensajeError",
                    "No fue posible eliminar el ticket."
            );
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/tickets"
        );
    }
}