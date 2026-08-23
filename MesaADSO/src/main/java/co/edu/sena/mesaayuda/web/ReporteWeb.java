package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.servicio.ReporteService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/reportes")
public class ReporteWeb extends HttpServlet {

    private ReporteService reporteService;

    @Override
    public void init() throws ServletException {

        reporteService = (ReporteService) getServletContext()
                .getAttribute(AppContextListener.REPORTE_SERVICE);

        if (reporteService == null) {
            throw new ServletException(
                    "ReporteService no fue inicializado."
            );
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(
                    request.getContextPath() + "/Login.jsp"
            );
            return;
        }

        Usuario usuarioSesion =
                (Usuario) session.getAttribute("usuario");

        if (usuarioSesion == null) {
            response.sendRedirect(
                    request.getContextPath() + "/Login.jsp"
            );
            return;
        }

        // Validar administrador
        if (usuarioSesion.getRol() == null
                || !"ADMINISTRADOR".equalsIgnoreCase(
                        usuarioSesion.getRol().getTipoRol())) {

            session.setAttribute(
                    "mensajeError",
                    "No tienes permiso para acceder a los reportes."
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/PanelPrincipal.jsp"
            );

            return;
        }

        try {

            int totalTickets =
                    reporteService.totalTickets();

            List<Map<String, Object>> ticketsEstado =
                    reporteService.ticketsPorEstado();

            List<Map<String, Object>> ticketsPrioridad =
                    reporteService.ticketsPorPrioridad();

            List<Map<String, Object>> ticketsCategoria =
                    reporteService.ticketsPorCategoria();

            List<Map<String, Object>> ticketsAgente =
                    reporteService.ticketsPorAgente();

            int slasVencidos =
                    reporteService.slasVencidos();

            request.setAttribute(
                    "totalTickets",
                    totalTickets
            );

            request.setAttribute(
                    "ticketsEstado",
                    ticketsEstado
            );

            request.setAttribute(
                    "ticketsPrioridad",
                    ticketsPrioridad
            );

            request.setAttribute(
                    "ticketsCategoria",
                    ticketsCategoria
            );

            request.setAttribute(
                    "ticketsAgente",
                    ticketsAgente
            );

            request.setAttribute(
                    "slasVencidos",
                    slasVencidos
            );

            // IMPORTANTE:
            // Este archivo debe estar en:
            // src/main/webapp/Reportes.jsp

            request.getRequestDispatcher(
                    "/Reporte.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            session.setAttribute(
                    "mensajeError",
                    "No fue posible cargar los reportes: "
                            + e.getMessage()
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/PanelPrincipal.jsp"
            );
        }
    }
}