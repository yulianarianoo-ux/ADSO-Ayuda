package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.modelo.Usuario;
import co.edu.sena.mesaayuda.repositorio.UsuarioRepository;

import java.util.List;

public class UsuarioService implements UsuarioServiceInterfaz {

    private final UsuarioRepository usuarioRepository;

    public UsuarioService(
            UsuarioRepository usuarioRepository) {

        this.usuarioRepository = usuarioRepository;
    }

    @Override
    public Usuario autenticar(
            String correo,
            String contrasena) {

        return usuarioRepository.autenticar(
                correo,
                contrasena
        );
    }

    @Override
    public List<Usuario> listarAgentes() {

        return usuarioRepository.listarPorRol(
                "AGENTE"
        );
    }

    @Override
    public List<Usuario> listarAgentesPorCategoria(
            int idCategoria) {

        return usuarioRepository.listarAgentesPorCategoria(
                idCategoria
        );
    }
}