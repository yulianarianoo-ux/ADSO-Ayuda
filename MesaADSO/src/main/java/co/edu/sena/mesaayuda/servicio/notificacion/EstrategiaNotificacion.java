package co.edu.sena.mesaayuda.servicio.notificacion;

public interface EstrategiaNotificacion {

    void enviar(String destinatario, String mensaje);
}