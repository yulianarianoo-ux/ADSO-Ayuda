package co.edu.sena.mesaayuda.repositorio;

import co.edu.sena.mesaayuda.util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReporteRepositorioJDBC implements ReporteRepositorio {

    @Override
    public int totalTickets() {

        String sql = "SELECT COUNT(*) AS total "
                + "FROM ticket";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public List<Map<String, Object>> ticketsPorEstado() {

        List<Map<String, Object>> resultados = new ArrayList<>();

        String sql = "SELECT "
                + "e.tipo_estado AS nombre, "
                + "COUNT(t.id_ticket) AS cantidad "
                + "FROM estado_ticket e "
                + "LEFT JOIN ticket t "
                + "ON e.id_estado = t.id_estado "
                + "GROUP BY e.id_estado, e.tipo_estado "
                + "ORDER BY cantidad DESC";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Map<String, Object> fila = new HashMap<>();

                fila.put("nombre", rs.getString("nombre"));
                fila.put("cantidad", rs.getInt("cantidad"));

                resultados.add(fila);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultados;
    }

    @Override
    public List<Map<String, Object>> ticketsPorPrioridad() {

        List<Map<String, Object>> resultados = new ArrayList<>();

        String sql = "SELECT "
                + "p.tipo_prioridad AS nombre, "
                + "COUNT(t.id_ticket) AS cantidad "
                + "FROM prioridad p "
                + "LEFT JOIN ticket t "
                + "ON p.id_prioridad = t.id_prioridad "
                + "GROUP BY p.id_prioridad, p.tipo_prioridad "
                + "ORDER BY cantidad DESC";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Map<String, Object> fila = new HashMap<>();

                fila.put("nombre", rs.getString("nombre"));
                fila.put("cantidad", rs.getInt("cantidad"));

                resultados.add(fila);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultados;
    }

    @Override
    public List<Map<String, Object>> ticketsPorCategoria() {

        List<Map<String, Object>> resultados = new ArrayList<>();

        String sql = "SELECT "
                + "c.nombre_categoria AS nombre, "
                + "COUNT(t.id_ticket) AS cantidad "
                + "FROM categoria c "
                + "LEFT JOIN ticket t "
                + "ON c.id_categoria = t.id_categoria "
                + "GROUP BY c.id_categoria, c.nombre_categoria "
                + "ORDER BY cantidad DESC";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Map<String, Object> fila = new HashMap<>();

                fila.put("nombre", rs.getString("nombre"));
                fila.put("cantidad", rs.getInt("cantidad"));

                resultados.add(fila);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultados;
    }

   @Override
public List<Map<String, Object>> ticketsPorAgente() {

    List<Map<String, Object>> resultados = new ArrayList<>();

    String sql =
            "SELECT "
            + "u.id_usuario, "
            + "u.nombre_usuario AS nombre, "
            + "COUNT(t.id_ticket) AS cantidad "
            + "FROM usuario u "
            + "INNER JOIN rol r "
            + "ON u.id_rol = r.id_rol "
            + "LEFT JOIN ticket t "
            + "ON u.id_usuario = t.id_agente "
            + "AND t.id_estado IN ( "
            + "    SELECT e.id_estado "
            + "    FROM estado_ticket e "
            + "    WHERE e.tipo_estado IN "
            + "    ('NUEVO', 'ASIGNADO', 'EN_PROCESO') "
            + ") "
            + "WHERE r.tipo_rol = 'AGENTE' "
            + "GROUP BY u.id_usuario, u.nombre_usuario "
            + "ORDER BY cantidad DESC";

    try (Connection conexion = Conexion.getConnection();
         PreparedStatement ps = conexion.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {

            Map<String, Object> dato = new HashMap<>();

            dato.put("id", rs.getInt("id_usuario"));
            dato.put("nombre", rs.getString("nombre"));
            dato.put("cantidad", rs.getInt("cantidad"));

            resultados.add(dato);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return resultados;
}

    @Override
    public int slasVencidos() {

        String sql = "SELECT COUNT(*) AS total "
                + "FROM ticket t "
                + "INNER JOIN prioridad p "
                + "ON t.id_prioridad = p.id_prioridad "
                + "INNER JOIN estado_ticket e "
                + "ON t.id_estado = e.id_estado "
                + "WHERE DATE_ADD(t.fecha_creacion, INTERVAL p.las_horas HOUR) < NOW() "
                + "AND e.tipo_estado NOT IN ('RESUELTO', 'CERRADO')";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}