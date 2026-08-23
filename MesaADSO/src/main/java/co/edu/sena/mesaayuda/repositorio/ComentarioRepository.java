/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package co.edu.sena.mesaayuda.repositorio;
    
/**
 *
 * @author User
 */
import co.edu.sena.mesaayuda.modelo.Comentario;
import java.util.List;

public interface ComentarioRepository {

    boolean guardar(Comentario comentario);

    List<Comentario> listarPorTicket(int idTicket);

    boolean actualizar(Comentario comentario);
    
    Comentario buscarPorId(int idComentario);
}
