<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="co.edu.sena.mesaayuda.modelo.Ticket"%>
<%@page import="co.edu.sena.mesaayuda.modelo.Comentario"%>
<%@page import="co.edu.sena.mesaayuda.modelo.Usuario"%>
<%@page import="co.edu.sena.mesaayuda.modelo.estado.EstadoTicket"%>

<%
    Ticket ticket = (Ticket) request.getAttribute("ticket");
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (ticket == null) {
        response.sendError(
                HttpServletResponse.SC_NOT_FOUND,
                "No se encontró el ticket."
        );
        return;
    }

    List<Comentario> comentarios = ticket.getComentarios();

    /* EXTRACCIÓN LIMPIA DEL ESTADO */
    String nombreEstado = "Sin estado";
    if (ticket.getEstado() != null) {
        EstadoTicket estadoObj = ticket.getEstado();
        try {
            java.lang.reflect.Method metodo = estadoObj.getClass().getMethod("getNombreEstado");
            Object val = metodo.invoke(estadoObj);
            if (val != null) nombreEstado = String.valueOf(val);
        } catch (Exception e1) {
            try {
                java.lang.reflect.Method metodo = estadoObj.getClass().getMethod("gettipo_estado");
                Object val = metodo.invoke(estadoObj);
                if (val != null) nombreEstado = String.valueOf(val);
            } catch (Exception e2) {
                String className = estadoObj.getClass().getSimpleName();
                if (className.startsWith("Estado") && className.length() > 6) {
                    nombreEstado = className.substring(6);
                } else {
                    nombreEstado = className;
                }
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="es" class="h-full bg-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket #<%= ticket.getId_ticket() %> - Mesa de Ayuda SENA ADSO</title>
    
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
      tailwind.config = {
        theme: {
          extend: {
            colors: {
              sena: {
                green: '#39A900',      /* Verde SENA */
                hovergreen: '#2e8700', /* Hover Verde */
                softgreen: '#E8F5E9',  /* Fondo Verde Suave */
                blue: '#00324D'        /* Azul Institucional Complementario */
              }
            }
          }
        }
      }
    </script>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; }
        .custom-scrollbar::-webkit-scrollbar { width: 6px; }
        .custom-scrollbar::-webkit-scrollbar-track { background: #e2e8f0; }
        .custom-scrollbar::-webkit-scrollbar-thumb { background: #94a3b8; border-radius: 4px; }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover { background: #39A900; }
    </style>
</head>

<body class="min-h-full flex flex-col text-slate-700 antialiased selection:bg-sena-green selection:text-white bg-slate-100">

<!-- NAVEGACIÓN / HEADER EN AZUL INSTITUCIONAL CON DETALLE VERDE SENA -->
<header class="bg-sena-blue text-white shadow-md sticky top-0 z-50 border-b-4 border-sena-green">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-3">
        <div class="flex items-center justify-between gap-3">
            
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-xl bg-sena-green text-white flex items-center justify-center font-black text-xl shadow-md">
                    S
                </div>
                <div>
                    <div class="flex items-center gap-2 text-[10px] font-bold text-emerald-400 uppercase tracking-wider">
                        <span>SENA CIMM</span>
                        <span>•</span>
                        <span class="text-sky-300 font-extrabold">ADSO</span>
                    </div>
                    <h1 class="text-base sm:text-lg font-extrabold text-white tracking-tight leading-none">Mesa de Ayuda</h1>
                </div>
            </div>

            <div class="flex items-center gap-2">
                <!-- BOTÓN PANEL SOLICITANTE -->
                <a href="<%= request.getContextPath() %>/PanelSolicitante.jsp" 
                   class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-sky-600 hover:bg-sky-500 text-white font-bold text-xs transition-all duration-200 shadow-sm">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                    </svg>
                    <span class="hidden sm:inline">Panel Solicitante</span>
                </a>

                <span class="inline-flex items-center px-3 py-1 rounded-lg bg-sena-green text-white font-black text-xs shadow-sm">
                    Ticket #<%= ticket.getId_ticket() %>
                </span>
            </div>

        </div>
    </div>
</header>

<!-- BARRA DE ACCIÓN SECUNDARIA EN AZUL CLARO -->
<div class="bg-sky-100/70 border-b border-sky-200 py-2.5">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex items-center justify-between">
        
        <!-- BOTÓN VOLVER CON MÁS COLOR Y MEJOR UBICACIÓN -->
        <a href="<%= request.getContextPath() %>/misTickets" 
           class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-lg bg-white hover:bg-slate-50 text-sky-900 font-bold text-xs transition-all duration-200 border border-sky-300 shadow-xs">
            <svg class="w-4 h-4 text-sky-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
            </svg>
            <span>Volver a mis Tickets</span>
        </a>

        <span class="text-xs font-bold text-sky-800">Detalle e Historial</span>
    </div>
</div>

<!-- CONTENEDOR PRINCIPAL -->
<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-5 flex-1 w-full space-y-4">

    <!-- METRICAS EN TARJETAS COLORIDAS -->
    <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
        
        <div class="bg-emerald-50 p-3 rounded-xl border-2 border-emerald-300 shadow-sm flex items-center justify-between">
            <div>
                <span class="text-[10px] font-bold text-emerald-700 uppercase tracking-wider block">Estado</span>
                <p class="text-sm font-black text-emerald-900 leading-tight mt-0.5"><%= nombreEstado %></p>
            </div>
            <div class="w-8 h-8 rounded-lg bg-sena-green text-white flex items-center justify-center font-bold shadow-xs">
                ✓
            </div>
        </div>

        <div class="bg-sky-50 p-3 rounded-xl border-2 border-sky-300 shadow-sm flex items-center justify-between">
            <div class="min-w-0">
                <span class="text-[10px] font-bold text-sky-700 uppercase tracking-wider block">Solicitante</span>
                <p class="text-sm font-extrabold text-sky-950 truncate leading-tight mt-0.5">
                    <%= ticket.getSolicitante() != null ? ticket.getSolicitante().getnombre_usuario() : "Sin registro" %>
                </p>
            </div>
            <div class="w-8 h-8 rounded-lg bg-sky-600 text-white flex items-center justify-center font-bold shadow-xs">
                👤
            </div>
        </div>

        <div class="bg-amber-50 p-3 rounded-xl border-2 border-amber-300 shadow-sm flex items-center justify-between">
            <div class="min-w-0">
                <span class="text-[10px] font-bold text-amber-700 uppercase tracking-wider block">Agente</span>
                <p class="text-sm font-extrabold text-amber-950 truncate leading-tight mt-0.5">
                    <%= ticket.getAgente() != null ? ticket.getAgente().getnombre_usuario() : "Sin Asignar" %>
                </p>
            </div>
            <div class="w-8 h-8 rounded-lg bg-amber-500 text-white flex items-center justify-center font-bold shadow-xs">
                🛠️
            </div>
        </div>

        <div class="bg-purple-50 p-3 rounded-xl border-2 border-purple-300 shadow-sm flex items-center justify-between">
            <div class="min-w-0">
                <span class="text-[10px] font-bold text-purple-700 uppercase tracking-wider block">Fecha Creación</span>
                <p class="text-xs font-extrabold text-purple-950 truncate leading-tight mt-0.5">
                    <%= ticket.getFecha_creacion() %>
                </p>
            </div>
            <div class="w-8 h-8 rounded-lg bg-purple-600 text-white flex items-center justify-center font-bold shadow-xs">
                📅
            </div>
        </div>

    </div>

    <!-- ESTRUCTURA PRINCIPAL (2 COLUMNAS) -->
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-5 items-start">

        <!-- COLUMNA IZQUIERDA: FICHA Y DESCRIPCIÓN (4 COLS) -->
        <div class="lg:col-span-4 space-y-4">
            
            <div class="bg-white rounded-xl border border-sky-200 shadow-sm overflow-hidden">
                <div class="px-4 py-3 bg-sena-blue text-white font-bold text-sm flex items-center justify-between border-b border-sky-900">
                    <span class="flex items-center gap-2">
                        📋 Detalle del Ticket
                    </span>
                    <span class="text-[10px] bg-sky-500 text-white px-2 py-0.5 rounded-md uppercase font-black">ADSO</span>
                </div>

                <div class="p-4 space-y-3">
                    <div>
                        <span class="text-[10px] font-bold text-slate-400 uppercase tracking-wider block">Asunto</span>
                        <h2 class="font-extrabold text-sky-950 text-base leading-snug">
                            <%= ticket.getTitulo() %>
                        </h2>
                    </div>

                    <div class="grid grid-cols-2 gap-2 pt-2 border-t border-slate-100">
                        <div class="bg-sky-50/80 p-2.5 rounded-lg border border-sky-200">
                            <span class="text-[9px] font-bold text-sky-700 uppercase block">Categoría</span>
                            <span class="font-extrabold text-xs text-sky-900">
                                <%= ticket.getCategoria() != null ? ticket.getCategoria().getnombre_categoria() : "General" %>
                            </span>
                        </div>
                        <div class="bg-amber-50/80 p-2.5 rounded-lg border border-amber-200">
                            <span class="text-[9px] font-bold text-amber-700 uppercase block">Prioridad</span>
                            <span class="font-extrabold text-xs text-amber-800">
                                <%= ticket.getPrioridad() != null ? ticket.getPrioridad().gettipo_prioridad() : "Normal" %>
                            </span>
                        </div>
                    </div>

                    <div class="pt-2 border-t border-slate-100">
                        <span class="text-[10px] font-bold text-slate-400 uppercase tracking-wider block mb-1">Descripción del Problema</span>
                        <div class="p-3 rounded-lg bg-slate-50 border border-slate-200 text-slate-700 text-xs leading-relaxed whitespace-pre-line max-h-60 overflow-y-auto custom-scrollbar">
                            <%= ticket.getDescripcion() %>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- COLUMNA DERECHA: HISTORIAL Y CHAT (8 COLS) -->
        <div class="lg:col-span-8">

            <div class="bg-white rounded-xl border border-sky-200 shadow-sm overflow-hidden flex flex-col">
                
                <!-- ENCABEZADO CHAT CON COLOR -->
                <div class="px-4 py-3 border-b border-sky-200 bg-sky-50 flex items-center justify-between">
                    <div class="flex items-center gap-2">
                        <div class="w-3 h-3 rounded-full bg-sena-green animate-pulse"></div>
                        <h3 class="font-bold text-sky-950 text-sm">Historial de Comunicación</h3>
                    </div>
                    <span class="px-2.5 py-0.5 rounded-full text-xs font-bold bg-sky-200 text-sky-900">
                        <%= comentarios != null ? comentarios.size() : 0 %> <%= (comentarios != null && comentarios.size() == 1) ? "Comentario" : "Comentarios" %>
                    </span>
                </div>

                <!-- CONTENEDOR DE MENSAJES CON FONDO SUAVE -->
                <div class="p-4 space-y-3 min-h-[250px] max-h-[420px] overflow-y-auto bg-slate-50 custom-scrollbar">
                    <% if (comentarios == null || comentarios.isEmpty()) { %>
                        <div class="text-center py-8 space-y-2">
                            <div class="w-10 h-10 rounded-full bg-sky-100 text-sky-600 mx-auto flex items-center justify-center text-lg">
                                💬
                            </div>
                            <h4 class="text-slate-700 font-bold text-xs">Sin comentarios aún</h4>
                            <p class="text-slate-400 text-[11px]">Escribe un comentario abajo para interactuar en este ticket.</p>
                        </div>
                    <% } else { %>
                        <% for (Comentario comentario : comentarios) { 
                            boolean esUsuarioActual = comentario.getUsuario() != null 
                                                    && usuario != null 
                                                    && comentario.getUsuario().getId_usuario() == usuario.getId_usuario();
                        %>
                            <div class="flex gap-2.5 <%= esUsuarioActual ? "flex-row-reverse" : "flex-row" %>">
                                
                                <!-- AVATAR -->
                                <div class="w-8 h-8 rounded-lg flex-shrink-0 flex items-center justify-center font-extrabold text-xs shadow-xs <%= esUsuarioActual ? "bg-sena-green text-white" : "bg-sky-700 text-white" %>">
                                    <%= comentario.getUsuario() != null && comentario.getUsuario().getnombre_usuario() != null && !comentario.getUsuario().getnombre_usuario().isEmpty() 
                                        ? comentario.getUsuario().getnombre_usuario().substring(0, 1).toUpperCase() 
                                        : "U" %>
                                </div>

                                <!-- BURBUJA DE CHAT -->
                                <div class="max-w-md w-full">
                                    <div class="p-3 rounded-xl text-xs space-y-1 border shadow-xs <%= esUsuarioActual ? "bg-emerald-50 border-emerald-300 rounded-tr-none text-slate-800" : "bg-sky-50/90 border-sky-200 rounded-tl-none text-slate-800" %>">
                                        
                                        <div class="flex items-center justify-between gap-2 pb-1 border-b border-slate-200/60">
                                            <div class="flex items-center gap-1.5">
                                                <span class="font-extrabold text-slate-800 text-[11px]">
                                                    <%= comentario.getUsuario() != null ? comentario.getUsuario().getnombre_usuario() : "Usuario" %>
                                                </span>
                                                <span class="text-[9px] uppercase font-bold px-1.5 py-0.2 rounded <%= esUsuarioActual ? "bg-sena-green text-white" : "bg-sky-600 text-white" %>">
                                                    <%= esUsuarioActual ? "Tú" : "Soporte ADSO" %>
                                                </span>
                                            </div>
                                            <span class="text-[9px] font-medium text-slate-400">
                                                <%= comentario.getFecha() %>
                                            </span>
                                        </div>

                                        <p class="leading-relaxed whitespace-pre-line font-normal text-slate-700 pt-0.5">
                                            <%= comentario.getTexto() %>
                                        </p>
                                    </div>
                                </div>

                            </div>
                        <% } %>
                    <% } %>
                </div>

                <!-- FORMULARIO DE RESPUESTA INTEGRADO -->
                <div class="p-3.5 bg-white border-t border-slate-200">
                    <form method="POST" action="<%= request.getContextPath() %>/detalleTicket?id=<%= ticket.getId_ticket() %>" class="space-y-2" id="commentForm">
                        <div class="relative">
                            <textarea id="texto"
                                      name="texto" 
                                      rows="2" 
                                      required 
                                      maxlength="1000" 
                                      placeholder="Escribe tu comentario aquí..."
                                      class="w-full p-2.5 bg-slate-50 border border-slate-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-sena-green focus:bg-white text-xs resize-none transition-all"></textarea>
                        </div>

                        <div class="flex items-center justify-between">
                            <span class="text-[10px] text-slate-400 font-semibold" id="charCounter">0 / 1000 caracteres</span>
                            <button type="submit" 
                                    class="inline-flex items-center gap-1.5 px-4 py-1.5 bg-sena-green hover:bg-sena-hovergreen text-white font-bold text-xs rounded-lg transition-all shadow-sm active:scale-95 focus:ring-2 focus:ring-sena-green outline-none">
                                <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"/>
                                </svg>
                                <span>Enviar Comentario</span>
                            </button>
                        </div>
                    </form>
                </div>

            </div>

        </div>

    </div>

</main>

<!-- FOOTER -->
<footer class="mt-6 py-4 text-center text-[11px] text-slate-500 border-t border-slate-200 bg-white">
    <div class="max-w-7xl mx-auto px-4 flex flex-col sm:flex-row items-center justify-between gap-1">
        <p class="font-extrabold text-sena-blue">SENA CIMM · ADSO Mesa de Ayuda</p>
        <p>© <%= java.time.Year.now().getValue() %> Servicio Nacional de Aprendizaje SENA.</p>
    </div>
</footer>

<!-- SCRIPT DINÁMICO INTERACTIVO -->
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const textarea = document.getElementById('texto');
        const charCounter = document.getElementById('charCounter');

        if(textarea && charCounter) {
            textarea.addEventListener('input', (e) => {
                const currentLength = e.target.value.length;
                charCounter.textContent = `${currentLength} / 1000 caracteres`;
                
                if(currentLength > 900) {
                    charCounter.classList.add('text-amber-600', 'font-bold');
                } else {
                    charCounter.classList.remove('text-amber-600', 'font-bold');
                }
            });
        }
    });
</script>

</body>
</html>