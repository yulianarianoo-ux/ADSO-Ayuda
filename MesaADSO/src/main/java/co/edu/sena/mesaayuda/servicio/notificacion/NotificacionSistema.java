package co.edu.sena.mesaayuda.servicio.notificacion;

public class NotificacionSistema implements EstrategiaNotificacion {

    @Override
    public void enviar(String destinatario, String mensaje) {
        System.out.println("Enviando notificación dentro del sistema a: " + destinatario);
        System.out.println("Mensaje: " + mensaje);
    }
}