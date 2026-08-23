package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.modelo.Comentario;
import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.servicio.ComentarioService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet(urlPatterns = {
    "/comentarios",
    "/agregarComentario"
})
public class ComentarioWeb extends HttpServlet {

    private ComentarioService comentarioService;

    // =====================================================
    // INICIALIZAR (DIP-01)
    // =====================================================
    // ANTES: este Servlet instanciaba "new ComentarioRepositoryJDBC()"
    // y "new ComentarioService(...)" por su cuenta, con lo cual
    // dependia de una clase CONCRETA en vez de una interfaz inyectada,
    // y creaba un segundo composition root distinto al de
    // AppContextListener. Ahora toma la MISMA instancia que ya arma
    // AppContextListener al arrancar la aplicacion, igual que hace
    // AtenderTicketsWeb con TicketService.
    @Override
    public void init() {
        comentarioService = (ComentarioService) getServletContext()
                .getAttribute(AppContextListener.COMENTARIO_SERVICE);
    }

    // =========================================================
    // GET
    // /comentarios?idTicket=24
    // DEVUELVE LOS COMENTARIOS EN JSON
    // =========================================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idTicketParam =
                request.getParameter("idTicket");

        if (idTicketParam == null ||
            idTicketParam.trim().isEmpty()) {

            idTicketParam =
                    request.getParameter("id_ticket");
        }

        if (idTicketParam == null ||
            idTicketParam.trim().isEmpty()) {

            response.setStatus(
                    HttpServletResponse.SC_BAD_REQUEST
            );

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            response.getWriter().write(
                    "{\"error\":\"No se recibió el ID del ticket.\"}"
            );

            return;
        }

