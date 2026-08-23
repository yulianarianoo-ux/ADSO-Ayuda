package co.edu.sena.mesaayuda.servicio.prioridad;

import co.edu.sena.mesaayuda.modelo.Prioridad;
import co.edu.sena.mesaayuda.modelo.Ticket;

import java.util.List;

public interface EstrategiaPrioridad {

    Prioridad determinar(
            Ticket ticket,
            List<Prioridad> prioridades
    );
}