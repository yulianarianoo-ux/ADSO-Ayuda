package co.edu.sena.mesaayuda.repositorio;

import co.edu.sena.mesaayuda.util.Conexion;
import co.edu.sena.mesaayuda.modelo.Rol;
import co.edu.sena.mesaayuda.modelo.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UsuarioRepositoryJDBC implements UsuarioRepository {

    @Override
    public Usuario autenticar(String correo, String contrasena) {

        String sql = "SELECT u.id_usuario, u.nombre_usuario, u.correo, "
                + "u.contrasena, r.id_rol, r.tipo_rol AS nombre_rol "
                + "FROM usuario u "
                + "INNER JOIN rol r ON u.id_rol = r.id_rol "
                + "WHERE u.correo = ? AND u.contrasena = ?";

        try (Connection conexion = Conexion.getConnection();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setString(1, correo);
            ps.setString(2, contrasena);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Rol rol = new Rol(
                            rs.getInt("id_rol"),
                            rs.getString("nombre_rol")
                    );

                    return new Usuario(
                            rs.getInt("id_usuario"),
                            rs.getString("nombre_usuario"),
                            rs.getString("correo"),
                            rs.getString("contrasena"),
                            rol
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

 @Override
public List<Usuario> listarPorRol(String tipoRol) {

    List<Usuario> usuarios = new ArrayList<>();

    String sql = "SELECT u.id_usuario, u.nombre_usuario, r.tipo_rol "
            + "FROM usuario u "
            + "INNER JOIN rol r ON u.id_rol = r.id_rol "
            + "WHERE UPPER(TRIM(r.tipo_rol)) = UPPER(TRIM(?)) "
            + "ORDER BY u.nombre_usuario";

    try (Connection conexion = Conexion.getConnection();
         PreparedStatement ps = conexion.prepareStatement(sql)) {

       


        ps.setString(1, tipoRol);

        try (ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Usuario usuario = new Usuario();

                usuario.setId_usuario(
                        rs.getInt("id_usuario")
                );

                usuario.setnombre_usuario(
                        rs.getString("nombre_usuario")
                );

                usuarios.add(usuario);

                
            }
        }

    

    } catch (Exception e) {

       
        e.printStackTrace();
    }

    return usuarios;
}
  
@Override
public List<Usuario> listarAgentesPorCategoria(int idCategoria) {

    List<Usuario> agentes = new ArrayList<>();

    String sql = "SELECT u.id_usuario, u.nombre_usuario "
            + "FROM usuario u "
            + "INNER JOIN rol r ON u.id_rol = r.id_rol "
            + "INNER JOIN agente_categoria ac "
            + "ON u.id_usuario = ac.id_agente "
            + "WHERE UPPER(TRIM(r.tipo_rol)) = 'AGENTE' "///VERIFICA Q SEA AGENTES 
            + "AND ac.id_categoria = ? "
            + "ORDER BY u.nombre_usuario";

    try (Connection conexion = Conexion.getConnection();
         PreparedStatement ps = conexion.prepareStatement(sql)) {

        ps.setInt(1, idCategoria);

        try (ResultSet rs = ps.executeQuery()) {//EJECUTA LA CONSULTA 

            while (rs.next()) {

                Usuario agente = new Usuario();

                agente.setId_usuario(
                        rs.getInt("id_usuario")
                );

                agente.setnombre_usuario(
                        rs.getString("nombre_usuario")
                );

                agentes.add(agente);
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return agentes;
}
}