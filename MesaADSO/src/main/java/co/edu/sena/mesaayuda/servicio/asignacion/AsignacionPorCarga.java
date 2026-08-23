package co.edu.sena.mesaayuda.servicio.asignacion;

import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.repositorio.TicketRepository;

import java.util.List;

public class AsignacionPorCarga implements EstrategiaAsignacion {

    private TicketRepository ticketRepository;
    private List<Usuario> agentes;

    public AsignacionPorCarga(
            TicketRepository ticketRepository,
            List<Usuario> agentes) {

        this.ticketRepository = ticketRepository;
        this.agentes = agentes;
    }

    @Override
    public Usuario asignar(Ticket ticket) {

        System.out.println(
                "Asignando ticket al agente con menor carga."
        );

        if (agentes == null || agentes.isEmpty()) {
            System.out.println("No hay agentes disponibles.");
            return null;
        }

        Usuario agenteSeleccionado = null;
        int menorCarga = Integer.MAX_VALUE;

        for (Usuario agente : agentes) {

            int carga =
                    ticketRepository.contarTicketsActivosPorAgente(
                            agente.getId_usuario()
                    );

            System.out.println(
                    "Agente: "
                    + agente.getnombre_usuario()
                    + " | Tickets activos: "
                    + carga
            );

            if (carga < menorCarga) {

                menorCarga = carga;
                agenteSeleccionado = agente;
            }
        }

        if (agenteSeleccionado != null) {

            System.out.println(
                    "Ticket "
                    + ticket.getId_ticket()
                    + " asignado a "
                    + agenteSeleccionado.getnombre_usuario()
            );
        }

        return agenteSeleccionado;
    }
}