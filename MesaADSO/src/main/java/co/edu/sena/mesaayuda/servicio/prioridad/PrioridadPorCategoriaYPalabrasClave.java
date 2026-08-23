package co.edu.sena.mesaayuda.servicio.prioridad;

import co.edu.sena.mesaayuda.modelo.Prioridad;
import co.edu.sena.mesaayuda.modelo.Ticket;

import java.text.Normalizer;
import java.util.List;
import java.util.Locale;

public class PrioridadPorCategoriaYPalabrasClave
        implements EstrategiaPrioridad {

    @Override
    public Prioridad determinar(
            Ticket ticket,
            List<Prioridad> prioridades) {

        if (ticket == null
                || prioridades == null
                || prioridades.isEmpty()) {

            return null;
        }

        String titulo =
                normalizar(ticket.getTitulo());

        String descripcion =
                normalizar(ticket.getDescripcion());

        String textoCompleto =
                titulo + " " + descripcion;

        // =====================================================
        // PRIORIDAD ALTA
        // =====================================================

        String[] palabrasAlta = {
            "urgente",
            "emergencia",
            "caido",
            "caida",
            "no funciona",
            "bloqueado",
            "bloqueada",
            "sin acceso",
            "servidor caido",
            "sistema caido",
            "error critico",
            "critico",
            "critica",
            "todos los usuarios",
            "todo el sistema"
        };

        for (String palabra : palabrasAlta) {

            if (textoCompleto.contains(palabra)) {

                Prioridad prioridad =
                        buscarPrioridad(
                                prioridades,
                                "ALTA"
                        );

                if (prioridad != null) {
                    return prioridad;
                }
            }
        }

        // =====================================================
        // PRIORIDAD MEDIA
        // =====================================================

        String[] palabrasMedia = {
            "error",
            "falla",
            "fallo",
            "problema",
            "lento",
            "lentitud",
            "no puedo",
            "no permite",
            "contrasena",
            "correo",
            "impresora",
            "internet"
        };

        for (String palabra : palabrasMedia) {

            if (textoCompleto.contains(palabra)) {

                Prioridad prioridad =
                        buscarPrioridad(
                                prioridades,
                                "MEDIA"
                        );

                if (prioridad != null) {
                    return prioridad;
                }
            }
        }

        // =====================================================
        // PRIORIDAD SEGÚN CATEGORÍA
        // =====================================================

        if (ticket.getCategoria() != null) {

            String categoria =
                    normalizar(
                            ticket.getCategoria()
                                    .getnombre_categoria()
                    );

            if (categoria.contains("red")) {

                return buscarPrioridad(
                        prioridades,
                        "MEDIA"
                );
            }

            if (categoria.contains("software")) {

                return buscarPrioridad(
                        prioridades,
                        "MEDIA"
                );
            }

            if (categoria.contains("hardware")) {

                return buscarPrioridad(
                        prioridades,
                        "MEDIA"
                );
            }

            if (categoria.contains("mantenimiento")) {

                return buscarPrioridad(
                        prioridades,
                        "BAJA"
                );
            }
        }

        // =====================================================
        // PRIORIDAD POR DEFECTO
        // =====================================================

        Prioridad prioridadMedia =
                buscarPrioridad(
                        prioridades,
                        "MEDIA"
                );

        if (prioridadMedia != null) {
            return prioridadMedia;
        }

        return prioridades.get(0);
    }

    // =========================================================
    // BUSCAR PRIORIDAD
    // =========================================================

    private Prioridad buscarPrioridad(
            List<Prioridad> prioridades,
            String nombre) {

        for (Prioridad prioridad : prioridades) {

            if (prioridad.gettipo_prioridad() != null
                    && prioridad
                            .gettipo_prioridad()
                            .trim()
                            .equalsIgnoreCase(nombre)) {

                return prioridad;
            }
        }

        return null;
    }

    // =========================================================
    // NORMALIZAR TEXTO
    // =========================================================

    private String normalizar(String texto) {

        if (texto == null) {
            return "";
        }

        String resultado =
                Normalizer.normalize(
                        texto,
                        Normalizer.Form.NFD
                );

        resultado =
                resultado.replaceAll(
                        "\\p{InCombiningDiacriticalMarks}+",
                        ""
                );

        return resultado
                .toLowerCase(Locale.ROOT)
                .trim();
    }
}