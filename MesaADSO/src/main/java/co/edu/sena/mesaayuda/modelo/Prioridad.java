package co.edu.sena.mesaayuda.modelo;

public class Prioridad {

    private int id_prioridad;
    private String tipo_prioridad;
    private int las_horas;

    public Prioridad() {
    }

    public Prioridad(int id_prioridad, String tipo_prioridad, int las_horas) {
        this.id_prioridad = id_prioridad;
        this.tipo_prioridad = tipo_prioridad;
        this.las_horas = las_horas;
    }

    public int getId_prioridad() {
        return id_prioridad;
    }

    public void setId_prioridad(int id_prioridad) {
        this.id_prioridad = id_prioridad;
    }

    public String gettipo_prioridad() {
        return tipo_prioridad;
    }

    public void settipo_prioridad(String tipo_prioridad) {
        this.tipo_prioridad = tipo_prioridad;
    }

    public int getSla_horas() {
        return las_horas;
    }

    public void setSla_horas(int sla_horas) {
        this.las_horas = sla_horas;
    }
}