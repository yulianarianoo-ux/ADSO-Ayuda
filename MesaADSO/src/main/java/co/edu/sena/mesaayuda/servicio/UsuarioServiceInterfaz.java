package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.modelo.Usuario;

import java.util.List;

public interface UsuarioServiceInterfaz {

    Usuario autenticar(String correo, String contrasena);

    List<Usuario> listarAgentes();

    List<Usuario> listarAgentesPorCategoria(int idCategoria);
}