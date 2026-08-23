package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;

public interface AsignacionServiceInterfaz {

    // ASIGNACIÓN AUTOMÁTICA
    Usuario asignarAgente(Ticket ticket);

    // REASIGNACIÓN MANUAL
    boolean reasignarAgente(int idTicket, int idAgente);
}