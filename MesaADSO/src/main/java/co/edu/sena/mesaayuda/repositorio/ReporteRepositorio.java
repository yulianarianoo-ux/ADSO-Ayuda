package co.edu.sena.mesaayuda.repositorio;

import java.util.List;
import java.util.Map;

public interface ReporteRepositorio {

    int totalTickets();

    List<Map<String, Object>> ticketsPorEstado();

    List<Map<String, Object>> ticketsPorPrioridad();

    List<Map<String, Object>> ticketsPorCategoria();

    List<Map<String, Object>> ticketsPorAgente();

    int slasVencidos();
}