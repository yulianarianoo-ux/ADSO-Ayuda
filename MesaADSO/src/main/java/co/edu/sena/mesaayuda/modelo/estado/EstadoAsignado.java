package co.edu.sena.mesaayuda.modelo.estado;

public class EstadoAsignado extends EstadoTicketBase {

    @Override
    public EstadoTicket iniciar() {
        return new EstadoEnProceso();
    }

    @Override
    public EstadoTicket cancelar() {
        return new EstadoCancelado();
    }

    @Override
    public String nombre() {
        return "Asignado";
    }

    @Override
    public int idEstado() {
        return 2;
    }
}