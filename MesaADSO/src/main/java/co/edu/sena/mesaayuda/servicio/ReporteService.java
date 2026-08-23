package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.repositorio.ReporteRepositorio;

import java.util.List;
import java.util.Map;

public class ReporteService
        implements ReporteServiceInterfaz {

    private final ReporteRepositorio reporteRepositorio;

    public ReporteService(
            ReporteRepositorio reporteRepositorio) {

        this.reporteRepositorio = reporteRepositorio;
    }

    @Override
    public int totalTickets() {

        return reporteRepositorio.totalTickets();
    }

    @Override
    public List<Map<String, Object>> ticketsPorEstado() {

        return reporteRepositorio.ticketsPorEstado();
    }

    @Override
    public List<Map<String, Object>> ticketsPorPrioridad() {

        return reporteRepositorio.ticketsPorPrioridad();
    }

    @Override
    public List<Map<String, Object>> ticketsPorCategoria() {

        return reporteRepositorio.ticketsPorCategoria();
    }

    @Override
    public List<Map<String, Object>> ticketsPorAgente() {

        return reporteRepositorio.ticketsPorAgente();
    }

    @Override
    public int slasVencidos() {

        return reporteRepositorio.slasVencidos();
    }
}