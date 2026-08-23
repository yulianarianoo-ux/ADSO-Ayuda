package co.edu.sena.mesaayuda.modelo.estado;

public class EstadoEnProceso extends EstadoTicketBase {

    @Override
    public EstadoTicket resolver() {
        return new EstadoResuelto();
    }

    @Override
    public EstadoTicket cancelar() {
        return new EstadoCancelado();
    }

    @Override
    public String nombre() {
        return "En Proceso";
    }

    @Override
    public int idEstado() {
        return 3;
    }
}