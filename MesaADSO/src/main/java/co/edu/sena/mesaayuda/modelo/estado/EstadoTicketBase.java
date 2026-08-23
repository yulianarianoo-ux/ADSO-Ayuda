package co.edu.sena.mesaayuda.modelo.estado;


public abstract class EstadoTicketBase implements EstadoTicket {

    @Override
    public EstadoTicket asignar() {
        throw transicionInvalida("asignar un agente");
    }

    @Override
    public EstadoTicket iniciar() {
        throw transicionInvalida("iniciar la atención");
    }

    @Override
    public EstadoTicket resolver() {
        throw transicionInvalida("marcar como resuelto");
    }

    @Override
    public EstadoTicket cerrar() {
        throw transicionInvalida("cerrar");
    }

    @Override
    public EstadoTicket reabrir() {
        throw transicionInvalida("reabrir");
    }

    @Override
    public EstadoTicket cancelar() {
        throw transicionInvalida("cancelar");
    }

    private TransicionInvalidaException transicionInvalida(
            String accion) {

        return new TransicionInvalidaException(
                "No se puede "
                + accion
                + " un ticket en estado "
                + nombre()
                + "."
        );
    }
}