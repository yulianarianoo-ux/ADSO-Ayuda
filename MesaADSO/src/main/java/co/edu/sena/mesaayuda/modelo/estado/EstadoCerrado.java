package co.edu.sena.mesaayuda.modelo.estado;

/**
 * Estado CERRADO.
 *
 * Un ticket cerrado puede ser reabierto.
 *
 * Transición permitida:
 *
 * CERRADO -> EN_PROCESO
 */
public class EstadoCerrado extends EstadoTicketBase {

    @Override
    public EstadoTicket reabrir() {
        return new EstadoEnProceso();
    }

    @Override
    public String nombre() {
        return "Cerrado";
    }

    @Override
    public int idEstado() {
        return 5;
    }
}