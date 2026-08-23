package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.modelo.Comentario;
import co.edu.sena.mesaayuda.repositorio.ComentarioRepository;

import java.util.List;

public class ComentarioService
        implements ComentarioServiceInterfaz {

    private final ComentarioRepository comentarioRepository;

    // =====================================================
    // CONSTRUCTOR
    // =====================================================

    public ComentarioService(
            ComentarioRepository comentarioRepository) {

        this.comentarioRepository = comentarioRepository;
    }

    // =====================================================
    // LISTAR POR TICKET
    // =====================================================

    @Override
    public List<Comentario> listarPorTicket(int idTicket) {

        return comentarioRepository.listarPorTicket(
                idTicket
        );
    }

    // =====================================================
    // BUSCAR POR ID
    // =====================================================

    @Override
    public Comentario buscarPorId(int idComentario) {

        return comentarioRepository.buscarPorId(
                idComentario
        );
    }

    // =====================================================
    // GUARDAR
    // =====================================================

    @Override
    public boolean guardar(Comentario comentario) {

        if (comentario == null) {
            return false;
        }

        if (comentario.getTicket() == null) {
            return false;
        }

        if (comentario.getUsuario() == null) {
            return false;
        }

        if (comentario.getTexto() == null ||
            comentario.getTexto().trim().isEmpty()) {

            return false;
        }

        return comentarioRepository.guardar(
                comentario
        );
    }

    // =====================================================
    // ACTUALIZAR
    // =====================================================

    @Override
    public boolean actualizar(Comentario comentario) {

        if (comentario == null) {
            return false;
        }

        if (comentario.getTexto() == null ||
            comentario.getTexto().trim().isEmpty()) {

            return false;
        }

        return comentarioRepository.actualizar(
                comentario
        );
    }
}