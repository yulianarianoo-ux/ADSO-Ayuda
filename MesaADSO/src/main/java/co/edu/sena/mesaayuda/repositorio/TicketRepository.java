package co.edu.sena.mesaayuda.repositorio;

import co.edu.sena.mesaayuda.modelo.Prioridad;
import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.estado.EstadoTicket;

import java.util.List;

/**
 * NOTA (ISP): se elimino listarCategorias() de esta interfaz. Consultar
 * categorias es responsabilidad de CategoriaRepository.listarTodas(),
 * no de TicketRepository.
 *
 * Si en algun lugar usabas ticketRepository.listarCategorias(), inyecta
 * CategoriaRepository ahi y llama a categoriaRepository.listarTodas().
 */
public interface TicketRepository {

    List<Ticket> listarTodos();

    Ticket buscarPorId(int idTicket);

    List<Ticket> listarPorAgente(int idAgente);

    List<Ticket> listarPendientesPorAgente(int idAgente);

    List<Ticket> listarPendientesPorAgenteYPrioridad(
            int idAgente,
            String prioridad);

    List<Ticket> listarPorAgenteYEstado(
            int idAgente,
            int idEstado);

    List<Ticket> listarPorAgenteYPrioridad(
            int idAgente,
            String prioridad);

    List<Ticket> listarPorAgenteEstadoYPrioridad(
            int idAgente,
            int idEstado,
            String prioridad);

    List<EstadoTicket> listarEstados();

    List<Prioridad> listarPrioridades();

    boolean cambiarEstado(
            int idTicket,
            int idEstado);

    boolean reasignarAgente(
            int idTicket,
            int idAgente);

    int contarTicketsActivosPorAgente(
            int idAgente);

    boolean guardar(Ticket ticket);

    boolean eliminar(int idTicket);

    List<Ticket> listarPorSolicitante(int idSolicitante);
}