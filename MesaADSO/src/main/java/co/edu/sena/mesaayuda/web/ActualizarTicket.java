package co.edu.sena.mesaayuda.web;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/actualizarTicket")
public class ActualizarTicket extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
request.getParameter("id_ticket");
request.getParameter("id_estado");


        response.setStatus(HttpServletResponse.SC_OK);
    }
}