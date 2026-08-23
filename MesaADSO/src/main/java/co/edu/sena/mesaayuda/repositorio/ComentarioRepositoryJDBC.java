package co.edu.sena.mesaayuda.repositorio;

import co.edu.sena.mesaayuda.modelo.Comentario;
import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ComentarioRepositoryJDBC implements ComentarioRepository {

    @Override
public boolean guardar(Comentario comentario) {

    String sql = "INSERT INTO comentario "
            + "(id_ticket, id_autor, texto, fecha) "
            + "VALUES (?, ?, ?, NOW())";

    try (Connection conexion = Conexion.getConnection();
         PreparedStatement ps = conexion.prepareStatement(sql)) {

        ps.setInt(1, comentario.getTicket().getId_ticket());
        ps.setInt(2, comentario.getUsuario().getId_usuario());

        
        ps.setString(3, comentario.getTexto());

        int filas = ps.executeUpdate();

        return filas > 0;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

    @Override
    public List<Comentario> listarPorTicket(int idTicket) {

        List<Comentario> comentarios = new ArrayList<>();

        String sql = "SELECT "
                + "c.id_comentario, "
                + "c.id_ticket, "
                + "c.id_autor, "
                + "c.texto, "
                + "c.fecha, "
                + "u.nombre_usuario "
                + "FROM comentario c "
                + "INNER JOIN usuario u "
                + "ON c.id_autor = u.id_usuario "
                + "WHERE c.id_ticket = ? "
                + "ORDER BY c.fecha ASC";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idTicket);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Comentario comentario = new Comentario();

                    comentario.setId_comentario(
                            rs.getInt("id_comentario")
                    );

                    Ticket ticket = new Ticket();

                    ticket.setId_ticket(
                            rs.getInt("id_ticket")
                    );

                    comentario.setTicket(ticket);

                    Usuario usuario = new Usuario();

                    usuario.setId_usuario(
                            rs.getInt("id_autor")
                    );

                    usuario.setnombre_usuario(
                            rs.getString("nombre_usuario")
                    );

                    comentario.setUsuario(usuario);

                    comentario.setTexto(
                            rs.getString("texto")
                    );

                    comentario.setFecha(
                            rs.getTimestamp("fecha")
                    );

                    comentarios.add(comentario);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return comentarios;
    }

    @Override
    public boolean actualizar(Comentario comentario) {

        String sql = "UPDATE comentario "
                + "SET texto = ? "
                + "WHERE id_comentario = ?";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setString(1, comentario.getTexto());
            ps.setInt(2, comentario.getId_comentario());

            int filas = ps.executeUpdate();

            return filas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        
    }
    @Override
public Comentario buscarPorId(int idComentario) {

    String sql = "SELECT "
            + "c.id_comentario, "
            + "c.id_ticket, "
            + "c.id_autor, "
            + "c.texto, "
            + "c.fecha, "
            + "u.nombre_usuario "
            + "FROM comentario c "
            + "INNER JOIN usuario u "
            + "ON c.id_autor = u.id_usuario "
            + "WHERE c.id_comentario = ?";

    try (Connection conexion = Conexion.getConnection();
         PreparedStatement ps = conexion.prepareStatement(sql)) {

        ps.setInt(1, idComentario);

        try (ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {

                Comentario comentario = new Comentario();

                comentario.setId_comentario(
                        rs.getInt("id_comentario")
                );

                Ticket ticket = new Ticket();
                ticket.setId_ticket(rs.getInt("id_ticket"));
                comentario.setTicket(ticket);

                Usuario usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id_autor"));
                usuario.setnombre_usuario(rs.getString("nombre_usuario"));
                comentario.setUsuario(usuario);

                comentario.setTexto(rs.getString("texto"));
                comentario.setFecha(rs.getTimestamp("fecha"));

                return comentario;
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}
}