package co.edu.sena.mesaayuda.modelo.estado;

/**
 * Estado RESUELTO.
 *
 * El ticket fue solucionado por el agente.
 * El solicitante puede confirmar el cierre
 * o reabrirlo si el problema continúa.
 */
public class EstadoResuelto extends EstadoTicketBase {

    @Override
    public EstadoTicket cerrar() {
        return new EstadoCerrado();
    }

    @Override
    public EstadoTicket reabrir() {
        return new EstadoEnProceso();
    }

    @Override
    public String nombre() {
        return "Resuelto";
    }

    @Override
    public int idEstado() {
        return 4;
    }
}