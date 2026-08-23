package co.edu.sena.mesaayuda.repositorio;

import co.edu.sena.mesaayuda.modelo.Categoria;
import co.edu.sena.mesaayuda.util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoriaRepositoryJDBC implements CategoriaRepository {

  @Override
public List<Categoria> listarTodas() {

    List<Categoria> categorias = new ArrayList<>();

    String sql =
            "SELECT id_categoria, nombre_categoria " +
            "FROM categoria " +
            "ORDER BY nombre_categoria";

    try (
        Connection connection = Conexion.getConnection();
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()
    ) {

        while (rs.next()) {

            Categoria categoria = new Categoria();

            categoria.setId_categoria(
                    rs.getInt("id_categoria")
            );

            categoria.setnombre_categoria(
                    rs.getString("nombre_categoria")
            );

           

            categorias.add(categoria);
        }

    } catch (Exception e) {

        System.err.println(
                "ERROR AL LISTAR CATEGORÍAS: "
                + e.getMessage()
        );

        e.printStackTrace();
    }

    return categorias;
}
}