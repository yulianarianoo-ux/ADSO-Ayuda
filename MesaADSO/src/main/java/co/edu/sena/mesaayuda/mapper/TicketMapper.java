package co.edu.sena.mesaayuda.mapper;

import co.edu.sena.mesaayuda.dto.TicketDTO;
import co.edu.sena.mesaayuda.modelo.Ticket;

public class TicketMapper {

    public static TicketDTO toDTO(Ticket ticket) {

        if (ticket == null) {
            return null;
        }

        String categoria = null;
        String prioridad = null;
        String solicitante = null;
        String agente = null;
        String estado = null;
        int idCategoria = 0;
        int horasSLA = 0;

        // =====================================================
        // CATEGORÍA
        // =====================================================
        if (ticket.getCategoria() != null) {
            idCategoria =
                    ticket.getCategoria().getId_categoria();
            categoria =
                    ticket.getCategoria().getnombre_categoria();
        }

        // =====================================================
        // PRIORIDAD + SLA
        // =====================================================
        if (ticket.getPrioridad() != null) {
            prioridad =
                    ticket.getPrioridad().gettipo_prioridad();
            horasSLA =
                    ticket.getPrioridad().getSla_horas();
        }

        // =====================================================
        // SOLICITANTE
        // =====================================================
        if (ticket.getSolicitante() != null) {
            solicitante =
                    ticket.getSolicitante().getnombre_usuario();
        }

        // =====================================================
        // AGENTE
        // =====================================================
        if (ticket.getAgente() != null) {
            agente =
                    ticket.getAgente().getnombre_usuario();
        }

        // =====================================================
        // ESTADO
        // =====================================================
        if (ticket.getEstado() != null) {
            estado =
                    ticket.getEstado().nombre();
        }

        // =====================================================
        // CREAR DTO
        // =====================================================
        TicketDTO dto = new TicketDTO(
                ticket.getId_ticket(),
                ticket.getTitulo(),
                ticket.getDescripcion(),
                idCategoria,
                categoria,
                prioridad,
                solicitante,
                agente,
                estado,
                ticket.getFecha_creacion()
        );

        // =====================================================
        // COMENTARIOS
        // =====================================================
        if (ticket.getComentarios() != null) {
            dto.setComentarios(
                    ticket.getComentarios()
            );
        }

        // =====================================================
        // SLA DESDE LA BASE DE DATOS
        // =====================================================
        dto.setHorasSLA(horasSLA);

        return dto;
    }
}