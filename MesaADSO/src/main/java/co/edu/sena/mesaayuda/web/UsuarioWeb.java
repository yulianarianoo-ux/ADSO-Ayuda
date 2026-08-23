package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.servicio.UsuarioService;
import co.edu.sena.mesaayuda.modelo.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/UsuarioWeb")
public class UsuarioWeb extends HttpServlet {

    private UsuarioService usuarioService;

  @Override
public void init() {
    usuarioService = (UsuarioService)
            getServletContext()
                    .getAttribute(AppContextListener.USUARIO_SERVICE);
}

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        Usuario usuario = usuarioService.autenticar(
                correo,
                contrasena
        );

        if (usuario != null) {

            // Guardar usuario en sesión
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);

            // Obtener el rol
String rol = usuario.getRol().getTipoRol();
            // Mensaje de bienvenida
            session.setAttribute(
                    "exito",
                    "¡Bienvenido, " + usuario.getnombre_usuario()
                    + "! 👋 Has iniciado sesión como "
                    + rol + "."
            );

         
            String paginaDestino;//Deteminamos el pnael segun el rol 

            if ("Administrador".equalsIgnoreCase(rol)) {

                paginaDestino = "PanelPrincipal.jsp";

            } else if ("Agente".equalsIgnoreCase(rol)) {

                paginaDestino = "PanelAgente.jsp";

            } else if ("Solicitante".equalsIgnoreCase(rol)) {

    paginaDestino = "/PanelSolicitante.jsp";

} else {

                // Si el rol no existe por defecto se establece un destino por defecto
                paginaDestino = "PanelPrincipal.jsp";
            }

            // Guardar destino en sesión
            session.setAttribute(
                    "paginaDestino",
                    paginaDestino
            );

            // Ir a la bienvenida
            response.sendRedirect(
                    request.getContextPath()
                    + "/Bienvenida.jsp"
            );

        } else {

            request.setAttribute(
                    "error",
                    "El correo o la contraseña son incorrectos."
            );

            request.getRequestDispatcher("/Login.jsp")
                    .forward(request, response);
        }
    }
}