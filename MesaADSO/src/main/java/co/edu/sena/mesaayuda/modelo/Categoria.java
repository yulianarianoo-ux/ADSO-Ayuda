/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.edu.sena.mesaayuda.modelo;

/**
 *
 * @author User
 */
public class Categoria {
    private int id_categoria;
    private String nombre_categoria;

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    public String getnombre_categoria() {
        return nombre_categoria;
    }

    public void setnombre_categoria(String nombre_categoria) {
        this.nombre_categoria = nombre_categoria;
    }

    public Categoria(int id_categoria, String nombre_categoria) {
        this.id_categoria = id_categoria;
        this.nombre_categoria = nombre_categoria;
    }
    
    public Categoria(){
        
    }
}
