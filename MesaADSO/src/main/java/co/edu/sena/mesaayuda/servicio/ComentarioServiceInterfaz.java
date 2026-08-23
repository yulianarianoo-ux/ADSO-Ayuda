package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.modelo.Comentario;

import java.util.List;

public interface ComentarioServiceInterfaz {

    List<Comentario> listarPorTicket(int idTicket);

    Comentario buscarPorId(int idComentario);

    boolean guardar(Comentario comentario);

    boolean actualizar(Comentario comentario);
}