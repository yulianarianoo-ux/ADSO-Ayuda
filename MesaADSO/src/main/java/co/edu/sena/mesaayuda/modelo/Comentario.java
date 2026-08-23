package co.edu.sena.mesaayuda.modelo;

import java.util.Date;

public class Comentario {

    private int id_comentario;
    private Ticket ticket;
    private Usuario usuario;
    private String texto;
    private Date fecha;

    public Comentario() {
    }

    public Comentario(
            int id_comentario,
            Ticket ticket,
            Usuario usuario,
            String texto,
            Date fecha) {

        this.id_comentario = id_comentario;
        this.ticket = ticket;
        this.usuario = usuario;
        this.texto = texto;
        this.fecha = fecha;
    }

    public int getId_comentario() {
        return id_comentario;
    }

    public void setId_comentario(int id_comentario) {
        this.id_comentario = id_comentario;
    }

    public Ticket getTicket() {
        return ticket;
    }

    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
}