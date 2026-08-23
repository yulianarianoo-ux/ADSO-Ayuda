package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.modelo.Prioridad;
import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.modelo.estado.EstadoTicket;

import java.util.List;
import java.util.Map;

public interface TicketServiceInterfaz {

    List<Ticket> listarTodos();

    List<Ticket> listarPorSolicitante(int idSolicitante);

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

    List<Ticket> listarTicketsParaAgente(
            int idAgente,
            String estado,
            String prioridad);

    Map<Integer, List<Usuario>> listarAgentesPorTicket(
            List<Ticket> tickets);

    boolean perteneceAlAgente(
            int idTicket,
            int idAgente);

    List<EstadoTicket> listarEstados();

    List<Prioridad> listarPrioridades();

    Prioridad calcularPrioridad(Ticket ticket);

    boolean guardar(Ticket ticket);

    Usuario asignarAgente(Ticket ticket);

    boolean reasignarAgente(
            int idTicket,
            int idAgente);

    int contarTicketsActivosPorAgente(
            int idAgente);

    int calcularHorasSLA(Ticket ticket);

    boolean asignar(int idTicket);

    boolean iniciarAtencion(int idTicket);

    boolean resolver(int idTicket);

    boolean cerrar(int idTicket);

    boolean reabrir(int idTicket);

    boolean cancelar(int idTicket);

    boolean cambiarEstado(
            int idTicket,
            String accion);

    boolean avanzarEstado(int idTicket);

    boolean eliminarTicket(int idTicket);
}