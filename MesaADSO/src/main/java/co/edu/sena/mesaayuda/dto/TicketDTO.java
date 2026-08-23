package co.edu.sena.mesaayuda.dto;

import co.edu.sena.mesaayuda.modelo.Comentario;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TicketDTO {

    private int id_ticket;
    private String titulo;
    private String descripcion;

    private int id_categoria;
    private String categoria;

    private String prioridad;
    private String solicitante;
    private String agente;
    private String estado;
    private Date fecha_creacion;

    // =====================================================
    // SLA
    // =====================================================

    private int horasSLA;//Guarda las horas segun la prioridad 

    // =====================================================
    // COMENTARIOS
    // =====================================================

    private List<Comentario> comentarios = new ArrayList<>();//Permite que un ticket tenga una lista de comentarios 

    // =====================================================
    // CONSTRUCTOR VACÍO
    // =====================================================

    public TicketDTO() {//Permite crear un DTO vacio y despues llenar los datos mediante los setters 
    }

    // =====================================================
    // CONSTRUCTOR
    // =====================================================

    public TicketDTO(
            int id_ticket,
            String titulo,
            String descripcion,
            int id_categoria,
            String categoria,
            String prioridad,
            String solicitante,
            String agente,
            String estado,
            Date fecha_creacion) {

        this.id_ticket = id_ticket;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.id_categoria = id_categoria;
        this.categoria = categoria;
        this.prioridad = prioridad;
        this.solicitante = solicitante;
        this.agente = agente;
        this.estado = estado;
        this.fecha_creacion = fecha_creacion;
    }//pasa un dto pasando varios datos a la vez

    // =====================================================
    // GETTERS Y SETTERS
    // =====================================================

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

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(String prioridad) {
        this.prioridad = prioridad;
    }

    public String getSolicitante() {
        return solicitante;
    }

    public void setSolicitante(String solicitante) {
        this.solicitante = solicitante;
    }

    public String getAgente() {
        return agente;
    }

    public void setAgente(String agente) {
        this.agente = agente;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getFecha_creacion() {
        return fecha_creacion;
    }

    public void setFecha_creacion(Date fecha_creacion) {
        this.fecha_creacion = fecha_creacion;
    }

    // =====================================================
    // SLA
    // =====================================================

    public int getHorasSLA() {
        return horasSLA;
    }

    public void setHorasSLA(int horasSLA) {
        this.horasSLA = horasSLA;
    }

    // =====================================================
    // COMENTARIOS
    // =====================================================

    public List<Comentario> getComentarios() {
        return comentarios;
    }

    public void setComentarios(List<Comentario> comentarios) {
        this.comentarios = comentarios;
    }
}