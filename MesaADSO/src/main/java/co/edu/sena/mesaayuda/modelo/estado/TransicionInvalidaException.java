package co.edu.sena.mesaayuda.modelo.estado;

/**
 * Se lanza cuando se intenta una transicion que el estado actual del
 * ticket no permite (por ejemplo, cerrar un ticket NUEVO sin resolverlo).
 */
public class TransicionInvalidaException extends RuntimeException {

    public TransicionInvalidaException(String mensaje) {
        super(mensaje);
    }
}