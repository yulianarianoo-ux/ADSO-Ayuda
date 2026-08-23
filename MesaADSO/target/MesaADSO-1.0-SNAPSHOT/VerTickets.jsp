<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="co.edu.sena.mesaayuda.dto.TicketDTO"%>
<%@page import="co.edu.sena.mesaayuda.modelo.Usuario"%>
<%@page import="co.edu.sena.mesaayuda.modelo.Categoria"%>

<%!
    private String escapeAttr(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    String nombreUsuario = (usuario != null && usuario.getnombre_usuario() != null)
            ? usuario.getnombre_usuario()
            : "Invitado";

    String iniciales = "?";

    if (usuario != null) {
        String[] partes = nombreUsuario.trim().split("\\s+");
        StringBuilder sb = new StringBuilder();

        for (String parte : partes) {
            if (!parte.isEmpty()) {
                sb.append(parte.charAt(0));
            }
        }

        iniciales = sb.toString().toUpperCase();

        if (iniciales.length() > 2) {
            iniciales = iniciales.substring(0, 2);
        }
    }

    List<TicketDTO> tickets =
            (List<TicketDTO>) request.getAttribute("tickets");

    List<Categoria> categorias =
            (List<Categoria>) request.getAttribute("categorias");

    Map<Integer, List<Usuario>> agentesPorTicket =
            (Map<Integer, List<Usuario>>) request.getAttribute("agentesPorTicket");
%>

<!DOCTYPE html>
<html lang="es" class="h-full bg-emerald-950/10">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SENA CIMM Support - Gestión de Tickets</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0">

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Plus Jakarta Sans', 'sans-serif'],
                    },
                    colors: {
                        sena: {
                            50: '#f0fdf4',
                            100: '#dcfce7',
                            200: '#bbf7d0',
                            300: '#86efac',
                            400: '#39a900',
                            500: '#2e8800',
                            600: '#236900',
                            700: '#1a4f00',
                            800: '#143d00',
                            900: '#0d2900',
                        }
                    }
                }
            }
        };
    </script>
</head>

<body class="min-h-full flex flex-col font-sans text-emerald-950 antialiased bg-emerald-950/10">

<!-- MENSAJES SWEETALERT -->
<%
    String mensajeExito = (String) session.getAttribute("mensajeExito");
    String mensajeError = (String) session.getAttribute("mensajeError");

    if (mensajeExito != null) {
%>
<script>
document.addEventListener("DOMContentLoaded", function () {
    Swal.fire({
        icon: "success",
        title: "¡Operación exitosa!",
        text: "<%= escapeAttr(mensajeExito) %>",
        confirmButtonText: "Continuar",
        confirmButtonColor: "#39a900"
    });
});
</script>
<%
        session.removeAttribute("mensajeExito");
    }

    if (mensajeError != null) {
%>
<script>
document.addEventListener("DOMContentLoaded", function () {
    Swal.fire({
        icon: "error",
        title: "Error",
        text: "<%= escapeAttr(mensajeError) %>",
        confirmButtonText: "Continuar",
        confirmButtonColor: "#2e8800"
    });
});
</script>
<%
        session.removeAttribute("mensajeError");
    }
%>

