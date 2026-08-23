package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.modelo.Categoria;
import co.edu.sena.mesaayuda.repositorio.CategoriaRepository;

import java.util.List;

public class CategoriaService
        implements CategoriaServiceInterfaz {

    private final CategoriaRepository categoriaRepository;

    public CategoriaService(
            CategoriaRepository categoriaRepository) {

        this.categoriaRepository = categoriaRepository;
    }

    @Override
    public List<Categoria> listarTodas() {

        return categoriaRepository.listarTodas();
    }
}