        try {

            int idTicket =
                    Integer.parseInt(
                            idTicketParam
                    );

            List<Comentario> comentarios =
                    comentarioService.listarPorTicket(
                            idTicket
                    );

            response.setContentType(
                    "application/json"
            );

            response.setCharacterEncoding(
                    "UTF-8"
            );

            StringBuilder json =
                    new StringBuilder();

            json.append("[");

            SimpleDateFormat formato =
                    new SimpleDateFormat(
                            "dd/MM/yyyy HH:mm"
                    );

            for (int i = 0;
                 i < comentarios.size();
                 i++) {

                Comentario c =
                        comentarios.get(i);

                String autor = "";
                String mensaje = "";
                String fecha = "";

                // AUTOR
                if (c.getUsuario() != null) {

                    autor =
                            c.getUsuario()
                             .getnombre_usuario();
                }

                // MENSAJE
                if (c.getTexto() != null) {

                    mensaje =
                            c.getTexto();
                }

                // FECHA
                if (c.getFecha() != null) {

                    fecha =
                            formato.format(
                                    c.getFecha()
                            );
                }

                json.append("{");

                json.append("\"autor\":\"")
                    .append(
                        escaparJson(autor)
                    )
                    .append("\",");

                json.append("\"mensaje\":\"")
                    .append(
                        escaparJson(mensaje)
                    )
                    .append("\",");

                json.append("\"fecha\":\"")
                    .append(
                        escaparJson(fecha)
                    )
                    .append("\"");

                json.append("}");

                if (i < comentarios.size() - 1) {

                    json.append(",");
                }
            }

            json.append("]");

            response.getWriter()
                    .write(
                            json.toString()
                    );

        } catch (NumberFormatException e) {

            response.setStatus(
                    HttpServletResponse.SC_BAD_REQUEST
            );

            response.setContentType(
                    "application/json"
            );

            response.setCharacterEncoding(
                    "UTF-8"
            );

            response.getWriter().write(
                    "{\"error\":\"El ID del ticket no es válido.\"}"
            );
        }
    }

    // =========================================================
    // POST
    // GUARDAR / EDITAR COMENTARIO
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession();

        try {

            // =================================================
            // USUARIO LOGUEADO
            // =================================================

            Usuario usuario =
                    (Usuario) session.getAttribute(
                            "usuario"
                    );

            if (usuario == null) {

                response.setStatus(
                        HttpServletResponse.SC_UNAUTHORIZED
                );

                response.getWriter().write(
                        "Debe iniciar sesión para comentar."
                );

                return;
            }

            // =================================================
            // RECIBIR DATOS
            // =================================================

            String idTicketParam =
                    request.getParameter("idTicket");

            if (idTicketParam == null ||
                idTicketParam.trim().isEmpty()) {

                idTicketParam =
                        request.getParameter("id_ticket");
            }

            String texto =
                    request.getParameter("comentario");

            if (texto == null ||
                texto.trim().isEmpty()) {

                texto =
                        request.getParameter("texto");
            }

            String action =
                    request.getParameter("action");

            String idComentarioParam =
                    request.getParameter(
                            "id_comentario"
                    );

            // =================================================
            // VALIDAR TEXTO
            // =================================================

            if (texto == null ||
                texto.trim().isEmpty()) {

                response.setStatus(
                        HttpServletResponse.SC_BAD_REQUEST
                );

                response.getWriter().write(
                        "El comentario no puede estar vacío."
                );

                return;
            }

            // =================================================
            // EDITAR COMENTARIO
            // =================================================

            if ("editar".equalsIgnoreCase(action)) {

                if (idComentarioParam == null ||
                    idComentarioParam.trim().isEmpty()) {

                    response.setStatus(
                            HttpServletResponse.SC_BAD_REQUEST
                    );

                    response.getWriter().write(
                            "No se recibió el ID del comentario."
                    );

                    return;
                }

                int idComentario =
                        Integer.parseInt(
                                idComentarioParam
                        );

                // =================================================
                // VALIDAR DUEÑO DEL COMENTARIO
                // =================================================

                Comentario comentarioExistente =
                        comentarioService.buscarPorId(
                                idComentario
                        );

                if (comentarioExistente == null) {

                    response.setStatus(
                            HttpServletResponse.SC_NOT_FOUND
                    );

                    response.getWriter().write(
                            "El comentario no existe."
                    );

                    return;
                }

                if (comentarioExistente.getUsuario() == null ||
                    comentarioExistente.getUsuario().getId_usuario()
                        != usuario.getId_usuario()) {

                    response.setStatus(
                            HttpServletResponse.SC_FORBIDDEN
                    );

                    response.getWriter().write(
                            "No tiene permiso para editar este comentario."
                    );

                    return;
                }

                Comentario comentario =
                        new Comentario();

                comentario.setId_comentario(
                        idComentario
                );

                comentario.setTexto(
                        texto.trim()
                );

                boolean actualizado =
                        comentarioService.actualizar(
                                comentario
                        );

                if (!actualizado) {

                    response.setStatus(
                            HttpServletResponse.SC_INTERNAL_SERVER_ERROR
                    );

                    response.getWriter().write(
                            "No se pudo actualizar el comentario."
                    );

                    return;
                }

                response.getWriter().write(
                        "Comentario actualizado correctamente."
                );

                return;
            }

            // =================================================
            // NUEVO COMENTARIO
            // =================================================

            if (idTicketParam == null ||
                idTicketParam.trim().isEmpty()) {

                response.setStatus(
                        HttpServletResponse.SC_BAD_REQUEST
                );

                response.getWriter().write(
                        "No se recibió el ID del ticket."
                );

                return;
            }

            int idTicket =
                    Integer.parseInt(
                            idTicketParam
                    );

            // =================================================
            // CREAR TICKET
            // =================================================

            Ticket ticket =
                    new Ticket();

            ticket.setId_ticket(
                    idTicket
            );

            // =================================================
            // CREAR COMENTARIO
            // =================================================

            Comentario comentario =
                    new Comentario();

            comentario.setTicket(
                    ticket
            );

            comentario.setUsuario(
                    usuario
            );

            comentario.setTexto(
                    texto.trim()
            );

            // =================================================
            // GUARDAR
            // =================================================

            boolean guardado =
                    comentarioService.guardar(
                            comentario
                    );

            if (!guardado) {

                response.setStatus(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR
                );

                response.getWriter().write(
                        "No se pudo guardar el comentario."
                );

                return;
            }

            // =================================================
            // RESPUESTA AJAX
            // =================================================

            response.setStatus(
                    HttpServletResponse.SC_OK
            );

            response.getWriter().write(
                    "Comentario guardado correctamente."
            );

        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.setStatus(
                    HttpServletResponse.SC_BAD_REQUEST
            );

            response.getWriter().write(
                    "El ID recibido no es válido."
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.setStatus(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR
            );

            response.getWriter().write(
                    "Ocurrió un error al guardar el comentario."
            );
        }
    }

    // =========================================================
    // ESCAPAR JSON
    // =========================================================

    private String escaparJson(String texto) {

        if (texto == null) {

            return "";
        }

        return texto
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\r", "\\r")
                .replace("\n", "\\n")
                .replace("\t", "\\t");
    }
}