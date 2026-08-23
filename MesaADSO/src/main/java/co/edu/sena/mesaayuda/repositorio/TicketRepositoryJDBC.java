package co.edu.sena.mesaayuda.repositorio;

import co.edu.sena.mesaayuda.modelo.Categoria;
import co.edu.sena.mesaayuda.modelo.Prioridad;
import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;

import co.edu.sena.mesaayuda.modelo.estado.EstadoAsignado;
import co.edu.sena.mesaayuda.modelo.estado.EstadoCancelado;
import co.edu.sena.mesaayuda.modelo.estado.EstadoCerrado;
import co.edu.sena.mesaayuda.modelo.estado.EstadoEnProceso;
import co.edu.sena.mesaayuda.modelo.estado.EstadoNuevo;
import co.edu.sena.mesaayuda.modelo.estado.EstadoResuelto;
import co.edu.sena.mesaayuda.modelo.estado.EstadoTicket;

import co.edu.sena.mesaayuda.util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import java.util.ArrayList;
import java.util.List;

public class TicketRepositoryJDBC implements TicketRepository {

    // =========================================================
    // LISTAR TODOS LOS TICKETS
    // =========================================================

    @Override
    public List<Ticket> listarTodos() {

        List<Ticket> tickets = new ArrayList<>();

        String sql =
                "SELECT "
                + "t.id_ticket, "
                + "t.titulo, "
                + "t.descripcion, "
                + "t.fecha_creacion, "

                + "c.id_categoria, "
                + "c.nombre_categoria, "

                + "p.id_prioridad, "
                + "p.tipo_prioridad, "
                + "p.las_horas, "

                + "s.id_usuario AS id_solicitante, "
                + "s.nombre_usuario AS nombre_solicitante, "

                + "a.id_usuario AS id_agente, "
                + "a.nombre_usuario AS nombre_agente, "

                + "e.id_estado, "
                + "e.tipo_estado "

                + "FROM ticket t "

                + "INNER JOIN categoria c "
                + "ON t.id_categoria = c.id_categoria "

                + "INNER JOIN prioridad p "
                + "ON t.id_prioridad = p.id_prioridad "

                + "INNER JOIN usuario s "
                + "ON t.id_solicitante = s.id_usuario "

                + "LEFT JOIN usuario a "
                + "ON t.id_agente = a.id_usuario "

                + "INNER JOIN estado_ticket e "
                + "ON t.id_estado = e.id_estado "

                + "ORDER BY t.fecha_creacion DESC";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                tickets.add(construirTicket(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tickets;
    }

    // =========================================================
    // LISTAR TICKETS POR SOLICITANTE
    // =========================================================

    @Override
    public List<Ticket> listarPorSolicitante(int idSolicitante) {

        List<Ticket> tickets = new ArrayList<>();

        String sql =
                "SELECT "
                + "t.id_ticket, "
                + "t.titulo, "
                + "t.descripcion, "
                + "t.fecha_creacion, "

                + "c.id_categoria, "
                + "c.nombre_categoria, "

                + "p.id_prioridad, "
                + "p.tipo_prioridad, "
                + "p.las_horas, "

                + "s.id_usuario AS id_solicitante, "
                + "s.nombre_usuario AS nombre_solicitante, "

                + "a.id_usuario AS id_agente, "
                + "a.nombre_usuario AS nombre_agente, "

                + "e.id_estado, "
                + "e.tipo_estado "

                + "FROM ticket t "

                + "INNER JOIN categoria c "
                + "ON t.id_categoria = c.id_categoria "

                + "INNER JOIN prioridad p "
                + "ON t.id_prioridad = p.id_prioridad "

                + "INNER JOIN usuario s "
                + "ON t.id_solicitante = s.id_usuario "

                + "LEFT JOIN usuario a "
                + "ON t.id_agente = a.id_usuario "

                + "INNER JOIN estado_ticket e "
                + "ON t.id_estado = e.id_estado "

                + "WHERE t.id_solicitante = ? "

                + "ORDER BY t.fecha_creacion DESC";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idSolicitante);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    tickets.add(construirTicket(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tickets;
    }

    // =========================================================
    // BUSCAR TICKET POR ID
    // =========================================================

    @Override
    public Ticket buscarPorId(int idTicket) {

        String sql =
                "SELECT "
                + "t.id_ticket, "
                + "t.titulo, "
                + "t.descripcion, "
                + "t.fecha_creacion, "

                + "c.id_categoria, "
                + "c.nombre_categoria, "

                + "p.id_prioridad, "
                + "p.tipo_prioridad, "
                + "p.las_horas, "

                + "s.id_usuario AS id_solicitante, "
                + "s.nombre_usuario AS nombre_solicitante, "

                + "a.id_usuario AS id_agente, "
                + "a.nombre_usuario AS nombre_agente, "

                + "e.id_estado, "
                + "e.tipo_estado "

                + "FROM ticket t "

                + "INNER JOIN categoria c "
                + "ON t.id_categoria = c.id_categoria "

                + "INNER JOIN prioridad p "
                + "ON t.id_prioridad = p.id_prioridad "

                + "INNER JOIN usuario s "
                + "ON t.id_solicitante = s.id_usuario "

                + "LEFT JOIN usuario a "
                + "ON t.id_agente = a.id_usuario "

                + "INNER JOIN estado_ticket e "
                + "ON t.id_estado = e.id_estado "

                + "WHERE t.id_ticket = ?";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idTicket);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return construirTicket(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // =========================================================
    // LISTAR TICKETS POR AGENTE
    // =========================================================

    @Override
    public List<Ticket> listarPorAgente(int idAgente) {

        List<Ticket> tickets = new ArrayList<>();

        String sql =
                "SELECT "
                + "t.id_ticket, "
                + "t.titulo, "
                + "t.descripcion, "
                + "t.fecha_creacion, "

                + "c.id_categoria, "
                + "c.nombre_categoria, "

                + "p.id_prioridad, "
                + "p.tipo_prioridad, "
                + "p.las_horas, "

                + "s.id_usuario AS id_solicitante, "
                + "s.nombre_usuario AS nombre_solicitante, "

                + "a.id_usuario AS id_agente, "
                + "a.nombre_usuario AS nombre_agente, "

                + "e.id_estado, "
                + "e.tipo_estado "

                + "FROM ticket t "

                + "INNER JOIN categoria c "
                + "ON t.id_categoria = c.id_categoria "

                + "INNER JOIN prioridad p "
                + "ON t.id_prioridad = p.id_prioridad "

                + "INNER JOIN usuario s "
                + "ON t.id_solicitante = s.id_usuario "

                + "LEFT JOIN usuario a "
                + "ON t.id_agente = a.id_usuario "

                + "INNER JOIN estado_ticket e "
                + "ON t.id_estado = e.id_estado "

                + "WHERE t.id_agente = ? "

                + "ORDER BY t.fecha_creacion DESC";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idAgente);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    tickets.add(construirTicket(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tickets;
    }

    // =========================================================
    // LISTAR PENDIENTES POR AGENTE
    // =========================================================

    @Override
    public List<Ticket> listarPendientesPorAgente(int idAgente) {

        List<Ticket> tickets = new ArrayList<>();

        String sql =
                "SELECT "
                + "t.id_ticket, "
                + "t.titulo, "
                + "t.descripcion, "
                + "t.fecha_creacion, "

                + "c.id_categoria, "
                + "c.nombre_categoria, "

                + "p.id_prioridad, "
                + "p.tipo_prioridad, "
                + "p.las_horas, "

                + "s.id_usuario AS id_solicitante, "
                + "s.nombre_usuario AS nombre_solicitante, "

                + "a.id_usuario AS id_agente, "
                + "a.nombre_usuario AS nombre_agente, "

                + "e.id_estado, "
                + "e.tipo_estado "

                + "FROM ticket t "

                + "INNER JOIN categoria c "
                + "ON t.id_categoria = c.id_categoria "

                + "INNER JOIN prioridad p "
                + "ON t.id_prioridad = p.id_prioridad "

                + "INNER JOIN usuario s "
                + "ON t.id_solicitante = s.id_usuario "

                + "LEFT JOIN usuario a "
                + "ON t.id_agente = a.id_usuario "

                + "INNER JOIN estado_ticket e "
                + "ON t.id_estado = e.id_estado "

                + "WHERE t.id_agente = ? "

                + "AND e.tipo_estado IN "
                + "('NUEVO', 'ASIGNADO', 'EN_PROCESO') "

                + "ORDER BY t.fecha_creacion DESC";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idAgente);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    tickets.add(construirTicket(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tickets;
    }

    // =========================================================
    // LISTAR POR AGENTE Y ESTADO
    // =========================================================

    @Override
    public List<Ticket> listarPorAgenteYEstado(
            int idAgente,
            int idEstado) {

        List<Ticket> tickets = new ArrayList<>();

        String sql =
                "SELECT "
                + "t.id_ticket, "
                + "t.titulo, "
                + "t.descripcion, "
                + "t.fecha_creacion, "

                + "c.id_categoria, "
                + "c.nombre_categoria, "

                + "p.id_prioridad, "
                + "p.tipo_prioridad, "
                + "p.las_horas, "

                + "s.id_usuario AS id_solicitante, "
                + "s.nombre_usuario AS nombre_solicitante, "

                + "a.id_usuario AS id_agente, "
                + "a.nombre_usuario AS nombre_agente, "

                + "e.id_estado, "
                + "e.tipo_estado "

                + "FROM ticket t "

                + "INNER JOIN categoria c "
                + "ON t.id_categoria = c.id_categoria "

                + "INNER JOIN prioridad p "
                + "ON t.id_prioridad = p.id_prioridad "

                + "INNER JOIN usuario s "
                + "ON t.id_solicitante = s.id_usuario "

                + "LEFT JOIN usuario a "
                + "ON t.id_agente = a.id_usuario "

                + "INNER JOIN estado_ticket e "
                + "ON t.id_estado = e.id_estado "

                + "WHERE t.id_agente = ? "
                + "AND t.id_estado = ? "

                + "ORDER BY t.fecha_creacion DESC";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idAgente);
            ps.setInt(2, idEstado);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    tickets.add(construirTicket(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tickets;
    }

    // =========================================================
    // LISTAR POR AGENTE Y PRIORIDAD
    // =========================================================

    @Override
    public List<Ticket> listarPorAgenteYPrioridad(
            int idAgente,
            String prioridad) {

        List<Ticket> tickets = new ArrayList<>();

        String sql =
                "SELECT "
                + "t.id_ticket, "
                + "t.titulo, "
                + "t.descripcion, "
                + "t.fecha_creacion, "

                + "c.id_categoria, "
                + "c.nombre_categoria, "

                + "p.id_prioridad, "
                + "p.tipo_prioridad, "
                + "p.las_horas, "

                + "s.id_usuario AS id_solicitante, "
                + "s.nombre_usuario AS nombre_solicitante, "

                + "a.id_usuario AS id_agente, "
                + "a.nombre_usuario AS nombre_agente, "

                + "e.id_estado, "
                + "e.tipo_estado "

                + "FROM ticket t "

                + "INNER JOIN categoria c "
                + "ON t.id_categoria = c.id_categoria "

                + "INNER JOIN prioridad p "
                + "ON t.id_prioridad = p.id_prioridad "

                + "INNER JOIN usuario s "
                + "ON t.id_solicitante = s.id_usuario "

                + "LEFT JOIN usuario a "
                + "ON t.id_agente = a.id_usuario "

                + "INNER JOIN estado_ticket e "
                + "ON t.id_estado = e.id_estado "

                + "WHERE t.id_agente = ? "

                + "AND UPPER(p.tipo_prioridad) = UPPER(?) "

                + "ORDER BY t.fecha_creacion DESC";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idAgente);
            ps.setString(2, prioridad);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    tickets.add(construirTicket(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tickets;
    }

    // =========================================================
    // LISTAR POR AGENTE + ESTADO + PRIORIDAD
    // =========================================================

    @Override
    public List<Ticket> listarPorAgenteEstadoYPrioridad(
            int idAgente,
            int idEstado,
            String prioridad) {

        List<Ticket> tickets = new ArrayList<>();

        String sql =
                "SELECT "
                + "t.id_ticket, "
                + "t.titulo, "
                + "t.descripcion, "
                + "t.fecha_creacion, "

                + "c.id_categoria, "
                + "c.nombre_categoria, "

                + "p.id_prioridad, "
                + "p.tipo_prioridad, "
                + "p.las_horas, "

                + "s.id_usuario AS id_solicitante, "
                + "s.nombre_usuario AS nombre_solicitante, "

                + "a.id_usuario AS id_agente, "
                + "a.nombre_usuario AS nombre_agente, "

                + "e.id_estado, "
                + "e.tipo_estado "

                + "FROM ticket t "

                + "INNER JOIN categoria c "
                + "ON t.id_categoria = c.id_categoria "

                + "INNER JOIN prioridad p "
                + "ON t.id_prioridad = p.id_prioridad "

                + "INNER JOIN usuario s "
                + "ON t.id_solicitante = s.id_usuario "

                + "LEFT JOIN usuario a "
                + "ON t.id_agente = a.id_usuario "

                + "INNER JOIN estado_ticket e "
                + "ON t.id_estado = e.id_estado "

                + "WHERE t.id_agente = ? "
                + "AND t.id_estado = ? "
                + "AND UPPER(p.tipo_prioridad) = UPPER(?) "

                + "ORDER BY t.fecha_creacion DESC";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idAgente);
            ps.setInt(2, idEstado);
            ps.setString(3, prioridad);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    tickets.add(construirTicket(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tickets;
    }

    // =========================================================
    // LISTAR ESTADOS
    // =========================================================

    @Override
    public List<EstadoTicket> listarEstados() {

        List<EstadoTicket> estados = new ArrayList<>();

        String sql =
                "SELECT id_estado, tipo_estado "
                + "FROM estado_ticket "
                + "ORDER BY id_estado";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                estados.add(
                        crearEstado(
                                rs.getInt("id_estado"),
                                rs.getString("tipo_estado")
                        )
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return estados;
    }

    // =========================================================
    // LISTAR PRIORIDADES
    // =========================================================

    @Override
    public List<Prioridad> listarPrioridades() {

        List<Prioridad> prioridades = new ArrayList<>();

        String sql =
                "SELECT "
                + "id_prioridad, "
                + "tipo_prioridad, "
                + "las_horas "
                + "FROM prioridad "
                + "ORDER BY id_prioridad";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Prioridad prioridad = new Prioridad();

                prioridad.setId_prioridad(
                        rs.getInt("id_prioridad")
                );

                prioridad.settipo_prioridad(
                        rs.getString("tipo_prioridad")
                );

                prioridad.setSla_horas(
                        rs.getInt("las_horas")
                );

                prioridades.add(prioridad);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return prioridades;
    }

    // =========================================================
    // CAMBIAR ESTADO
    // =========================================================

    @Override
    public boolean cambiarEstado(
            int idTicket,
            int idEstado) {

        String sql =
                "UPDATE ticket "
                + "SET id_estado = ? "
                + "WHERE id_ticket = ?";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idEstado);
            ps.setInt(2, idTicket);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // =========================================================
    // REASIGNAR AGENTE
    // =========================================================

    @Override
    public boolean reasignarAgente(
            int idTicket,
            int idAgente) {

        String sql =
                "UPDATE ticket "
                + "SET id_agente = ?, "
                + "id_estado = ( "
                + "SELECT id_estado "
                + "FROM estado_ticket "
                + "WHERE tipo_estado = 'ASIGNADO' "
                + ") "
                + "WHERE id_ticket = ?";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idAgente);
            ps.setInt(2, idTicket);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // =========================================================
    // CONTAR TICKETS ACTIVOS
    // =========================================================

    @Override
public int contarTicketsActivosPorAgente(int idAgente) {

    String sql =
            "SELECT COUNT(*) AS cantidad "
            + "FROM ticket t "
            + "INNER JOIN estado_ticket e "
            + "ON t.id_estado = e.id_estado "
            + "WHERE t.id_agente = ? "
            + "AND e.tipo_estado IN "
            + "('NUEVO', 'ASIGNADO', 'EN_PROCESO')";

    try (Connection conexion = Conexion.getConnection();
         PreparedStatement ps = conexion.prepareStatement(sql)) {

        ps.setInt(1, idAgente);

        try (ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("cantidad");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return 0;
}

// GUARDAR TICKET
    // =========================================================

    @Override
    public boolean guardar(Ticket ticket) {

        String sql =
                "INSERT INTO ticket "
                + "(titulo, descripcion, fecha_creacion, "
                + "id_categoria, id_prioridad, id_solicitante, "
                + "id_agente, id_estado) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setString(1, ticket.getTitulo());

            ps.setString(2, ticket.getDescripcion());

            if (ticket.getFecha_creacion() != null) {

                ps.setTimestamp(
                        3,
                        new Timestamp(
                                ticket.getFecha_creacion().getTime()
                        )
                );

            } else {

                ps.setTimestamp(
                        3,
                        new Timestamp(
                                System.currentTimeMillis()
                        )
                );
            }

            ps.setInt(
                    4,
                    ticket.getCategoria().getId_categoria()
            );

            ps.setInt(
                    5,
                    ticket.getPrioridad().getId_prioridad()
            );

            ps.setInt(
                    6,
                    ticket.getSolicitante().getId_usuario()
            );

            if (ticket.getAgente() != null) {

                ps.setInt(
                        7,
                        ticket.getAgente().getId_usuario()
                );

            } else {

                ps.setNull(
                        7,
                        java.sql.Types.INTEGER
                );
            }

            // CORREGIDO:
            // EstadoTicket tiene idEstado(), no getId_estado()
            ps.setInt(
                    8,
                    ticket.getEstado().idEstado()
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

   // =========================================================
// ELIMINAR TICKET (ahora: CANCELAR TICKET, no borra el registro)
// =========================================================

@Override
public boolean eliminar(int idTicket) {

    String sql =
            "UPDATE ticket "
            + "SET id_estado = ( "
            + "SELECT id_estado "
            + "FROM estado_ticket "
            + "WHERE tipo_estado = 'CANCELADO' "
            + ") "
            + "WHERE id_ticket = ?";

    try (Connection conexion = Conexion.getConnection();
         PreparedStatement ps = conexion.prepareStatement(sql)) {

        ps.setInt(1, idTicket);

        return ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}


    // =========================================================
    // CONSTRUIR TICKET
    // =========================================================

    private Ticket construirTicket(
            ResultSet rs) throws Exception {

        Ticket ticket = new Ticket();

        ticket.setId_ticket(
                rs.getInt("id_ticket")
        );

        ticket.setTitulo(
                rs.getString("titulo")
        );

        ticket.setDescripcion(
                rs.getString("descripcion")
        );

        ticket.setFecha_creacion(
                rs.getTimestamp("fecha_creacion")
        );

        // =====================================================
        // CATEGORIA
        // =====================================================

        Categoria categoria = new Categoria();

        categoria.setId_categoria(
                rs.getInt("id_categoria")
        );

        categoria.setnombre_categoria(
                rs.getString("nombre_categoria")
        );

        ticket.setCategoria(categoria);

        // =====================================================
        // PRIORIDAD
        // =====================================================

        Prioridad prioridad = new Prioridad(
                rs.getInt("id_prioridad"),
                rs.getString("tipo_prioridad"),
                rs.getInt("las_horas")
        );

        ticket.setPrioridad(prioridad);

        // =====================================================
        // SOLICITANTE
        // =====================================================

        Usuario solicitante = new Usuario();

        solicitante.setId_usuario(
                rs.getInt("id_solicitante")
        );

        solicitante.setnombre_usuario(
                rs.getString("nombre_solicitante")
        );

        ticket.setSolicitante(solicitante);

        // =====================================================
        // AGENTE
        // =====================================================

        if (rs.getObject("id_agente") != null) {

            Usuario agente = new Usuario();

            agente.setId_usuario(
                    rs.getInt("id_agente")
            );

            agente.setnombre_usuario(
                    rs.getString("nombre_agente")
            );

            ticket.setAgente(agente);
        }

        // =====================================================
        // ESTADO
        // =====================================================

        EstadoTicket estado =
                crearEstado(
                        rs.getInt("id_estado"),
                        rs.getString("tipo_estado")
                );

        ticket.setEstado(estado);

        return ticket;
    }

    // =========================================================
    // CREAR ESTADO
    // =========================================================

    private EstadoTicket crearEstado(
            int idEstado,
            String tipoEstado) {

        if (tipoEstado == null) {
            return new EstadoNuevo();
        }

        switch (tipoEstado.toUpperCase()) {

            case "NUEVO":
                return new EstadoNuevo();

            case "ASIGNADO":
                return new EstadoAsignado();

            case "EN_PROCESO":
                return new EstadoEnProceso();

            case "RESUELTO":
                return new EstadoResuelto();

            case "CERRADO":
                return new EstadoCerrado();

            case "CANCELADO":
                return new EstadoCancelado();

            default:
                return new EstadoNuevo();
        }
    }

    // =========================================================
    // LISTAR PENDIENTES POR AGENTE + PRIORIDAD
    // =========================================================

    @Override
    public List<Ticket> listarPendientesPorAgenteYPrioridad(
            int idAgente,
            String prioridad) {

        List<Ticket> tickets = new ArrayList<>();

        String sql =
                "SELECT "
                + "t.id_ticket, "
                + "t.titulo, "
                + "t.descripcion, "
                + "t.fecha_creacion, "

                + "c.id_categoria, "
                + "c.nombre_categoria, "

                + "p.id_prioridad, "
                + "p.tipo_prioridad, "
                + "p.las_horas, "

                + "s.id_usuario AS id_solicitante, "
                + "s.nombre_usuario AS nombre_solicitante, "

                + "a.id_usuario AS id_agente, "
                + "a.nombre_usuario AS nombre_agente, "

                + "e.id_estado, "
                + "e.tipo_estado "

                + "FROM ticket t "

                + "INNER JOIN categoria c "
                + "ON t.id_categoria = c.id_categoria "

                + "INNER JOIN prioridad p "
                + "ON t.id_prioridad = p.id_prioridad "

                + "INNER JOIN usuario s "
                + "ON t.id_solicitante = s.id_usuario "

                + "LEFT JOIN usuario a "
                + "ON t.id_agente = a.id_usuario "

                + "INNER JOIN estado_ticket e "
                + "ON t.id_estado = e.id_estado "

                + "WHERE t.id_agente = ? "

                + "AND e.tipo_estado IN "
                + "('NUEVO', 'ASIGNADO', 'EN_PROCESO') "

                + "AND UPPER(p.tipo_prioridad) = UPPER(?) "

                + "ORDER BY t.fecha_creacion DESC";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idAgente);
            ps.setString(2, prioridad);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    tickets.add(
                            construirTicket(rs)
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tickets;
    }
}