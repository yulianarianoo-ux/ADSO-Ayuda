package co.edu.sena.mesaayuda.servicio;

import java.util.List;
import java.util.Map;

public interface ReporteServiceInterfaz {

    int totalTickets();

    List<Map<String, Object>> ticketsPorEstado();

    List<Map<String, Object>> ticketsPorPrioridad();

    List<Map<String, Object>> ticketsPorCategoria();

    List<Map<String, Object>> ticketsPorAgente();

    int slasVencidos();
}