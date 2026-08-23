package co.edu.sena.mesaayuda.servicio.sla;

import co.edu.sena.mesaayuda.modelo.Ticket;

public interface EstrategiaSLA {

    int calcularHoras(Ticket ticket);
}