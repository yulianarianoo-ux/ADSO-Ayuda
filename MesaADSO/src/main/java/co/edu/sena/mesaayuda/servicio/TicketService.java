package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.modelo.Prioridad;
import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.modelo.estado.EstadoTicket;

import co.edu.sena.mesaayuda.repositorio.TicketRepository;

import co.edu.sena.mesaayuda.servicio.sla.EstrategiaSLA;

import java.text.Normalizer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servicio encargado de las operaciones relacionadas con los tickets.
 *
 * Se encarga de coordinar:
 * - Consultas de tickets.
 * - Gestión de estados.
 * - Cálculo del SLA.
 * - Prioridades.
 * - Filtros de tickets.
 * - Validación de pertenencia de tickets.
 * - Gestión de agentes asociados a los tickets.
 *
 * No contiene código JDBC ni acceso directo a la base de datos.
 */
public class TicketService
        implements TicketServiceInterfaz {

    private final TicketRepository ticketRepository;
    private final AsignacionServiceInterfaz asignacionService;
    private final UsuarioService usuarioService;
    private final Map<String, EstrategiaSLA> estrategiasSLA;

    // =====================================================
    // CONSTRUCTOR
    // =====================================================

    public TicketService(
            TicketRepository ticketRepository,
            AsignacionServiceInterfaz asignacionService,
            UsuarioService usuarioService,
            Map<String, EstrategiaSLA> estrategiasSLA) {

        this.ticketRepository = ticketRepository;
        this.asignacionService = asignacionService;
        this.usuarioService = usuarioService;
        this.estrategiasSLA = estrategiasSLA;
    }

    // =====================================================
    // LISTAR TODOS
    // =====================================================

    @Override
    public List<Ticket> listarTodos() {

        return ticketRepository.listarTodos();
    }

    // =====================================================
    // LISTAR POR SOLICITANTE
    // =====================================================

    @Override
    public List<Ticket> listarPorSolicitante(
            int idSolicitante) {

        return ticketRepository.listarPorSolicitante(
                idSolicitante
        );
    }

    // =====================================================
    // BUSCAR POR ID
    // =====================================================

    @Override
    public Ticket buscarPorId(int idTicket) {

        return ticketRepository.buscarPorId(idTicket);
    }

    // =====================================================
    // LISTAR POR AGENTE
    // =====================================================

    @Override
    public List<Ticket> listarPorAgente(int idAgente) {

        return ticketRepository.listarPorAgente(
                idAgente
        );
    }

    // =====================================================
    // LISTAR PENDIENTES POR AGENTE
    // =====================================================

    @Override
    public List<Ticket> listarPendientesPorAgente(
            int idAgente) {

        return ticketRepository.listarPendientesPorAgente(
                idAgente
        );
    }

    // =====================================================
    // LISTAR PENDIENTES POR AGENTE Y PRIORIDAD
    // =====================================================

    @Override
    public List<Ticket> listarPendientesPorAgenteYPrioridad(
            int idAgente,
            String prioridad) {

        return ticketRepository.listarPendientesPorAgenteYPrioridad(
                idAgente,
                prioridad
        );
    }

    // =====================================================
    // LISTAR POR AGENTE Y ESTADO
    // =====================================================

    @Override
    public List<Ticket> listarPorAgenteYEstado(
            int idAgente,
            int idEstado) {

        return ticketRepository.listarPorAgenteYEstado(
                idAgente,
                idEstado
        );
    }

    // =====================================================
    // LISTAR POR AGENTE Y PRIORIDAD
    // =====================================================

    @Override
    public List<Ticket> listarPorAgenteYPrioridad(
            int idAgente,
            String prioridad) {

        return ticketRepository.listarPorAgenteYPrioridad(
                idAgente,
                prioridad
        );
    }

    // =====================================================
    // LISTAR POR AGENTE + ESTADO + PRIORIDAD
    // =====================================================

    @Override
    public List<Ticket> listarPorAgenteEstadoYPrioridad(
            int idAgente,
            int idEstado,
            String prioridad) {

        return ticketRepository.listarPorAgenteEstadoYPrioridad(
                idAgente,
                idEstado,
                prioridad
        );
    }

    // =====================================================
    // FILTRAR TICKETS DEL AGENTE
    // =====================================================

    @Override
    public List<Ticket> listarTicketsParaAgente(
            int idAgente,
            String estado,
            String prioridad) {

        if (estado == null
                || estado.trim().isEmpty()) {

            estado = "TODOS";
        }

        if (prioridad == null
                || prioridad.trim().isEmpty()) {

            prioridad = "TODAS";
        }

        estado = estado.trim();
        prioridad = prioridad.trim();

        // =================================================
        // PENDIENTES + PRIORIDAD
        // =================================================

        if ("PENDIENTES".equalsIgnoreCase(estado)
                && !"TODAS".equalsIgnoreCase(prioridad)) {

            return listarPendientesPorAgenteYPrioridad(
                    idAgente,
                    prioridad
            );
        }

        // =================================================
        // SOLO PENDIENTES
        // =================================================

        if ("PENDIENTES".equalsIgnoreCase(estado)) {

            return listarPendientesPorAgente(
                    idAgente
            );
        }

        // =================================================
        // ESTADO + PRIORIDAD
        // =================================================

        if (!"TODOS".equalsIgnoreCase(estado)
                && !"TODAS".equalsIgnoreCase(prioridad)) {

            try {

                int idEstado =
                        Integer.parseInt(estado);

                return listarPorAgenteEstadoYPrioridad(
                        idAgente,
                        idEstado,
                        prioridad
                );

            } catch (NumberFormatException e) {

                return listarPorAgenteYPrioridad(
                        idAgente,
                        prioridad
                );
            }
        }

        // =================================================
        // SOLO PRIORIDAD
        // =================================================

        if (!"TODAS".equalsIgnoreCase(prioridad)) {

            return listarPorAgenteYPrioridad(
                    idAgente,
                    prioridad
            );
        }

        // =================================================
        // SOLO ESTADO
        // =================================================

        if (!"TODOS".equalsIgnoreCase(estado)) {

            try {

                int idEstado =
                        Integer.parseInt(estado);

                return listarPorAgenteYEstado(
                        idAgente,
                        idEstado
                );

            } catch (NumberFormatException e) {

                return listarPorAgente(
                        idAgente
                );
            }
        }

        // =================================================
        // TODOS
        // =================================================

        return listarPorAgente(
                idAgente
        );
    }

    // =====================================================
    // LISTAR AGENTES POR TICKET
    // =====================================================

    @Override
    public Map<Integer, List<Usuario>> listarAgentesPorTicket(
            List<Ticket> tickets) {

        Map<Integer, List<Usuario>> agentesPorTicket =
                new HashMap<>();

        if (tickets == null) {
            return agentesPorTicket;
        }

        for (Ticket ticket : tickets) {

            if (ticket == null) {
                continue;
            }

            int idTicket =
                    ticket.getId_ticket();

            List<Usuario> agentes =
                    new ArrayList<>();

            if (ticket.getCategoria() != null) {

                int idCategoria =
                        ticket.getCategoria()
                                .getId_categoria();

                agentes =
                        usuarioService
                                .listarAgentesPorCategoria(
                                        idCategoria
                                );

                if (agentes == null) {
                    agentes = new ArrayList<>();
                }
            }

            agentesPorTicket.put(
                    idTicket,
                    agentes
            );
        }

        return agentesPorTicket;
    }

    // =====================================================
    // VALIDAR PERTENENCIA DEL TICKET
    // =====================================================

    @Override
    public boolean perteneceAlAgente(
            int idTicket,
            int idAgente) {

        Ticket ticket =
                ticketRepository.buscarPorId(
                        idTicket
                );

        if (ticket == null) {
            return false;
        }

        Usuario agente =
                ticket.getAgente();

        if (agente == null) {
            return false;
        }

        return agente.getId_usuario()
                == idAgente;
    }

    // =====================================================
    // LISTAR ESTADOS
    // =====================================================

    @Override
    public List<EstadoTicket> listarEstados() {

        return ticketRepository.listarEstados();
    }

    // =====================================================
    // LISTAR PRIORIDADES
    // =====================================================

    @Override
    public List<Prioridad> listarPrioridades() {

        return ticketRepository.listarPrioridades();
    }

    // =====================================================
    // CALCULAR PRIORIDAD AUTOMÁTICAMENTE
    // RF-03
    // =====================================================

    @Override
    public Prioridad calcularPrioridad(
            Ticket ticket) {

        if (ticket == null) {
            return null;
        }

        if (ticket.getPrioridad() != null) {
            return ticket.getPrioridad();
        }

        List<Prioridad> prioridades =
                ticketRepository.listarPrioridades();

        if (prioridades == null
                || prioridades.isEmpty()) {

            return null;
        }

        String texto =
                normalizarTexto(
                        (ticket.getTitulo() == null
                                ? ""
                                : ticket.getTitulo())
                        + " "
                        + (ticket.getDescripcion() == null
                                ? ""
                                : ticket.getDescripcion())
                );

        // =================================================
        // CRÍTICA
        // =================================================

        if (contieneAlguna(
                texto,
                "servidor caido",
                "sistema caido",
                "servicio caido",
                "todos los usuarios",
                "perdida de datos",
                "perdida total",
                "ataque",
                "seguridad comprometida",
                "emergencia"
        )) {

            Prioridad critica =
                    buscarPrioridad(
                            prioridades,
                            "CRITICA",
                            "CRÍTICA",
                            "CRITICO",
                            "CRÍTICO"
                    );

            if (critica != null) {
                return critica;
            }
        }

        // =================================================
        // ALTA
        // =================================================

        if (contieneAlguna(
                texto,
                "no disponible",
                "no puedo ingresar",
                "no puedo acceder",
                "no permite ingresar",
                "no permite acceder",
                "no funciona",
                "bloqueado",
                "bloqueada",
                "bloqueo",
                "urgente",
                "fallo grave",
                "error critico",
                "error crítico",
                "interrupcion",
                "interrupción",
                "caido",
                "caída",
                "caida"
        )) {

            Prioridad alta =
                    buscarPrioridad(
                            prioridades,
                            "ALTA"
                    );

            if (alta != null) {
                return alta;
            }
        }

        // =================================================
        // MEDIA
        // =================================================

        if (contieneAlguna(
                texto,
                "lento",
                "lenta",
                "lentitud",
                "error",
                "problema",
                "falla",
                "dificultad",
                "configurar",
                "configuracion",
                "configuración",
                "instalar",
                "instalacion",
                "instalación"
        )) {

            Prioridad media =
                    buscarPrioridad(
                            prioridades,
                            "MEDIA",
                            "MEDIO"
                    );

            if (media != null) {
                return media;
            }
        }

        // =================================================
        // BAJA
        // =================================================

        if (contieneAlguna(
                texto,
                "consulta",
                "informacion",
                "información",
                "solicitud",
                "pregunta",
                "duda",
                "ayuda",
                "actualizacion",
                "actualización",
                "cambio",
                "capacitacion",
                "capacitación"
        )) {

            Prioridad baja =
                    buscarPrioridad(
                            prioridades,
                            "BAJA"
                    );

            if (baja != null) {
                return baja;
            }
        }

        // =================================================
        // PRIORIDAD POR DEFECTO
        // =================================================

        Prioridad media =
                buscarPrioridad(
                        prioridades,
                        "MEDIA",
                        "MEDIO"
                );

        if (media != null) {
            return media;
        }

        return prioridades.get(0);
    }

    // =====================================================
    // BUSCAR PRIORIDAD POR NOMBRE
    // =====================================================

    private Prioridad buscarPrioridad(
            List<Prioridad> prioridades,
            String... nombres) {

        if (prioridades == null
                || nombres == null) {

            return null;
        }

        for (Prioridad prioridad : prioridades) {

            if (prioridad == null
                    || prioridad.gettipo_prioridad() == null) {

                continue;
            }

            String nombreBD =
                    normalizarTexto(
                            prioridad.gettipo_prioridad()
                    );

            for (String nombre : nombres) {

                if (nombreBD.equals(
                        normalizarTexto(nombre))) {

                    return prioridad;
                }
            }
        }

        return null;
    }

    // =====================================================
    // COMPROBAR PALABRAS CLAVE
    // =====================================================

    private boolean contieneAlguna(
            String texto,
            String... palabras) {

        if (texto == null
                || palabras == null) {

            return false;
        }

        for (String palabra : palabras) {

            if (palabra != null
                    && !palabra.trim().isEmpty()
                    && texto.contains(
                            normalizarTexto(palabra)
                    )) {

                return true;
            }
        }

        return false;
    }

    // =====================================================
    // NORMALIZAR TEXTO
    // =====================================================

    private String normalizarTexto(
            String texto) {

        if (texto == null) {
            return "";
        }

        String normalizado =
                Normalizer.normalize(
                        texto,
                        Normalizer.Form.NFD
                );

        return normalizado
                .replaceAll(
                        "\\p{InCombiningDiacriticalMarks}+",
                        ""
                )
                .toLowerCase()
                .trim();
    }

    // =====================================================
    // GUARDAR
    // =====================================================

    @Override
    public boolean guardar(Ticket ticket) {

        if (ticket == null) {
            return false;
        }

        return ticketRepository.guardar(ticket);
    }

    // =====================================================
    // ASIGNACIÓN AUTOMÁTICA
    // =====================================================

    @Override
    public Usuario asignarAgente(Ticket ticket) {

        if (ticket == null) {
            return null;
        }

        return asignacionService.asignarAgente(
                ticket
        );
    }

    // =====================================================
    // REASIGNACIÓN MANUAL
    // =====================================================

    @Override
    public boolean reasignarAgente(
            int idTicket,
            int idAgente) {

        return asignacionService.reasignarAgente(
                idTicket,
                idAgente
        );
    }

    // =====================================================
    // CONTAR TICKETS ACTIVOS
    // =====================================================

    @Override
    public int contarTicketsActivosPorAgente(
            int idAgente) {

        return ticketRepository
                .contarTicketsActivosPorAgente(
                        idAgente
                );
    }

    // =====================================================
    // CALCULAR SLA
    // =====================================================

    @Override
    public int calcularHorasSLA(
            Ticket ticket) {

        if (ticket == null
                || ticket.getPrioridad() == null) {

            return 0;
        }

        String nombrePrioridad =
                ticket.getPrioridad()
                        .gettipo_prioridad();

        if (nombrePrioridad == null) {

            return ticket.getPrioridad()
                    .getSla_horas();
        }

        String clave =
                nombrePrioridad
                        .trim()
                        .toUpperCase();

        EstrategiaSLA estrategia =
                estrategiasSLA.get(clave);

        if (estrategia != null) {

            return estrategia.calcularHoras(
                    ticket
            );
        }

        return ticket.getPrioridad()
                .getSla_horas();
    }

    // =====================================================
    // TRANSICIÓN DE ESTADO
    // =====================================================

    private boolean ejecutarTransicion(
            int idTicket,
            EstadoTicket nuevoEstado) {

        if (nuevoEstado == null) {
            return false;
        }

        Ticket ticket =
                ticketRepository.buscarPorId(
                        idTicket
                );

        if (ticket == null) {
            return false;
        }

        ticket.setEstado(
                nuevoEstado
        );

        return ticketRepository.cambiarEstado(
                idTicket,
                nuevoEstado.idEstado()
        );
    }

    // =====================================================
    // ASIGNAR
    // =====================================================

    @Override
    public boolean asignar(int idTicket) {

        Ticket ticket =
                ticketRepository.buscarPorId(
                        idTicket
                );

        if (ticket == null
                || ticket.getEstado() == null) {

            return false;
        }

        EstadoTicket nuevoEstado =
                ticket.getEstado().asignar();

        return ejecutarTransicion(
                idTicket,
                nuevoEstado
        );
    }

    // =====================================================
    // INICIAR ATENCIÓN
    // =====================================================

    @Override
    public boolean iniciarAtencion(
            int idTicket) {

        Ticket ticket =
                ticketRepository.buscarPorId(
                        idTicket
                );

        if (ticket == null
                || ticket.getEstado() == null) {

            return false;
        }

        EstadoTicket nuevoEstado =
                ticket.getEstado().iniciar();

        return ejecutarTransicion(
                idTicket,
                nuevoEstado
        );
    }

    // =====================================================
    // RESOLVER
    // =====================================================

    @Override
    public boolean resolver(int idTicket) {

        Ticket ticket =
                ticketRepository.buscarPorId(
                        idTicket
                );

        if (ticket == null
                || ticket.getEstado() == null) {

            return false;
        }

        EstadoTicket nuevoEstado =
                ticket.getEstado().resolver();

        return ejecutarTransicion(
                idTicket,
                nuevoEstado
        );
    }

    // =====================================================
    // CERRAR
    // =====================================================

    @Override
    public boolean cerrar(int idTicket) {

        Ticket ticket =
                ticketRepository.buscarPorId(
                        idTicket
                );

        if (ticket == null
                || ticket.getEstado() == null) {

            return false;
        }

        EstadoTicket nuevoEstado =
                ticket.getEstado().cerrar();

        return ejecutarTransicion(
                idTicket,
                nuevoEstado
        );
    }

    // =====================================================
    // REABRIR
    // =====================================================

    @Override
    public boolean reabrir(int idTicket) {

        Ticket ticket =
                ticketRepository.buscarPorId(
                        idTicket
                );

        if (ticket == null
                || ticket.getEstado() == null) {

            return false;
        }

        EstadoTicket nuevoEstado =
                ticket.getEstado().reabrir();

        return ejecutarTransicion(
                idTicket,
                nuevoEstado
        );
    }

    // =====================================================
    // CANCELAR
    // =====================================================

    @Override
    public boolean cancelar(int idTicket) {

        Ticket ticket =
                ticketRepository.buscarPorId(
                        idTicket
                );

        if (ticket == null
                || ticket.getEstado() == null) {

            return false;
        }

        EstadoTicket nuevoEstado =
                ticket.getEstado().cancelar();

        return ejecutarTransicion(
                idTicket,
                nuevoEstado
        );
    }

    // =====================================================
    // CAMBIAR ESTADO SEGÚN ACCIÓN
    // =====================================================

    @Override
    public boolean cambiarEstado(
            int idTicket,
            String accion) {

        if (accion == null
                || accion.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "No se indicó qué acción realizar."
            );
        }

        switch (accion.trim().toLowerCase()) {

            case "asignar":

                return asignar(idTicket);

            case "iniciar":

                return iniciarAtencion(idTicket);

            case "resolver":

                return resolver(idTicket);

            case "cerrar":

                return cerrar(idTicket);

            case "reabrir":

                return reabrir(idTicket);

            case "cancelar":

                return cancelar(idTicket);

            default:

                throw new IllegalArgumentException(
                        "Acción no reconocida: "
                        + accion
                );
        }
    }

    // =====================================================
    // AVANZAR ESTADO
    // =====================================================

    @Override
    public boolean avanzarEstado(
            int idTicket) {

        Ticket ticket =
                ticketRepository.buscarPorId(
                        idTicket
                );

        if (ticket == null
                || ticket.getEstado() == null) {

            return false;
        }

        EstadoTicket estadoActual =
                ticket.getEstado();

        EstadoTicket nuevoEstado;

        switch (estadoActual.idEstado()) {

            case 1:

                nuevoEstado =
                        estadoActual.asignar();

                break;

            case 2:

                nuevoEstado =
                        estadoActual.iniciar();

                break;

            case 3:

                nuevoEstado =
                        estadoActual.resolver();

                break;

            case 4:

                nuevoEstado =
                        estadoActual.cerrar();

                break;

            default:

                return false;
        }

        return ejecutarTransicion(
                idTicket,
                nuevoEstado
        );
    }

    // =====================================================
    // ELIMINAR TICKET
    // =====================================================

    @Override
    public boolean eliminarTicket(
            int idTicket) {

        return ticketRepository.eliminar(
                idTicket
        );
    }
}