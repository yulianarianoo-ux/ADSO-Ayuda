package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.modelo.Comentario;
import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.repositorio.ComentarioRepositoryJDBC;
import co.edu.sena.mesaayuda.repositorio.TicketRepositoryJDBC;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/detalleTicket")
public class DetalleTicketWeb extends HttpServlet {

    private final TicketRepositoryJDBC ticketRepository =
            new TicketRepositoryJDBC();

    private final ComentarioRepositoryJDBC comentarioRepository =
            new ComentarioRepositoryJDBC();


    // =====================================================
    // GET
    // MOSTRAR DETALLE DEL TICKET
    // =====================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        cargarDetalle(request, response);
    }


    // =====================================================
    // POST
    // GUARDAR COMENTARIO
    // =====================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // -------------------------------------------------
        // OBTENER USUARIO DE LA SESIÓN
        // -------------------------------------------------

        HttpSession session = request.getSession(false);

        Usuario usuario = null;

        if (session != null) {

            usuario =
                    (Usuario) session.getAttribute("usuario");
        }

        // -------------------------------------------------
        // VALIDAR SESIÓN
        // -------------------------------------------------

        if (usuario == null) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/Login.jsp"
            );

            return;
        }


        // -------------------------------------------------
        // OBTENER ID DEL TICKET
        // -------------------------------------------------

        String idParametro =
                request.getParameter("id");


        if (idParametro == null
                || idParametro.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/misTickets"
            );

            return;
        }


        int idTicket;

        try {

            idTicket =
                    Integer.parseInt(idParametro);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/misTickets"
            );

            return;
        }


        // -------------------------------------------------
        // OBTENER TEXTO DEL COMENTARIO
        // -------------------------------------------------

        String texto =
                request.getParameter("texto");


        if (texto == null
                || texto.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/detalleTicket?id="
                            + idTicket
            );

            return;
        }


        // -------------------------------------------------
        // BUSCAR TICKET
        // -------------------------------------------------

        Ticket ticket =
                ticketRepository.buscarPorId(idTicket);


        if (ticket == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "El ticket no existe."
            );

            return;
        }


        // -------------------------------------------------
        // CREAR COMENTARIO
        // -------------------------------------------------

        Comentario comentario =
                new Comentario();

        comentario.setTicket(ticket);

        comentario.setUsuario(usuario);

        comentario.setTexto(texto.trim());


        // -------------------------------------------------
        // GUARDAR
        // -------------------------------------------------

        comentarioRepository.guardar(
                comentario
        );


        // -------------------------------------------------
        // VOLVER AL DETALLE
        // -------------------------------------------------

        response.sendRedirect(
                request.getContextPath()
                        + "/detalleTicket?id="
                        + idTicket
        );
    }


    // =====================================================
    // CARGAR DETALLE
    // =====================================================

    private void cargarDetalle(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // -------------------------------------------------
        // OBTENER ID
        // -------------------------------------------------

        String idParametro =
                request.getParameter("id");


        if (idParametro == null
                || idParametro.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/misTickets"
            );

            return;
        }


        int idTicket;

        try {

            idTicket =
                    Integer.parseInt(idParametro);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/misTickets"
            );

            return;
        }


        // -------------------------------------------------
        // BUSCAR TICKET
        // -------------------------------------------------

        Ticket ticket =
                ticketRepository.buscarPorId(idTicket);


        if (ticket == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "El ticket no existe."
            );

            return;
        }


        // -------------------------------------------------
        // BUSCAR COMENTARIOS
        // -------------------------------------------------

        ticket.setComentarios(
                comentarioRepository
                        .listarPorTicket(idTicket)
        );


        // -------------------------------------------------
        // ENVIAR TICKET AL JSP
        // -------------------------------------------------

        request.setAttribute(
                "ticket",
                ticket
        );


        // -------------------------------------------------
        // MOSTRAR JSP
        // -------------------------------------------------

        request.getRequestDispatcher(
                "/detalleTicket.jsp"
        ).forward(
                request,
                response
        );
    }
}