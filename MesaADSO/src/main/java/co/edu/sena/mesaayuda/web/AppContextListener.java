package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.repositorio.CategoriaRepository;
import co.edu.sena.mesaayuda.repositorio.CategoriaRepositoryJDBC;

import co.edu.sena.mesaayuda.repositorio.ComentarioRepository;
import co.edu.sena.mesaayuda.repositorio.ComentarioRepositoryJDBC;

import co.edu.sena.mesaayuda.repositorio.ReporteRepositorio;
import co.edu.sena.mesaayuda.repositorio.ReporteRepositorioJDBC;

import co.edu.sena.mesaayuda.repositorio.TicketRepository;
import co.edu.sena.mesaayuda.repositorio.TicketRepositoryJDBC;

import co.edu.sena.mesaayuda.repositorio.UsuarioRepository;
import co.edu.sena.mesaayuda.repositorio.UsuarioRepositoryJDBC;

import co.edu.sena.mesaayuda.servicio.AsignacionService;
import co.edu.sena.mesaayuda.servicio.AsignacionServiceInterfaz;

import co.edu.sena.mesaayuda.servicio.CategoriaService;
import co.edu.sena.mesaayuda.servicio.CategoriaServiceInterfaz;

import co.edu.sena.mesaayuda.servicio.ComentarioService;
import co.edu.sena.mesaayuda.servicio.ComentarioServiceInterfaz;

import co.edu.sena.mesaayuda.servicio.ReporteService;
import co.edu.sena.mesaayuda.servicio.ReporteServiceInterfaz;

import co.edu.sena.mesaayuda.servicio.TicketService;
import co.edu.sena.mesaayuda.servicio.TicketServiceInterfaz;

import co.edu.sena.mesaayuda.servicio.UsuarioService;
import co.edu.sena.mesaayuda.servicio.UsuarioServiceInterfaz;

import co.edu.sena.mesaayuda.servicio.asignacion.AsignacionPorCategoria;
import co.edu.sena.mesaayuda.servicio.asignacion.EstrategiaAsignacion;

import co.edu.sena.mesaayuda.servicio.sla.EstrategiaSLA;
import co.edu.sena.mesaayuda.servicio.sla.SLAPrioridadAlta;
import co.edu.sena.mesaayuda.servicio.sla.SLAPrioridadBaja;
import co.edu.sena.mesaayuda.servicio.sla.SLAPrioridadCritica;
import co.edu.sena.mesaayuda.servicio.sla.SLAPrioridadMedia;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import java.util.HashMap;
import java.util.Map;

@WebListener
public class AppContextListener
        implements ServletContextListener {

    // =====================================================
    // CLAVES DEL SERVLET CONTEXT
    // =====================================================

    public static final String USUARIO_SERVICE =
            "usuarioService";

    public static final String TICKET_SERVICE =
            "ticketService";

    public static final String CATEGORIA_SERVICE =
            "categoriaService";

    public static final String COMENTARIO_SERVICE =
            "comentarioService";

    public static final String REPORTE_SERVICE =
            "reporteService";

    // =====================================================
    // INICIALIZAR APLICACIÓN
    // =====================================================

    @Override
    public void contextInitialized(
            ServletContextEvent evento) {

        ServletContext contexto =
                evento.getServletContext();

        // =================================================
        // 1. CREAR REPOSITORIOS
        // =================================================

        UsuarioRepository usuarioRepository =
                new UsuarioRepositoryJDBC();

        TicketRepository ticketRepository =
                new TicketRepositoryJDBC();

        CategoriaRepository categoriaRepository =
                new CategoriaRepositoryJDBC();

        ComentarioRepository comentarioRepository =
                new ComentarioRepositoryJDBC();

        ReporteRepositorio reporteRepositorio =
                new ReporteRepositorioJDBC();

        // =================================================
        // 2. CREAR ESTRATEGIA DE ASIGNACIÓN
        // =================================================

        EstrategiaAsignacion estrategiaAsignacion =
                new AsignacionPorCategoria(
                        usuarioRepository,
                        ticketRepository
                );

        // =================================================
        // 3. CREAR ASIGNACION SERVICE
        // =================================================

        AsignacionServiceInterfaz asignacionService =
                new AsignacionService(
                        ticketRepository,
                        usuarioRepository,
                        estrategiaAsignacion
                );

        // =================================================
        // 4. CREAR ESTRATEGIAS SLA
        // =================================================

        Map<String, EstrategiaSLA> estrategiasSLA =
                new HashMap<>();

        estrategiasSLA.put(
                "BAJA",
                new SLAPrioridadBaja()
        );

        estrategiasSLA.put(
                "MEDIA",
                new SLAPrioridadMedia()
        );

        estrategiasSLA.put(
                "ALTA",
                new SLAPrioridadAlta()
        );

        estrategiasSLA.put(
                "CRITICA",
                new SLAPrioridadCritica()
        );

        // =================================================
        // 5. CREAR USUARIO SERVICE
        // =================================================

        UsuarioServiceInterfaz usuarioService =
                new UsuarioService(
                        usuarioRepository
                );

        // =================================================
        // 6. CREAR TICKET SERVICE
        // =================================================

        TicketServiceInterfaz ticketService =
                new TicketService(
                        ticketRepository,
                        (AsignacionService) asignacionService,
                        (UsuarioService) usuarioService,
                        estrategiasSLA
                );

        // =================================================
        // 7. CREAR CATEGORIA SERVICE
        // =================================================

        CategoriaServiceInterfaz categoriaService =
                new CategoriaService(
                        categoriaRepository
                );

        // =================================================
        // 8. CREAR COMENTARIO SERVICE
        // =================================================

        ComentarioServiceInterfaz comentarioService =
                new ComentarioService(
                        comentarioRepository
                );

        // =================================================
        // 9. CREAR REPORTE SERVICE
        // =================================================

        ReporteServiceInterfaz reporteService =
                new ReporteService(
                        reporteRepositorio
                );

        // =================================================
        // 10. PUBLICAR SERVICES
        // =================================================

        contexto.setAttribute(
                USUARIO_SERVICE,
                usuarioService
        );

        contexto.setAttribute(
                TICKET_SERVICE,
                ticketService
        );

        contexto.setAttribute(
                CATEGORIA_SERVICE,
                categoriaService
        );

        contexto.setAttribute(
                COMENTARIO_SERVICE,
                comentarioService
        );

        contexto.setAttribute(
                REPORTE_SERVICE,
                reporteService
        );
    }

    // =====================================================
    // DESTRUIR APLICACIÓN
    // =====================================================

    @Override
    public void contextDestroyed(
            ServletContextEvent evento) {

        /*
         * Los repositorios JDBC se encargan
         * de abrir y cerrar sus conexiones.
         */
    }
}