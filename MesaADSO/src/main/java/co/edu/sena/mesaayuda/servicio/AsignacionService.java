package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.repositorio.TicketRepository;
import co.edu.sena.mesaayuda.repositorio.UsuarioRepository;
import co.edu.sena.mesaayuda.servicio.asignacion.EstrategiaAsignacion;

import java.util.List;

public class AsignacionService
        implements AsignacionServiceInterfaz {

    private final TicketRepository ticketRepository;
    private final UsuarioRepository usuarioRepository;
    private final EstrategiaAsignacion estrategiaAsignacion;

    public AsignacionService(
            TicketRepository ticketRepository,
            UsuarioRepository usuarioRepository,
            EstrategiaAsignacion estrategiaAsignacion) {

        this.ticketRepository = ticketRepository;
        this.usuarioRepository = usuarioRepository;
        this.estrategiaAsignacion = estrategiaAsignacion;
    }

    // =====================================================
    // ASIGNACIÓN AUTOMÁTICA
    // =====================================================

    @Override
    public Usuario asignarAgente(Ticket ticket) {

        if (ticket == null) {
            return null;
        }

        return estrategiaAsignacion.asignar(ticket);
    }

    // =====================================================
    // REASIGNACIÓN MANUAL
    // =====================================================

    @Override
    public boolean reasignarAgente(
            int idTicket,
            int idAgente) {

        Ticket ticket =
                ticketRepository.buscarPorId(idTicket);

        if (ticket == null) {
            return false;
        }

        if (ticket.getCategoria() == null) {
            return false;
        }

        int idCategoria =
                ticket.getCategoria()
                        .getId_categoria();

        List<Usuario> agentesCategoria =
                usuarioRepository.listarAgentesPorCategoria(
                        idCategoria
                );

        boolean agenteValido =
                agentesCategoria.stream()
                        .anyMatch(
                                agente ->
                                        agente.getId_usuario()
                                                == idAgente
                        );

        if (!agenteValido) {
            return false;
        }

        return ticketRepository.reasignarAgente(
                idTicket,
                idAgente
        );
    }
}