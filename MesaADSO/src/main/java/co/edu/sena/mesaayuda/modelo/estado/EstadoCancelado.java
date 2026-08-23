package co.edu.sena.mesaayuda.modelo.estado;


public class EstadoCancelado extends EstadoTicketBase {

    @Override
    public EstadoTicket cancelar() {
        // El estado ya es CANCELADO.
        return this;
    }

    @Override
    public String nombre() {
        return "Cancelado";
    }

    @Override
    public int idEstado() {
        return 6;
    }
}