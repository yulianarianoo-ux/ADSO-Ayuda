package co.edu.sena.mesaayuda.servicio.asignacion;

import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.repositorio.TicketRepository;
import co.edu.sena.mesaayuda.repositorio.UsuarioRepository;

import java.util.List;

public class AsignacionPorCategoria
        implements EstrategiaAsignacion {

    private UsuarioRepository usuarioRepository;
    private TicketRepository ticketRepository;

    public AsignacionPorCategoria(
            UsuarioRepository usuarioRepository,
            TicketRepository ticketRepository) {

        this.usuarioRepository =
                usuarioRepository;

        this.ticketRepository =
                ticketRepository;
    }

    @Override
    public Usuario asignar(Ticket ticket) {

        if (ticket == null
                || ticket.getCategoria() == null) {

            System.out.println(
                    "No se puede asignar el ticket "
                    + "porque no tiene categoría."
            );

            return null;
        }

        int idCategoria =
                ticket.getCategoria()
                        .getId_categoria();

        String nombreCategoria =
                ticket.getCategoria()
                        .getnombre_categoria();

        System.out.println(
                "Buscando agentes para la categoría: "
                + nombreCategoria
        );

        List<Usuario> agentes =
                usuarioRepository
                        .listarAgentesPorCategoria(
                                idCategoria
                        );

        if (agentes == null
                || agentes.isEmpty()) {

            System.out.println(
                    "No hay agentes disponibles "
                    + "para la categoría: "
                    + nombreCategoria
            );

            return null;
        }

        Usuario agenteSeleccionado = null;

        int menorCarga =
                Integer.MAX_VALUE;

        for (Usuario agente : agentes) {

            int carga =
                    ticketRepository
                            .contarTicketsActivosPorAgente(
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

                agenteSeleccionado =
                        agente;
            }
        }

        if (agenteSeleccionado != null) {

            System.out.println(
                    "Ticket "
                    + ticket.getId_ticket()
                    + " asignado a "
                    + agenteSeleccionado
                            .getnombre_usuario()
                    + " | Categoría: "
                    + nombreCategoria
                    + " | Carga: "
                    + menorCarga
            );
        }

        return agenteSeleccionado;
    }
}