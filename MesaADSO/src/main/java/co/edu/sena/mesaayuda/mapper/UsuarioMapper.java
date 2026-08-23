package co.edu.sena.mesaayuda.mapper;

import co.edu.sena.mesaayuda.dto.UsuarioDTO;
import co.edu.sena.mesaayuda.modelo.Usuario;

public class UsuarioMapper {

    public static UsuarioDTO toDTO(Usuario usuario) {

        return new UsuarioDTO(
                usuario.getId_usuario(),
                usuario.getnombre_usuario(),
                usuario.getCorreo(),
                usuario.getRol()
        );
    }
}