<!-- HEADER SENA EN VERDE INTENSO -->
<header class="sticky top-0 z-40 w-full bg-gradient-to-r from-sena-800 via-sena-700 to-sena-800 text-white shadow-xl border-b-2 border-sena-400">
    <div class="max-w-7xl mx-auto h-16 px-4 sm:px-6 lg:px-8 flex items-center justify-between">
        <a href="PanelPrincipal.jsp" class="flex items-center gap-3 group">
            <div class="w-10 h-10 rounded-xl bg-sena-400 text-white flex items-center justify-center font-bold shadow-md ring-2 ring-white/20 group-hover:scale-105 transition-all">
                <span class="material-symbols-outlined text-xl">confirmation_number</span>
            </div>
            <div class="flex flex-col leading-tight">
                <span class="font-extrabold text-base text-white tracking-tight">SENA <span class="text-sena-300">CIMM</span></span>
                <span class="text-[10px] font-bold text-sena-100 uppercase tracking-widest">Mesa de Ayuda</span>
            </div>
        </a>

        <div class="flex items-center gap-4">
            <a href="PanelPrincipal.jsp" class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-lg bg-sena-900 hover:bg-sena-950 text-sena-100 text-xs font-bold transition-all border border-sena-500/40 shadow-sm">
                <span class="material-symbols-outlined text-sm">arrow_back</span>
                Volver al Panel
            </a>

            <div class="flex items-center gap-3 pl-3 border-l border-sena-600">
                <div class="w-8 h-8 rounded-full bg-sena-400 text-white flex items-center justify-center text-xs font-black shadow-md ring-2 ring-white/30">
                    <%= iniciales %>
                </div>
                <div class="hidden sm:flex flex-col text-left leading-none">
                    <span class="text-[10px] font-bold text-sena-200 uppercase">Usuario</span>
                    <span class="text-xs font-bold text-white mt-0.5"><%= escapeAttr(nombreUsuario) %></span>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- CONTENIDO PRINCIPAL -->
<main class="flex-grow py-8 px-4 sm:px-6 lg:px-8 max-w-7xl w-full mx-auto space-y-6">

    <!-- HERO / BANNER PRINCIPAL EN VERDE SENA OSCURO -->
    <div class="bg-gradient-to-r from-sena-900 via-sena-800 to-sena-900 rounded-2xl p-6 shadow-lg border border-sena-700 text-white flex flex-col md:flex-row items-start md:items-center justify-between gap-4">
        <div class="flex items-center gap-4">
            <div class="w-12 h-12 rounded-xl bg-sena-400 text-white flex items-center justify-center shadow-lg ring-4 ring-sena-400/30">
                <span class="material-symbols-outlined text-2xl">assignment</span>
            </div>
            <div>
                <h1 class="text-2xl font-black text-white tracking-tight flex items-center gap-2">
                    Gestión de Tickets
                </h1>
                <p class="text-xs font-medium text-sena-100 mt-1">
                    Monitorea, asigna y da seguimiento en tiempo real a los casos de soporte técnico.
                </p>
            </div>
        </div>
    </div>

