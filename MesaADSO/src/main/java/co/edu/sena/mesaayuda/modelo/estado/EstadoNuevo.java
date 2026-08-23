package co.edu.sena.mesaayuda.modelo.estado;

public class EstadoNuevo extends EstadoTicketBase {

    @Override
    public EstadoTicket asignar() {
        return new EstadoAsignado();
    }

    @Override
    public EstadoTicket cancelar() {
        return new EstadoCancelado();
    }

    @Override
    public String nombre() {
        return "Nuevo";
    }

    @Override
    public int idEstado() {
        return 1;
    }
}