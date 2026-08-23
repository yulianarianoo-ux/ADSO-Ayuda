package co.edu.sena.mesaayuda.modelo;

import co.edu.sena.mesaayuda.modelo.estado.EstadoTicket;
import java.util.Date;
import java.util.List;

public class Ticket {

    private int id_ticket;
    private String titulo;
    private String descripcion;

    private Categoria categoria;
    private Prioridad prioridad;

    private Usuario solicitante;
    private Usuario agente;

    private EstadoTicket estado;

    private Date fecha_creacion;

    private List<Comentario> comentarios;

    public Ticket() {
    }

    public Ticket(
            int id_ticket,
            String titulo,
            String descripcion,
            Categoria categoria,
            Prioridad prioridad,
            Usuario solicitante,
            Usuario agente,
            EstadoTicket estado,
            Date fecha_creacion,
            List<Comentario> comentarios) {

        this.id_ticket = id_ticket;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.categoria = categoria;
        this.prioridad = prioridad;
        this.solicitante = solicitante;
        this.agente = agente;
        this.estado = estado;
        this.fecha_creacion = fecha_creacion;
        this.comentarios = comentarios;
    }

    public int getId_ticket() {
        return id_ticket;
    }

    public void setId_ticket(int id_ticket) {
        this.id_ticket = id_ticket;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public Prioridad getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(Prioridad prioridad) {
        this.prioridad = prioridad;
    }

    public Usuario getSolicitante() {
        return solicitante;
    }

    public void setSolicitante(Usuario solicitante) {
        this.solicitante = solicitante;
    }

    public Usuario getAgente() {
        return agente;
    }

    public void setAgente(Usuario agente) {
        this.agente = agente;
    }

    public EstadoTicket getEstado() {
        return estado;
    }

    public void setEstado(EstadoTicket estado) {
        this.estado = estado;
    }

    public Date getFecha_creacion() {
        return fecha_creacion;
    }

    public void setFecha_creacion(Date fecha_creacion) {
        this.fecha_creacion = fecha_creacion;
    }

    public List<Comentario> getComentarios() {
        return comentarios;
    }

    public void setComentarios(List<Comentario> comentarios) {
        this.comentarios = comentarios;
    }
}