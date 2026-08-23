/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.edu.sena.mesaayuda.modelo;

/**
 *
 * @author User
 */
public class Rol {
    
    private int id_rol;
    private String tipo_rol;

    public int getId_rol() {
        return id_rol;
    }

    public void setId_rol(int id_rol) {
        this.id_rol = id_rol;
    }

   public String getTipoRol() {       
    return tipo_rol;
}
public void setTipoRol(String tipoRol) {  
    this.tipo_rol = tipoRol;
}

    public Rol(int id_rol, String nombre) {
        this.id_rol = id_rol;
        this.tipo_rol = nombre;
    }
    public Rol()
    {
        
    }
    
    
}
