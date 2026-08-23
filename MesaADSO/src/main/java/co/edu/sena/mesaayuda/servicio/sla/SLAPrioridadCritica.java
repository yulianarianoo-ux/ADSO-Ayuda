package co.edu.sena.mesaayuda.servicio.sla;

import co.edu.sena.mesaayuda.modelo.Ticket;

public class SLAPrioridadCritica implements EstrategiaSLA {

    @Override
    public int calcularHoras(Ticket ticket) {

        if (ticket == null
                || ticket.getPrioridad() == null) {
            return 0;
        }

        return ticket.getPrioridad().getSla_horas();
    }
}