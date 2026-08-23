package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.repositorio.TicketRepository;
import co.edu.sena.mesaayuda.repositorio.TicketRepositoryJDBC;
import co.edu.sena.mesaayuda.repositorio.UsuarioRepository;
import co.edu.sena.mesaayuda.repositorio.UsuarioRepositoryJDBC;

import co.edu.sena.mesaayuda.servicio.AsignacionService;
import co.edu.sena.mesaayuda.servicio.TicketService;
import co.edu.sena.mesaayuda.servicio.UsuarioService;

import co.edu.sena.mesaayuda.servicio.asignacion.EstrategiaAsignacion;
import co.edu.sena.mesaayuda.servicio.sla.EstrategiaSLA;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/reabrirTicket")
public class ReabrirTicketWeb extends HttpServlet {

    private TicketService ticketService;

    @Override
    public void init() throws ServletException {

        // =====================================================
        // REPOSITORIO DE TICKETS
        // =====================================================

        TicketRepository ticketRepository =
                new TicketRepositoryJDBC();

        // =====================================================
        // REPOSITORIO DE USUARIOS
        // =====================================================

        UsuarioRepository usuarioRepository =
                new UsuarioRepositoryJDBC();

        // =====================================================
        // ESTRATEGIA DE ASIGNACIÓN
        // =====================================================

        /*
         * AQUÍ DEBE IR LA CLASE CONCRETA QUE IMPLEMENTA
         * EstrategiaAsignacion.
         *
         * Ejemplo:
         *
         * EstrategiaAsignacion estrategiaAsignacion =
         *         new NombreDeTuEstrategia();
         */

        EstrategiaAsignacion estrategiaAsignacion = null;

        // =====================================================
        // SERVICIO DE ASIGNACIÓN
        // =====================================================

        AsignacionService asignacionService =
                new AsignacionService(
                        ticketRepository,
                        usuarioRepository,
                        estrategiaAsignacion
                );

        // =====================================================
        // SERVICIO DE USUARIOS
        // =====================================================

        UsuarioService usuarioService =
                new UsuarioService(
                        usuarioRepository
                );

        // =====================================================
        // ESTRATEGIAS SLA
        // =====================================================

        Map<String, EstrategiaSLA> estrategiasSLA =
                new HashMap<>();

        // =====================================================
        // SERVICIO DE TICKETS
        // =====================================================

        ticketService =
                new TicketService(
                        ticketRepository,
                        asignacionService,
                        usuarioService,
                        estrategiasSLA
                );
    }

    // =========================================================
    // POST /reabrirTicket
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idParametro =
                request.getParameter("id");

        if (idParametro == null
                || idParametro.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/solicitante/misTickets"
            );

            return;
        }

        try {

            int idTicket =
                    Integer.parseInt(
                            idParametro.trim()
                    );

            boolean resultado =
                    ticketService.reabrir(
                            idTicket
                    );

            if (resultado) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/solicitante/misTickets?reabierto=1"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/solicitante/misTickets?error=reabrir"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/solicitante/misTickets?error=id"
            );
        }
    }
}