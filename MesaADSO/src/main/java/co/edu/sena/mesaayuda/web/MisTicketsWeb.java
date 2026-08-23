package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.dto.TicketDTO;
import co.edu.sena.mesaayuda.mapper.TicketMapper;
import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.servicio.TicketService;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/solicitante/misTickets")
public class MisTicketsWeb extends HttpServlet {

    private TicketService ticketService;

    /*
     * Guarda el último estado conocido de los tickets
     * por cada solicitante.
     *
     * No necesita ninguna tabla adicional en la base de datos.
     */
    private static final Map<Integer, Map<Integer, String>> estadosConocidos =
            new ConcurrentHashMap<>();

    // =========================================================
    // INICIALIZAR
    // =========================================================

    @Override
    public void init() throws ServletException {

        /*
         * El TicketService ya fue creado por AppContextListener.
         *
         * El Servlet solamente lo obtiene del ServletContext.
         *
         * De esta manera:
         *
         * Servlet
         *      ↓
         * TicketService
         *      ↓
         * TicketRepository
         *
         * El Servlet NO crea repositorios ni servicios.
         */

        ticketService = (TicketService) getServletContext()
                .getAttribute(AppContextListener.TICKET_SERVICE);

        if (ticketService == null) {
            throw new ServletException(
                    "No se pudo obtener TicketService del ServletContext."
            );
        }
    }

    // =========================================================
    // GET - MOSTRAR MIS TICKETS
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // =====================================================
        // OBTENER USUARIO DE LA SESIÓN
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
            // OBTENER TICKETS DEL SOLICITANTE
            // =================================================

            List<Ticket> tickets =
                    ticketService.listarPorSolicitante(
                            usuario.getId_usuario()
                    );

            // =================================================
            // DETECTAR CAMBIOS DE ESTADO
            // =================================================

            Map<Integer, String> estadosAnteriores =
                    estadosConocidos.get(
                            usuario.getId_usuario()
                    );

            // =================================================
            // PRIMERA VEZ QUE CONSULTA
            // =================================================

            if (estadosAnteriores == null) {

                estadosAnteriores =
                        new HashMap<>();

                for (Ticket ticket : tickets) {

                    if (ticket.getEstado() != null) {

                        estadosAnteriores.put(
                                ticket.getId_ticket(),
                                ticket.getEstado().nombre()
                        );
                    }
                }

                estadosConocidos.put(
                        usuario.getId_usuario(),
                        estadosAnteriores
                );

            } else {

                // =============================================
                // COMPARAR ESTADOS
                // =============================================

                StringBuilder mensaje =
                        new StringBuilder();

                Map<Integer, String> estadosActuales =
                        new HashMap<>();

                for (Ticket ticket : tickets) {

                    if (ticket.getEstado() == null) {
                        continue;
                    }

                    int idTicket =
                            ticket.getId_ticket();

                    String estadoActual =
                            ticket.getEstado().nombre();

                    estadosActuales.put(
                            idTicket,
                            estadoActual
                    );

                    String estadoAnterior =
                            estadosAnteriores.get(
                                    idTicket
                            );

                    // =========================================
                    // CAMBIO DE ESTADO DETECTADO
                    // =========================================

                    if (estadoAnterior != null
                            && !estadoAnterior.equalsIgnoreCase(
                                    estadoActual
                            )) {

                        if (mensaje.length() > 0) {
                            mensaje.append("<br><br>");
                        }

                        mensaje.append(
                                "El ticket #"
                        );

                        mensaje.append(
                                idTicket
                        );

                        mensaje.append(
                                " cambió de <b>"
                        );

                        mensaje.append(
                                escaparHtml(
                                        estadoAnterior
                                )
                        );

                        mensaje.append(
                                "</b> a <b>"
                        );

                        mensaje.append(
                                escaparHtml(
                                        estadoActual
                                )
                        );

                        mensaje.append(
                                "</b>."
                        );
                    }
                }

                // =============================================
                // GUARDAR ESTADOS ACTUALES
                // =============================================

                estadosConocidos.put(
                        usuario.getId_usuario(),
                        estadosActuales
                );

                // =============================================
                // ENVIAR NOTIFICACIÓN
                // =============================================

                if (mensaje.length() > 0) {

                    request.setAttribute(
                            "notificacionEstado",
                            mensaje.toString()
                    );
                }
            }

            // =================================================
            // CONVERTIR DOMINIO → DTO
            // =================================================

            /*
             * Aquí aplicamos CC-04:
             *
             * Ticket
             *    ↓
             * TicketMapper
             *    ↓
             * TicketDTO
             *    ↓
             * JSP
             *
             * El JSP no recibe directamente objetos del dominio.
             */

            List<TicketDTO> ticketsDTO =
                    tickets.stream()
                            .map(ticket -> {

                                TicketDTO dto =
                                        TicketMapper.toDTO(ticket);

                                /*
                                 * El SLA se calcula en el Service,
                                 * no en el JSP.
                                 */
                                dto.setHorasSLA(
                                        ticketService.calcularHorasSLA(
                                                ticket
                                        )
                                );

                                return dto;
                            })
                            .collect(Collectors.toList());

            // =================================================
            // ENVIAR DTOs AL JSP
            // =================================================

            request.setAttribute(
                    "tickets",
                    ticketsDTO
            );

            // =================================================
            // ABRIR JSP
            // =================================================

            request.getRequestDispatcher(
                    "/misTickets.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType(
                    "text/html;charset=UTF-8"
            );

            response.getWriter().println(
                    "<h2>Error al cargar Mis Tickets</h2>"
            );

            response.getWriter().println(
                    "<p>"
                    + escaparHtml(e.getMessage())
                    + "</p>"
            );
        }
    }

    // =========================================================
    // ESCAPAR HTML
    // =========================================================

    private String escaparHtml(String texto) {

        if (texto == null) {
            return "";
        }

        return texto
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}