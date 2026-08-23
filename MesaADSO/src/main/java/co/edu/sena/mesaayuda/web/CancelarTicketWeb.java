package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.repositorio.TicketRepositoryJDBC;
import co.edu.sena.mesaayuda.servicio.TicketService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cancelarTicket")
public class CancelarTicketWeb extends HttpServlet {

    private TicketService ticketService;

    @Override
    public void init() throws ServletException {

        TicketRepositoryJDBC repository =
                new TicketRepositoryJDBC();

        ticketService =
                new TicketService(
                        repository,
                        null,
                        null,
                        new java.util.HashMap<>()
                );
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("usuario") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/Login.jsp"
            );

            return;
        }

        String idParam =
                request.getParameter("id");

        if (idParam == null ||
            idParam.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/solicitante/misTickets"
            );

            return;
        }

        try {

            int idTicket =
                    Integer.parseInt(idParam);

            boolean resultado =
                    ticketService.cancelar(idTicket);

            if (resultado) {

                session.setAttribute(
                        "mensaje",
                        "El ticket #" + idTicket
                        + " fue cancelado correctamente."
                );

                session.setAttribute(
                        "tipoMensaje",
                        "success"
                );

            } else {

                session.setAttribute(
                        "mensaje",
                        "No fue posible cancelar el ticket #"
                        + idTicket + "."
                );

                session.setAttribute(
                        "tipoMensaje",
                        "error"
                );
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "mensaje",
                    "El ID del ticket no es válido."
            );

            session.setAttribute(
                    "tipoMensaje",
                    "error"
            );
        }

        /*
         * IMPORTANTE:
         * Regresa a la página de mis tickets.
         */
        response.sendRedirect(
                request.getContextPath()
                + "/solicitante/misTickets"
        );
    }
}