<% if (tickets != null && !tickets.isEmpty()) { %>

    <!-- BARRA DE FILTROS EN VERDE OSCURO -->
    <div class="bg-sena-800 p-4 rounded-xl shadow-md border border-sena-700 grid grid-cols-1 sm:grid-cols-3 gap-3">
        <div class="relative">
            <input type="text" id="filtroBusqueda" onkeyup="filtrarTabla()" placeholder="Buscar por asunto o descripción..." class="w-full pl-9 pr-4 py-2.5 rounded-lg border border-sena-600 bg-sena-900/90 text-xs font-medium text-white placeholder-sena-200/60 focus:outline-none focus:border-sena-300 focus:ring-2 focus:ring-sena-300/30 transition-all">
            <span class="material-symbols-outlined absolute left-2.5 top-2.5 text-sena-200/70 text-base">search</span>
        </div>
        <div class="relative">
            <select id="filtroCategoria" onchange="filtrarTabla()" class="w-full pl-9 pr-4 py-2.5 rounded-lg border border-sena-600 bg-sena-900/90 text-xs font-medium text-white focus:outline-none focus:border-sena-300 focus:ring-2 focus:ring-sena-300/30 transition-all appearance-none">
                <option value="" class="bg-sena-900 text-white">Todas las categorías</option>
                <%
                    if (categorias != null) {
                        for (Categoria categoria : categorias) {
                            if (categoria != null && categoria.getnombre_categoria() != null) {
                %>
                    <option value="<%= escapeAttr(categoria.getnombre_categoria()) %>" class="bg-sena-900 text-white">
                        <%= escapeAttr(categoria.getnombre_categoria()) %>
                    </option>
                <%
                            }
                        }
                    }
                %>
            </select>
            <span class="material-symbols-outlined absolute left-2.5 top-2.5 text-sena-200/70 text-base pointer-events-none">category</span>
        </div>
        <div class="relative">
            <input type="date" id="filtroFecha" onchange="filtrarTabla()" class="w-full pl-9 pr-4 py-2.5 rounded-lg border border-sena-600 bg-sena-900/90 text-xs font-medium text-white focus:outline-none focus:border-sena-300 focus:ring-2 focus:ring-sena-300/30 transition-all">
            <span class="material-symbols-outlined absolute left-2.5 top-2.5 text-sena-200/70 text-base pointer-events-none">calendar_today</span>
        </div>
    </div>

    <!-- TABLA CON ENCABEZADO Y BORDES VERDES -->
    <div class="bg-white border border-sena-200 rounded-2xl overflow-hidden shadow-xl">
        <div class="overflow-x-auto">
            <table id="tablaTickets" class="w-full text-left border-collapse">
                <thead>
                    <tr class="bg-sena-700 text-white text-[11px] uppercase font-bold tracking-wider border-b-2 border-sena-800">
                        <th class="py-4 px-4">Asunto / Detalle</th>
                        <th class="py-4 px-4">Categoría</th>
                        <th class="py-4 px-4">Prioridad</th>
                        <th class="py-4 px-4">Estado</th>
                        <th class="py-4 px-4">Fecha</th>
                        <th class="py-4 px-4 text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-sena-100 text-xs bg-sena-50/20">
<%
    for (TicketDTO ticket : tickets) {
        String estado = ticket.getEstado() != null ? ticket.getEstado() : "";
        String prioridad = ticket.getPrioridad() != null ? ticket.getPrioridad() : "";
        String categoria = ticket.getCategoria() != null ? ticket.getCategoria() : "";
        String agente = ticket.getAgente() != null ? ticket.getAgente() : "";
        String fecha = ticket.getFecha_creacion() != null ? ticket.getFecha_creacion().toString() : "";
        String titulo = ticket.getTitulo() != null ? ticket.getTitulo() : "";
        String descripcion = ticket.getDescripcion() != null ? ticket.getDescripcion() : "";

        // LÓGICA DE COLORES SEGÚN EL ESTADO
        String estNormalizado = estado.trim().toUpperCase();
        String badgeEstadoClases = "bg-emerald-100 text-emerald-900 border-emerald-300";
        boolean esCancelado = estNormalizado.contains("CANCELADO") || estNormalizado.contains("RECHAZADO");

        if (estNormalizado.contains("ABIERTO") || estNormalizado.contains("NUEVO")) {
            badgeEstadoClases = "bg-teal-100 text-teal-900 border-teal-300 font-bold";
        } else if (estNormalizado.contains("PROCESO") || estNormalizado.contains("ASIGNADO") || estNormalizado.contains("PENDIENTE")) {
            badgeEstadoClases = "bg-amber-100 text-amber-900 border-amber-300 font-bold";
        } else if (estNormalizado.contains("RESUELTO") || estNormalizado.contains("CERRADO") || estNormalizado.contains("FINALIZADO")) {
            badgeEstadoClases = "bg-sena-100 text-sena-800 border-sena-300 font-bold";
        } else if (esCancelado) {
            badgeEstadoClases = "bg-rose-100 text-rose-800 border-rose-300 font-bold";
        }

        // LÓGICA DE COLORES SEGÚN LA PRIORIDAD
        String prioNormalizada = prioridad.trim().toUpperCase();
        String badgePrioridadClases = "bg-emerald-100 text-emerald-900 border-emerald-300";

        if (prioNormalizada.contains("ALTA") || prioNormalizada.contains("URGENTE") || prioNormalizada.contains("CRÍTICA")) {
            badgePrioridadClases = "bg-rose-100 text-rose-800 border-rose-300 font-bold";
        } else if (prioNormalizada.contains("MEDIA")) {
            badgePrioridadClases = "bg-amber-100 text-amber-900 border-amber-300 font-bold";
        } else if (prioNormalizada.contains("BAJA")) {
            badgePrioridadClases = "bg-sena-100 text-sena-800 border-sena-300 font-bold";
        }
%>
                    <tr class="fila-ticket bg-white hover:bg-sena-50/70 transition-colors border-l-4 border-l-sena-500" data-categoria="<%= escapeAttr(categoria) %>" data-fecha="<%= escapeAttr(fecha) %>">
                        <td class="py-3.5 px-4 max-w-xs">
                            <p class="font-bold text-emerald-950 text-xs"><%= escapeAttr(titulo) %></p>
                            <p class="text-[11px] text-emerald-800/80 mt-0.5 truncate"><%= escapeAttr(descripcion) %></p>
                        </td>
                        <td class="py-3.5 px-4 font-medium text-emerald-900 whitespace-nowrap">
                            <% if (!categoria.isEmpty()) { %>
                                <span class="px-2.5 py-1 rounded-md bg-sena-100/60 border border-sena-300/80 text-sena-800 font-bold text-[11px]">
                                    <%= escapeAttr(categoria) %>
                                </span>
                            <% } else { %>
                                <span class="text-emerald-400 italic">Sin asignar</span>
                            <% } %>
                        </td>
                        <td class="py-3.5 px-4 whitespace-nowrap">
                            <% if (!prioridad.isEmpty()) { %>
                                <span class="px-2.5 py-1 rounded-full border text-[10px] uppercase shadow-xs <%= badgePrioridadClases %>">
                                    <%= escapeAttr(prioridad) %>
                                </span>
                            <% } else { %>
                                <span class="text-emerald-400">N/A</span>
                            <% } %>
                        </td>
                        <td class="py-3.5 px-4 whitespace-nowrap">
                            <% if (!estado.isEmpty()) { %>
                                <span class="px-2.5 py-1 rounded-full border text-[10px] uppercase inline-flex items-center gap-1.5 shadow-xs <%= badgeEstadoClases %>">
                                    <span class="w-2 h-2 rounded-full bg-current"></span>
                                    <%= escapeAttr(estado) %>
                                </span>
                            <% } else { %>
                                <span class="text-emerald-400">N/A</span>
                            <% } %>
                        </td>
                        <td class="py-3.5 px-4 text-emerald-800 font-bold whitespace-nowrap"><%= escapeAttr(fecha) %></td>
                        <td class="py-3.5 px-4 text-center whitespace-nowrap">
                            <div class="flex items-center justify-center gap-2">

                                <!-- BOTÓN REASIGNAR -->
                                <% if (esCancelado) { %>
                                    <button type="button"
                                            disabled
                                            title="No se puede reasignar un ticket cancelado"
                                            class="p-2 rounded-lg bg-emerald-100/50 text-emerald-400 border border-emerald-200 cursor-not-allowed">
                                        <span class="material-symbols-outlined text-lg">person_add_disabled</span>
                                    </button>
                                <% } else { %>
                                    <button type="button"
                                            onclick="abrirModalReasignar(this)"
                                            data-id="<%= ticket.getId_ticket() %>"
                                            data-titulo="<%= escapeAttr(titulo) %>"
                                            data-descripcion="<%= escapeAttr(descripcion) %>"
                                            data-categoria="<%= escapeAttr(categoria) %>"
                                            data-prioridad="<%= escapeAttr(prioridad) %>"
                                            data-estado="<%= escapeAttr(estado) %>"
                                            data-fecha="<%= escapeAttr(fecha) %>"
                                            data-agente="<%= escapeAttr(agente) %>"
                                            title="Reasignar agente"
                                            class="p-2 rounded-lg bg-sena-50 text-sena-700 hover:bg-sena-500 hover:text-white border border-sena-300 transition-all shadow-xs">
                                        <span class="material-symbols-outlined text-lg">person_add</span>
                                    </button>
                                <% } %>

                                <!-- BOTÓN CANCELAR -->
                                <form action="<%= request.getContextPath() %>/tickets"
                                      method="POST"
                                      class="inline"
                                      onsubmit="confirmarCancelacion(event, '<%= escapeAttr(titulo) %>');">

                                    <input type="hidden" name="action" value="eliminar">
                                    <input type="hidden" name="id_ticket" value="<%= ticket.getId_ticket() %>">

                                    <button type="submit"
                                            title="Cancelar ticket"
                                            class="p-2 rounded-lg bg-rose-50 text-rose-700 hover:bg-rose-600 hover:text-white border border-rose-300 transition-all shadow-xs">
                                        <span class="material-symbols-outlined text-lg">cancel</span>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
<% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- CONTENEDOR OCULTO DE AGENTES POR TICKET -->
    <div id="contenedorAgentesPorTicket" class="hidden">
<%
        if (agentesPorTicket != null) {
            for (TicketDTO ticket : tickets) {
                List<Usuario> agentesTicket = agentesPorTicket.get(ticket.getId_ticket());
                if (agentesTicket == null) {
                    agentesTicket = new java.util.ArrayList<>();
                }
%>
        <div class="lista-agentes-ticket" data-ticket-id="<%= ticket.getId_ticket() %>">
<%
                for (Usuario ag : agentesTicket) {
%>
            <div class="agente-ticket" data-id="<%= ag.getId_usuario() %>" data-nombre="<%= escapeAttr(ag.getnombre_usuario()) %>">
                <%= escapeAttr(ag.getnombre_usuario()) %>
            </div>
<%
                }
%>
        </div>
<%
            }
        }
%>
    </div>

<% } else { %>

    <!-- ESTADO VACÍO EN VERDE OSCURO -->
    <div class="bg-sena-800 rounded-2xl p-12 border border-sena-700 text-center max-w-md mx-auto shadow-xl text-white">
        <div class="w-16 h-16 rounded-full bg-sena-500/20 border border-sena-400/40 text-sena-300 mx-auto flex items-center justify-center mb-4">
            <span class="material-symbols-outlined text-3xl">inbox</span>
        </div>
        <h3 class="font-bold text-lg text-white">No hay tickets registrados</h3>
        <p class="text-xs text-sena-100 mt-1">Actualmente no existen casos de soporte registrados en la plataforma.</p>
    </div>

<% } %>

</main>

<!-- MODAL REASIGNAR -->
<div id="modalReasignar" class="fixed inset-0 z-50 hidden bg-sena-950/70 backdrop-blur-md items-center justify-center p-4">
    <div class="bg-white rounded-2xl shadow-2xl max-w-md w-full overflow-hidden border border-sena-200 animate-in fade-in zoom-in-95 duration-150">
        <div class="flex items-center justify-between bg-gradient-to-r from-sena-800 via-sena-700 to-sena-800 text-white p-4 border-b border-sena-800">
            <h3 class="text-sm font-black flex items-center gap-2 tracking-wide">
                <span class="material-symbols-outlined text-lg">person_add</span>
                Reasignar Ticket
            </h3>
            <button type="button" onclick="cerrarModalReasignar()" class="text-sena-100 hover:text-white p-1 rounded-lg hover:bg-white/10 transition-colors">
                <span class="material-symbols-outlined text-lg">close</span>
            </button>
        </div>

        <div class="p-5 space-y-4 bg-sena-50/30">
            <div class="space-y-2.5 bg-white rounded-xl p-4 border border-sena-200 shadow-xs text-xs">
                <div>
                    <span class="text-[10px] uppercase font-black text-sena-700/60 block tracking-wider">Título</span>
                    <p id="info_titulo" class="font-bold text-emerald-950 text-xs mt-0.5"></p>
                </div>
                <div>
                    <span class="text-[10px] uppercase font-black text-sena-700/60 block tracking-wider">Descripción</span>
                    <p id="info_descripcion" class="text-emerald-800/80 mt-0.5 line-clamp-2"></p>
                </div>

                <div class="grid grid-cols-2 gap-2 pt-2.5 border-t border-sena-100">
                    <div>
                        <span class="text-[10px] uppercase font-black text-sena-700/60 block tracking-wider">Categoría</span>
                        <p id="info_categoria" class="font-bold text-emerald-900 mt-0.5"></p>
                    </div>
                    <div>
                        <span class="text-[10px] uppercase font-black text-sena-700/60 block tracking-wider">Prioridad</span>
                        <p id="info_prioridad" class="font-bold text-emerald-900 mt-0.5"></p>
                    </div>
                    <div>
                        <span class="text-[10px] uppercase font-black text-sena-700/60 block tracking-wider">Estado</span>
                        <p id="info_estado" class="font-bold text-emerald-900 mt-0.5"></p>
                    </div>
                    <div>
                        <span class="text-[10px] uppercase font-black text-sena-700/60 block tracking-wider">Fecha</span>
                        <p id="info_fecha" class="font-bold text-emerald-900 mt-0.5"></p>
                    </div>
                </div>

                <div class="pt-2.5 border-t border-sena-100">
                    <span class="text-[10px] uppercase font-black text-sena-700/60 block tracking-wider">Agente Actual</span>
                    <p id="info_agente_actual" class="font-black text-sena-600 text-xs mt-0.5"></p>
                </div>
            </div>

            <form id="formReasignar" action="<%= request.getContextPath() %>/tickets" method="POST" class="space-y-4">
                <input type="hidden" name="action" value="reasignar">
                <input type="hidden" name="id_ticket" id="modal_id_ticket">

                <div>
                    <label for="id_agente" class="block text-xs font-bold text-emerald-950 mb-1.5">Nuevo Agente Asignado:</label>
                    <select name="id_agente" id="id_agente" required class="w-full px-3 py-2.5 rounded-xl border border-sena-300 bg-white text-xs font-bold text-emerald-950 focus:outline-none focus:border-sena-500 focus:ring-2 focus:ring-sena-500/20 transition-all shadow-xs">
                        <option value="">-- Seleccionar Agente --</option>
                    </select>
                </div>

                <div class="flex justify-end gap-2 pt-3 border-t border-sena-200">
                    <button type="button" onclick="cerrarModalReasignar()" class="px-4 py-2 rounded-xl border border-sena-300 bg-white text-sena-800 hover:bg-sena-50 text-xs font-bold transition-colors shadow-xs">
                        Cancelar
                    </button>
                    <button type="submit" class="px-4 py-2 rounded-xl bg-sena-600 hover:bg-sena-700 text-white text-xs font-bold transition-all shadow-md">
                        Guardar Cambios
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- FOOTER EN VERDE -->
<footer class="mt-auto border-t border-sena-200 py-5 text-center text-sena-800 bg-white shadow-inner">
    <p class="text-xs font-bold">
        SENA CIMM &mdash; <span class="text-sena-600">Mesa de Ayuda ADSO</span>
    </p>
</footer>

<!-- JAVASCRIPT -->
<script>
function abrirModalReasignar(boton) {
    const estado = (boton.dataset.estado || "").toUpperCase();

    if (estado.includes("CANCELADO") || estado.includes("RECHAZADO")) {
        Swal.fire({
            icon: "warning",
            title: "Acción no permitida",
            text: "No es posible reasignar agentes a un ticket cancelado.",
            confirmButtonColor: "#39a900"
        });
        return;
    }

    const idTicket = boton.dataset.id || "";

    document.getElementById("modal_id_ticket").value = idTicket;
    document.getElementById("info_titulo").textContent = boton.dataset.titulo || "";
    document.getElementById("info_descripcion").textContent = boton.dataset.descripcion || "";
    document.getElementById("info_categoria").textContent = boton.dataset.categoria || "Sin categoría";
    document.getElementById("info_prioridad").textContent = boton.dataset.prioridad || "N/A";
    document.getElementById("info_estado").textContent = boton.dataset.estado || "N/A";
    document.getElementById("info_fecha").textContent = boton.dataset.fecha || "";
    document.getElementById("info_agente_actual").textContent = boton.dataset.agente || "Sin asignar";

    const selectAgente = document.getElementById("id_agente");
    selectAgente.innerHTML = "";

    const opcionInicial = document.createElement("option");
    opcionInicial.value = "";
    opcionInicial.textContent = "-- Seleccionar Agente --";
    selectAgente.appendChild(opcionInicial);

    const lista = document.querySelector('.lista-agentes-ticket[data-ticket-id="' + idTicket + '"]');

    if (lista) {
        const agentes = lista.querySelectorAll(".agente-ticket");

        if (agentes.length > 0) {
            agentes.forEach(function(agente) {
                const option = document.createElement("option");
                option.value = agente.dataset.id;
                option.textContent = agente.dataset.nombre;
                selectAgente.appendChild(option);
            });
        } else {
            const opcion = document.createElement("option");
            opcion.value = "";
            opcion.textContent = "NO HAY AGENTES PARA ESTA CATEGORÍA";
            opcion.disabled = true;
            selectAgente.appendChild(opcion);
        }
    } else {
        const opcion = document.createElement("option");
        opcion.value = "";
        opcion.textContent = "NO HAY AGENTES PARA ESTA CATEGORÍA";
        opcion.disabled = true;
        selectAgente.appendChild(opcion);
    }

    const modal = document.getElementById("modalReasignar");
    modal.classList.remove("hidden");
    modal.classList.add("flex");
}

function cerrarModalReasignar() {
    const modal = document.getElementById("modalReasignar");
    modal.classList.add("hidden");
    modal.classList.remove("flex");
}

document.addEventListener("DOMContentLoaded", function() {
    const modal = document.getElementById("modalReasignar");
    if (modal) {
        modal.addEventListener("click", function(event) {
            if (event.target === this) {
                cerrarModalReasignar();
            }
        });
    }
});

function confirmarCancelacion(event, titulo) {
    event.preventDefault();

    const form = event.currentTarget;

    Swal.fire({
        title: "¿Cancelar ticket?",
        text: `¿Estás seguro de cancelar el ticket "${titulo}"?`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#2e8800",
        cancelButtonColor: "#64748b",
        confirmButtonText: "Sí, cancelar",
        cancelButtonText: "Volver"
    }).then((result) => {
        if (result.isConfirmed) {
            form.submit();
        }
    });
}

function filtrarTabla() {
    const campoBusqueda = document.getElementById("filtroBusqueda");
    const campoCategoria = document.getElementById("filtroCategoria");
    const campoFecha = document.getElementById("filtroFecha");

    const busqueda = campoBusqueda ? campoBusqueda.value.toLowerCase().trim() : "";
    const categoria = campoCategoria ? campoCategoria.value.toLowerCase().trim() : "";
    const fecha = campoFecha ? campoFecha.value : "";

    const filas = document.querySelectorAll("#tablaTickets tbody tr.fila-ticket");

    filas.forEach(function(fila) {
        const texto = fila.innerText.toLowerCase();
        const cat = (fila.dataset.categoria || "").toLowerCase();
        const fechaFila = fila.dataset.fecha || "";

        const coincideBusqueda = texto.includes(busqueda);
        const coincideCategoria = !categoria || cat.includes(categoria);
        const coincideFecha = !fecha || fechaFila.startsWith(fecha);

        if (coincideBusqueda && coincideCategoria && coincideFecha) {
            fila.style.display = "";
        } else {
            fila.style.display = "none";
        }
    });
}
</script>

</body>
</html>