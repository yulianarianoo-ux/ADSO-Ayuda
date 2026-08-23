package co.edu.sena.mesaayuda.repositorio;

import co.edu.sena.mesaayuda.modelo.Usuario;
import java.util.List;

public interface UsuarioRepository {

    Usuario autenticar(
            String correo,
            String contrasena
    );

    List<Usuario> listarPorRol(
            String tipoRol
    );

    List<Usuario> listarAgentesPorCategoria(
            int idCategoria
    );
}