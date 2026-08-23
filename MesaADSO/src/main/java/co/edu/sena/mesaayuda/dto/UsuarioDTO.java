package co.edu.sena.mesaayuda.dto;

import co.edu.sena.mesaayuda.modelo.Rol;

public class UsuarioDTO {

    private int id_usuario;
    private String nombre;
    private String correo;
    private Rol rol;

    public UsuarioDTO() {
    }

    public UsuarioDTO(int id_usuario, String nombre, String correo, Rol rol) {
        this.id_usuario = id_usuario;
        this.nombre = nombre;
        this.correo = correo;
        this.rol = rol;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }
}