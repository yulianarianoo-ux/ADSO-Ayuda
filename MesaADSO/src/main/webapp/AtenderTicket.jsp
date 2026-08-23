<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="co.edu.sena.mesaayuda.dto.TicketDTO"%>
<%@page import="co.edu.sena.mesaayuda.modelo.Prioridad"%>
<%@page import="co.edu.sena.mesaayuda.modelo.estado.EstadoTicket"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%!
    public String escaparHTML(String texto) {

        if (texto == null) {
            return "";
        }

        return texto
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
%>

<%

    List<TicketDTO> tickets =
            (List<TicketDTO>) request.getAttribute("tickets");

    List<EstadoTicket> estados =
            (List<EstadoTicket>) request.getAttribute("estados");

    List<Prioridad> prioridades =
            (List<Prioridad>) request.getAttribute("prioridades");

    String prioridadActual =
            (String) request.getAttribute("filtroPrioridadActual");

    String filtroEstadoActual =
            (String) request.getAttribute("filtroEstadoActual");

    if (filtroEstadoActual == null ||
        filtroEstadoActual.trim().isEmpty()) {

        filtroEstadoActual = "TODOS";
    }

    if (prioridadActual == null ||
        prioridadActual.trim().isEmpty()) {

        prioridadActual = "TODAS";
    }

    int totalAsignados =
            tickets != null ? tickets.size() : 0;

    SimpleDateFormat formatoFecha =
            new SimpleDateFormat("dd/MM/yyyy HH:mm");

    SimpleDateFormat formatoFechaISO =
            new SimpleDateFormat("yyyy-MM-dd");
%>

<!DOCTYPE html>
<html lang="es" class="h-full bg-slate-100">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SENA CIMM - Mis Tickets Asignados</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0">

    <script>

        tailwind.config = {

            theme: {

                extend: {

                    fontFamily: {
                        sans: ['Plus Jakarta Sans', 'sans-serif']
                    },

                    colors: {

                        sena: {
                            500: '#39a900',
                            600: '#2e8800',
                            700: '#236900'
                        }

                    }

                }

            }

        };

    </script>

</head>


<body class="h-full flex flex-col font-sans text-slate-800 bg-slate-100 antialiased">


<!-- ===================================================== -->
<!-- HEADER -->
<!-- ===================================================== -->

<header class="bg-sena-600 shadow-md sticky top-0 z-40">

    <div class="max-w-7xl mx-auto h-16 px-4 sm:px-6
                flex items-center justify-between">

        <div class="flex items-center gap-3">

            <div class="w-10 h-10 rounded-xl bg-white
                        text-sena-600
                        flex items-center justify-center
                        font-black shadow-sm">

                <span class="material-symbols-outlined text-2xl">
                    confirmation_number
                </span>

            </div>

            <div>

                <h1 class="font-extrabold text-lg text-white leading-none">

                    SENA

                    <span class="text-blue-200">
                        CIMM
                    </span>

                </h1>

                <span class="text-[11px] font-bold text-emerald-100
                             uppercase tracking-wider">

                    Mesa de Ayuda • Panel Agente

                </span>

            </div>

        </div>


        <a href="${pageContext.request.contextPath}/PanelAgente.jsp"
           class="px-4 py-2 rounded-xl bg-blue-600
                  hover:bg-blue-700 text-white text-xs
                  font-bold transition-all flex items-center
                  gap-2 shadow-sm border border-blue-500">

            <span class="material-symbols-outlined text-base">
                arrow_back
            </span>

            Volver al Panel

        </a>

    </div>

</header>


<!-- ===================================================== -->
<!-- CONTENIDO -->
<!-- ===================================================== -->

<main class="flex-grow max-w-7xl w-full mx-auto
             px-4 sm:px-6 py-6 space-y-6">


<!-- ===================================================== -->
<!-- CABECERA -->
<!-- ===================================================== -->

<div class="bg-white rounded-2xl p-5
            border border-slate-200 shadow-sm space-y-4">

    <div class="flex flex-col lg:flex-row
                lg:items-center justify-between gap-4">

        <div>

            <div class="flex items-center gap-2">

                <span class="w-3 h-3 rounded-full
                             bg-sena-500 animate-pulse">
                </span>

                <h2 class="text-xl font-black text-slate-900">
                    Mis Tickets Asignados
                </h2>

            </div>

            <p class="text-xs text-slate-500
                      font-medium mt-1">

                Gestión de casos asignados con control de tiempo SLA.

            </p>

        </div>


        <div class="flex flex-wrap items-center gap-2
                    text-[10px] font-bold">

            <span class="px-2.5 py-1 rounded-lg
                         bg-emerald-50 text-emerald-700
                         border border-emerald-200">

                🟢 BAJA

            </span>

            <span class="px-2.5 py-1 rounded-lg
                         bg-blue-50 text-blue-700
                         border border-blue-200">

                🔵 MEDIA

            </span>

            <span class="px-2.5 py-1 rounded-lg
                         bg-orange-50 text-orange-700
                         border border-orange-200">

                🟠 ALTA

            </span>

            <span class="px-2.5 py-1 rounded-lg
                         bg-red-100 text-red-700
                         border border-red-300">

                🔴 CRÍTICA 🚨

            </span>

            <div class="ml-2 pl-3 border-l
                        border-slate-300
                        text-blue-900 font-black text-xs">

                Mostrando:

                <span id="contadorMostrados">
                    <%= totalAsignados %>
                </span>

                de

                <%= totalAsignados %>

            </div>

        </div>

    </div>


<!-- ===================================================== -->
<!-- FILTROS -->
<!-- ===================================================== -->

<div class="grid grid-cols-1 md:grid-cols-2
            lg:grid-cols-4 gap-3 pt-3
            border-t border-slate-100">



    <input type="text"
           id="filtroBuscar"
           oninput="aplicarFiltros()"
           placeholder="Buscar ticket, título o usuario..."
           class="w-full pl-9 pr-3 py-2
                  rounded-xl border border-slate-300
                  text-xs font-bold text-slate-800
                  bg-slate-50
                  focus:bg-white focus:ring-2
                  focus:ring-sena-500
                  focus:outline-none">


<!-- ESTADO -->

<div class="relative">

    <span class="material-symbols-outlined
                 absolute left-3 top-2.5
                 text-slate-400 text-sm">

        flag

    </span>

    <select id="filtroEstado"
            onchange="cambiarEstadoServidor(this.value)"
            class="w-full pl-9 pr-3 py-2
                   rounded-xl border border-slate-300
                   text-xs font-bold text-slate-800
                   bg-slate-50 focus:bg-white
                   focus:ring-2 focus:ring-sena-500
                   focus:outline-none appearance-none
                   cursor-pointer">

        <option value="TODOS"
            <%= "TODOS".equalsIgnoreCase(filtroEstadoActual)
                ? "selected" : "" %>>

            🏷️ Todos los Estados

        </option>


        <%
            if (estados != null) {

                for (EstadoTicket estadoItem : estados) {

    String idEstadoStr = String.valueOf(estadoItem.idEstado());
    String nombreEstado = estadoItem.nombre();
%>

        <option value="<%= idEstadoStr %>"
            <%= idEstadoStr.equals(filtroEstadoActual)
                ? "selected" : "" %>>

            <%= escaparHTML(
                    nombreEstado
                            .replace("_", " ")
                            .toUpperCase()
            ) %>

        </option>

        <%
                }
            }
        %>

    </select>

</div>


<!-- ===================================================== -->
<!-- PRIORIDAD -->
<!-- ===================================================== -->

<div class="relative">

    <span class="material-symbols-outlined
                 absolute left-3 top-2.5
                 text-slate-400 text-sm">
        priority_high
    </span>

    <select name="prioridad"
            id="filtroPrioridad"
            onchange="cambiarPrioridadServidor(this.value)"
            class="w-full pl-9 pr-3 py-2
                   rounded-xl border border-slate-300
                   text-xs font-bold text-slate-800
                   bg-slate-50
                   focus:bg-white
                   focus:ring-2
                   focus:ring-sena-500
                   focus:outline-none
                   appearance-none
                   cursor-pointer">

        <option value="TODAS"
            <%= "TODAS".equalsIgnoreCase(prioridadActual)
                ? "selected" : "" %>>

            ⚡ Todas las Prioridades

        </option>

        <%
            if (prioridades != null) {

                for (Prioridad prioridad : prioridades) {

                    if (prioridad == null) {
                        continue;
                    }

                    String valor =
                            prioridad.gettipo_prioridad();

                    if (valor == null ||
                        valor.trim().isEmpty()) {
                        continue;
                    }

                    valor = valor.trim();

                    boolean seleccionada =
                            valor.equalsIgnoreCase(
                                    prioridadActual
                            );
        %>

        <option value="<%= escaparHTML(valor) %>"
                <%= seleccionada ? "selected" : "" %>>

            <%= escaparHTML(
                    valor.replace("_", " ")
                         .toUpperCase()
            ) %>

        </option>

        <%
                }
            }
        %>

    </select>

</div>
<!-- FECHA -->

<div class="relative">

    <span class="material-symbols-outlined
                 absolute left-3 top-2.5
                 text-slate-400 text-sm">

        calendar_today

    </span>

    <input type="date"
           id="filtroFecha"
           onchange="aplicarFiltros()"
           title="Filtrar por fecha de creación"
           class="w-full pl-9 pr-8 py-2
                  rounded-xl border border-slate-300
                  text-xs font-bold text-slate-700
                  bg-slate-50 focus:bg-white
                  focus:ring-2 focus:ring-sena-500
                  focus:outline-none cursor-pointer">

    <button type="button"
            id="btnLimpiarFecha"
            onclick="limpiarFiltroFecha()"
            title="Quitar filtro de fecha"
            class="hidden absolute right-2 top-1/2 -translate-y-1/2
                   w-5 h-5 rounded-full bg-slate-200
                   hover:bg-slate-300 text-slate-600
                   items-center justify-center">

        <span class="material-symbols-outlined text-xs leading-none">
            close
        </span>

    </button>

</div>

</div>


<div class="flex items-center justify-end">

    <button type="button"
            onclick="limpiarFiltros()"
            class="py-2 px-4 rounded-xl
                   bg-slate-100 hover:bg-slate-200
                   text-slate-700 text-xs font-bold
                   flex items-center justify-center gap-1.5
                   border border-slate-300">

        <span class="material-symbols-outlined text-sm">
            filter_alt_off
        </span>

        Restablecer Filtros

    </button>

</div>

</div>

        
<!-- ===================================================== --> 
<!-- TICKETS --> 
<!-- ===================================================== --> 
 
<% 
    if (tickets == null || tickets.isEmpty()) { 
%> 
 
<div class="bg-white rounded-2xl p-12 
            border-2 border-dashed border-slate-300 
            text-center flex flex-col 
            items-center justify-center 
            gap-2 shadow-sm"> 
 
    <div class="w-12 h-12 rounded-full 
                bg-emerald-50 text-sena-600 
                flex items-center justify-center"> 
 
        <span class="material-symbols-outlined text-3xl"> 
            task_alt 
        </span> 
 
    </div> 
 
    <h3 class="text-base font-bold text-slate-800"> 
        ¡Bandeja al día! 
    </h3> 
 
    <p class="text-xs text-slate-500"> 
        No tienes tickets asignados actualmente. 
    </p> 
 
</div> 
 
<% 
    } else { 
%> 
 
 
<div id="contenedorTickets" 
     class="grid grid-cols-1 md:grid-cols-2 
            lg:grid-cols-3 gap-5"> 
 
 
<% 
    for (TicketDTO t : tickets) { 
 
        String fechaStr = 
                t.getFecha_creacion() != null 
                ? formatoFecha.format(t.getFecha_creacion()) 
                : "N/A"; 
 
        String fechaISO = 
                t.getFecha_creacion() != null 
                ? formatoFechaISO.format(t.getFecha_creacion()) 
                : ""; 
 
        long fechaMillis = 
                t.getFecha_creacion() != null 
                ? t.getFecha_creacion().getTime() 
                : 0L; 
 
 
        String prioridadRaw = 
                t.getPrioridad() != null 
                ? t.getPrioridad().toUpperCase().trim() 
                : "MEDIA"; 
 
 
        String prioridadNormalizada = "MEDIA"; 
 
 
        if (prioridadRaw.contains("CRIT") 
                || prioridadRaw.equals("4")) { 
 
            prioridadNormalizada = "CRITICA"; 
 
        } else if (prioridadRaw.contains("ALT") 
                || prioridadRaw.equals("3")) { 
 
            prioridadNormalizada = "ALTA"; 
 
        } else if (prioridadRaw.contains("MED") 
                || prioridadRaw.equals("2")) { 
 
            prioridadNormalizada = "MEDIA"; 
 
        } else if (prioridadRaw.contains("BAJ") 
                || prioridadRaw.equals("1")) { 
 
            prioridadNormalizada = "BAJA"; 
 
        } 
 
 
        int horasSLA = t.getHorasSLA(); 
 
 
        String estado = 
                t.getEstado() != null 
                ? t.getEstado() 
                    .trim() 
                    .toUpperCase() 
                    .replace("_", " ") 
                : "NUEVO"; 
 
 
        // ===================================================== 
        // DETECTAR CANCELADO 
        // ===================================================== 
 
        boolean cancelado = 
                "CANCELADO".equalsIgnoreCase(estado); 
 
 
        String badgePrioridad = 
                "bg-blue-600 text-white"; 
 
        String borderPrioridad = 
                "border-l-blue-600"; 
 
        String efectoCriticoCard = ""; 
 
        boolean esCritico = false; 
 
 
        if ("CRITICA".equals(prioridadNormalizada)) { 
 
            badgePrioridad = 
                    "bg-red-700 text-white font-black shadow-md"; 
 
            borderPrioridad = 
                    "border-l-red-600 border-l-[10px]"; 
 
            efectoCriticoCard = 
                    "ring-2 ring-red-500/80 shadow-lg shadow-red-200/60"; 
 
            esCritico = true; 
 
        } else if ("ALTA".equals(prioridadNormalizada)) { 
 
            badgePrioridad = 
                    "bg-orange-600 text-white font-black"; 
 
            borderPrioridad = 
                    "border-l-orange-500"; 
 
        } else if ("BAJA".equals(prioridadNormalizada)) { 
 
            badgePrioridad = 
                    "bg-sena-500 text-white font-bold"; 
 
            borderPrioridad = 
                    "border-l-sena-500"; 
        } 
 
 
        // ===================================================== 
        // SI ESTÁ CANCELADO 
        // ===================================================== 
 
        if (cancelado) { 
 
            badgePrioridad = 
                    "bg-slate-100 text-slate-400 border border-slate-200"; 
 
            borderPrioridad = 
                    "border-l-slate-300"; 
 
            efectoCriticoCard = ""; 
 
            esCritico = false; 
        } 
 
 
        String titulo = 
                t.getTitulo() != null 
                ? t.getTitulo() 
                : ""; 
 
        String descripcion = 
                t.getDescripcion() != null 
                ? t.getDescripcion() 
                : ""; 
 
        String solicitante = 
                t.getSolicitante() != null 
                ? t.getSolicitante() 
                : ""; 
 
        String categoria = 
                t.getCategoria() != null 
                ? t.getCategoria() 
                : ""; 
 
%> 
 
 
<!-- ===================================================== --> 
<!-- CARD --> 
<!-- ===================================================== --> 
 
<!-- ===================================================== -->
<!-- CARD -->
<!-- ===================================================== -->

<div id="card-ticket-<%= t.getId_ticket() %>"

     class="card-ticket relative bg-white rounded-2xl
            border-t border-r border-b border-slate-200
            border-l-8 <%= borderPrioridad %>
            <%= efectoCriticoCard %>
            <%= cancelado ? "opacity-80" : "" %>
            shadow-sm hover:shadow-md
            transition-all flex flex-col
            justify-between overflow-hidden group"

     data-prioridad="<%= escaparHTML(prioridadNormalizada) %>"

     data-estado="<%= escaparHTML(estado) %>"

     data-fecha="<%= escaparHTML(fechaISO) %>"

     data-fecha-ms="<%= fechaMillis %>"

     data-sla="<%= horasSLA %>"

     data-id="<%= t.getId_ticket() %>"

     data-titulo="<%= escaparHTML(titulo) %>"

     data-descripcion="<%= escaparHTML(descripcion) %>"

     data-categoria="<%= escaparHTML(categoria) %>"

     data-solicitante="<%= escaparHTML(solicitante) %>"

     data-search="<%= escaparHTML(
        String.valueOf(t.getId_ticket()).toLowerCase()
        + " "
        + titulo.toLowerCase()
        + " "
        + solicitante.toLowerCase()
        + " "
        + categoria.toLowerCase()
     ) %>">

<% if (cancelado) { %>

<div class="absolute top-0 left-0 right-0
            bg-red-600 text-white
            text-center py-2
            text-[10px] font-black
            uppercase tracking-widest
            z-20">

    🚫 TICKET CANCELADO

</div>


<div class="bg-red-600 text-white text-[11px] 
            font-black px-3 py-1.5 text-center 
            flex items-center justify-center gap-2 
            uppercase tracking-wider"> 
 
    <span class="material-symbols-outlined text-sm"> 
        warning 
    </span> 
 
    🚨 ATENCIÓN URGENTE - TICKET CRÍTICO 
 
</div> 
 
<% 
    } 
%> 
 
 
<div class="p-5 space-y-3"> 
 
    <div class="flex items-center 
                justify-between gap-2 flex-wrap"> 
 
        <span class="text-xs font-black 
                     bg-slate-900 text-white 
                     px-2.5 py-1 rounded-lg"> 
 
            #<%= t.getId_ticket() %> 
 
        </span> 
 
 
        <div class="flex items-center 
                    gap-1.5 flex-wrap"> 
 
            <span id="badge-estado-<%= t.getId_ticket() %>" 
                  class="badge-estado-card 
                         text-[10px] uppercase 
                         font-bold px-2 py-0.5 
                         rounded-md 
                         <%= cancelado 
                             ? "bg-slate-100 text-slate-500 border-slate-300" 
                             : "bg-slate-100 text-slate-700 border-slate-300" %> 
                         border"> 
 
                <%= estado %> 
 
            </span> 
 
 
            <span class="text-[10px] uppercase 
                         px-2.5 py-1 rounded-md 
                         <%= badgePrioridad %>"> 
 
                <%= cancelado 
                    ? "SIN PRIORIDAD" 
                    : prioridadNormalizada %> 
 
            </span> 
 
        </div> 
 
    </div> 
 
 
    <div class="space-y-1"> 
 
        <h3 class="text-base font-bold 
                   <%= cancelado 
                       ? "text-slate-500" 
                       : "text-slate-900 group-hover:text-blue-600" %> 
                   line-clamp-1"> 
 
            <%= titulo %> 
 
        </h3> 
 
 
        <p class="text-xs 
                  <%= cancelado 
                      ? "text-slate-400" 
                      : "text-slate-600" %> 
                  line-clamp-2 leading-relaxed 
                  font-medium"> 
 
            <%= descripcion %> 
 
        </p> 
 
    </div> 
 
</div> 
 
 
<!-- ===================================================== --> 
<!-- INFORMACION --> 
<!-- ===================================================== --> 
 
<div class="px-5 pb-5 pt-2 space-y-3"> 
 
 
<div class="grid grid-cols-1 sm:grid-cols-3 
            gap-2 text-[11px] font-bold"> 
 
 
<!-- SOLICITANTE -->

<% if (cancelado) { %>

<div class="absolute top-0 left-0 right-0
            bg-red-600 text-white
            text-center py-2
            text-[10px] font-black
            uppercase tracking-widest
            z-20">

    🚫 TICKET CANCELADO

</div>

<% } %>


<div class="<%= cancelado
             ? "bg-red-100 text-red-600 border-red-200"
             : "bg-red-50 text-red-700 border-red-200" %>
            p-2 rounded-xl
            border
            flex items-center gap-1.5 truncate">

    <span class="material-symbols-outlined
                 text-sm
                 <%= cancelado
                     ? "text-red-500"
                     : "text-red-600" %>">

        person

    </span>

    <span class="truncate">

        <%= !solicitante.isEmpty()
            ? solicitante
            : "Sin usuario" %>

    </span>

</div>
<!-- CATEGORIA -->

<div class="bg-slate-50 text-slate-700
            p-2 rounded-xl
            border border-slate-200
            flex items-center gap-1.5 truncate">

    <span class="material-symbols-outlined
                 text-sm text-sena-600">

        folder

    </span>

    <span class="truncate">

        <%= !categoria.isEmpty()
            ? categoria
            : "Sin categoría" %>

    </span>

</div>


<!-- SLA -->

<div id="sla-card-<%= t.getId_ticket() %>"
     class="sla-card bg-amber-50 text-amber-800
            p-2 rounded-xl
            border border-amber-200
            flex items-center gap-1.5">

    <span class="material-symbols-outlined text-sm">
        timer
    </span>

    <span id="sla-text-<%= t.getId_ticket() %>">
        Calculando...
    </span>

</div>


</div>


<!-- FECHA -->

<div class="rounded-xl border border-slate-200
            bg-slate-50 p-3">

    <div class="flex items-center justify-between gap-3">

        <div>

            <p class="text-[9px] uppercase
                      font-black text-slate-400">

                Creado

            </p>

            <p class="text-[11px] font-bold
                      text-slate-700">

                <%= fechaStr %>

            </p>

        </div>


        <div id="sla-detalle-<%= t.getId_ticket() %>"
             class="text-right">

            <p class="text-[9px] uppercase
                      font-black text-slate-400">

                Tiempo de atención

            </p>

            <p class="text-[11px] font-black
                      text-amber-700">

                Calculando...

            </p>

        </div>

    </div>

</div>


<!-- BOTON -->

<button type="button"
        onclick="abrirModalTicketDesdeCard(<%= t.getId_ticket() %>)"
        class="w-full py-2.5 rounded-xl

        <%= esCritico
            ? "bg-red-600 hover:bg-red-700"
            : "bg-sena-500 hover:bg-sena-600" %>

        text-white text-xs font-bold
        shadow-md flex items-center
        justify-center gap-2 transition-all">

    <span>
        Atender Ticket
    </span>

    <span class="material-symbols-outlined text-base">
        arrow_forward
    </span>

</button>


</div>

</div>


<%
    }
%>

</div>


<div id="sinResultados"
     class="hidden bg-white rounded-2xl p-12
            border-2 border-dashed border-slate-300
            text-center flex flex-col
            items-center justify-center
            gap-2 shadow-sm">

    <div class="w-12 h-12 rounded-full
                bg-slate-100 text-slate-500
                flex items-center justify-center">

        <span class="material-symbols-outlined text-3xl">
            filter_alt_off
        </span>

    </div>

    <h3 class="text-base font-bold text-slate-800">
        Sin coincidencias
    </h3>

    <p class="text-xs text-slate-500">
        No se encontraron tickets con los filtros aplicados.
    </p>

    <button type="button"
            onclick="limpiarFiltros()"
            class="mt-2 text-xs font-bold
                   text-blue-600 hover:underline">

        Limpiar Filtros

    </button>

</div>


<%
    }
%>

</main>


<!-- ===================================================== -->
<!-- MODAL -->
<!-- ===================================================== -->

<div id="modalTicket"
     onclick="cerrarPorBackdrop(event)"
     class="fixed inset-0 z-50 hidden
            bg-slate-950/70 backdrop-blur-md
            flex items-center justify-center
            p-4 sm:p-6">


<div class="bg-white rounded-3xl shadow-2xl
            max-w-xl w-full overflow-hidden
            flex flex-col max-h-[90vh]">


<!-- CABECERA -->

<div class="bg-gradient-to-r
            from-emerald-600 to-teal-700
            px-6 py-4 text-white
            flex items-center justify-between">

    <div class="flex items-center gap-3">

        <span id="modalIdTicket"
              class="text-xs font-black
                     bg-white/20 px-3 py-1
                     rounded-full">

            #00

        </span>

        <div>

            <h3 id="tituloModalTexto"
                class="text-base font-extrabold">

                Gestión de Solicitud

            </h3>

            <p class="text-[11px] text-emerald-100">

                Panel de atención y seguimiento

            </p>

        </div>

    </div>


    <button type="button"
            onclick="cerrarModalTicket()"
            class="w-8 h-8 rounded-full
                   bg-white/10 hover:bg-white/25
                   flex items-center justify-center">

        <span class="material-symbols-outlined">
            close
        </span>

    </button>

</div>


<!-- ALERTA CRITICO -->

<div id="alertaCriticoBanner"
     class="hidden bg-red-50
            border-b border-red-200
            px-6 py-3 text-red-900
            items-center gap-3">

    <span class="material-symbols-outlined text-red-600">
        warning
    </span>

    <div>

        <h4 class="text-xs font-black uppercase">
            Ticket Crítico Urgente
        </h4>

        <p class="text-[11px]">
            Requiere atención prioritaria.
        </p>

    </div>

</div>


<!-- ALERTA SLA -->

<div id="modalSlaAlerta"
     class="px-6 py-3 hidden">

    <div id="modalSlaAlertaContenido"
         class="rounded-xl p-3
                text-xs font-bold
                flex items-center gap-2">

    </div>

</div>


<!-- TABS -->

<div class="flex border-b border-slate-200
            bg-slate-50 px-6 pt-3 gap-1">

    <button type="button"
            id="tabBtnDetalles"
            onclick="cambiarTab('detalles')"
            class="tab-btn
                   border-b-2 border-emerald-600
                   text-emerald-700
                   font-extrabold text-xs
                   py-2.5 px-4">

        Detalles

    </button>


    <button type="button"
            id="tabBtnHistorial"
            onclick="cambiarTab('historial')"
            class="tab-btn border-b-2
                   border-transparent
                   text-slate-500
                   font-bold text-xs
                   py-2.5 px-4">

        Historial

    </button>


    <button type="button"
            id="tabBtnResponder"
            onclick="cambiarTab('responder')"
            class="tab-btn border-b-2
                   border-transparent
                   text-slate-500
                   font-bold text-xs
                   py-2.5 px-4">

        Añadir Comentario

    </button>

</div>


<!-- CUERPO -->

<div class="p-6 overflow-y-auto
            space-y-5 flex-grow">


<!-- ===================================================== -->
<!-- DETALLES -->
<!-- ===================================================== -->

<div id="tabDetalles"
     class="tab-content space-y-4">


<div class="bg-slate-50 p-4
            rounded-2xl border">

    <span class="text-[10px]
                 font-black uppercase
                 text-slate-400">

        Asunto

    </span>

    <h4 id="modalTitulo"
        class="text-sm font-black
               text-slate-900">
    </h4>

</div>


<div class="grid grid-cols-2 gap-3
            p-4 bg-slate-50
            rounded-2xl border text-xs">


<div>

    <span class="text-[10px]
                 text-slate-400
                 font-bold uppercase">

        Solicitante

    </span>

    <span id="modalSolicitante"
          class="font-extrabold
                 text-slate-800 block">
    </span>

</div>


<div>

    <span class="text-[10px]
                 text-slate-400
                 font-bold uppercase">

        Categoría

    </span>

    <span id="modalCategoria"
          class="font-extrabold
                 text-slate-800 block">
    </span>

</div>


<div class="pt-2 border-t">

    <span class="text-[10px]
                 text-slate-400
                 font-bold uppercase">

        Prioridad

    </span>

    <span id="modalPrioridad"
          class="font-bold block">
    </span>

</div>


<div class="pt-2 border-t">

    <span class="text-[10px]
                 text-slate-400
                 font-bold uppercase">

        SLA

    </span>

    <span id="modalSLA"
          class="font-extrabold
                 text-amber-700 block">

        0 horas

    </span>

</div>


<div class="pt-2 border-t">

    <span class="text-[10px]
                 text-slate-400
                 font-bold uppercase">

        Fecha

    </span>

    <span id="modalFecha"
          class="font-extrabold
                 text-slate-800 block">
    </span>

</div>


<div class="pt-2 border-t">

    <span class="text-[10px]
                 text-slate-400
                 font-bold uppercase">

        Tiempo restante

    </span>

    <span id="modalTiempoRestante"
          class="font-extrabold
                 text-emerald-700 block">

        Calculando...

    </span>

</div>

</div>


<!-- DESCRIPCION -->

<div>

    <span class="text-[10px]
                 font-black uppercase
                 text-slate-400">

        Descripción del Problema

    </span>

    <div id="modalDescripcion"
         class="mt-1 p-4 rounded-2xl
                bg-white border text-xs
                text-slate-700
                leading-relaxed
                max-h-32 overflow-y-auto">
    </div>

</div>


<!-- ===================================================== -->
<!-- ESTADOS -->
<!-- ===================================================== -->

<div class="p-5 bg-slate-50
            border rounded-2xl space-y-4">

    <div class="flex items-center
                justify-between">

        <h5 class="text-xs font-black uppercase">
            Progreso de Solución
        </h5>

        <span id="lblEstadoIndicador"
              class="text-[10px] font-black
                     uppercase px-2.5 py-0.5
                     rounded-full bg-slate-200
                     text-slate-700">

            NUEVO

        </span>

    </div>


    <div class="flex items-center
                justify-between relative
                px-2 my-2">

<%
    String[] nombresPaso = {
        "NUEVO",
        "ASIGNADO",
        "EN PROCESO",
        "RESUELTO",
        "CERRADO"
    };

    for (int i = 1; i <= 5; i++) {
%>

<div class="flex flex-col items-center
            gap-1.5 z-10">

    <div id="circulo-<%= i %>"
         class="w-8 h-8 rounded-full
                border-2 border-slate-300
                bg-white text-slate-400
                font-black text-xs
                flex items-center
                justify-center">

        <%= i %>

    </div>

    <span id="label-<%= i %>"
          class="text-[9px]
                 font-extrabold
                 text-slate-400
                 text-center">

        <%= nombresPaso[i - 1] %>

    </span>

</div>


<%
        if (i < 5) {
%>

<span id="flecha-<%= i %>"
      class="text-slate-300
             font-bold text-xs">

    ➔

</span>

<%
        }
    }
%>

</div>


<div class="pt-2 border-t
            flex items-center
            justify-between gap-3">

    <p class="text-[11px]
              text-slate-500">

        Estado actual:

        <strong id="estadoActual"
                class="text-emerald-700">

            NUEVO

        </strong>

    </p>


    <button type="button"
            id="btnAvanzarEstado"
            onclick="avanzarEstadoAjax()"
            class="px-4 py-2 rounded-xl
                   bg-emerald-600
                   hover:bg-emerald-700
                   text-white text-xs
                   font-extrabold
                   flex items-center gap-1.5">

        <span class="material-symbols-outlined text-base">
            forward
        </span>

        Avanzar Estado

    </button>

</div>

</div>

</div>


<!-- ===================================================== -->
<!-- HISTORIAL -->
<!-- ===================================================== -->

<div id="tabHistorial"
     class="tab-content hidden space-y-3">

    <div id="modalHistorialComentarios"
         class="space-y-3 max-h-72
                overflow-y-auto">

    </div>

</div>


<!-- ===================================================== -->
<!-- COMENTARIO -->
<!-- ===================================================== -->

<div id="tabResponder"
     class="tab-content hidden space-y-4">

<form id="formRespuestaModal"
      onsubmit="enviarComentarioAjax(event)">

    <input type="hidden"
           name="idTicket"
           id="formIdTicket">


    <label class="block text-xs
                  font-extrabold mb-1">

        Respuesta / Observaciones

    </label>


    <textarea id="comentario"
              name="comentario"
              rows="4"
              required
              placeholder="Describe las acciones realizadas..."
              class="w-full p-3.5 rounded-2xl
                     border border-slate-300
                     text-xs resize-none
                     focus:ring-2
                     focus:ring-emerald-500/30
                     focus:border-emerald-500
                     focus:outline-none"></textarea>


    <div id="mensajeEstadoForm"
         class="hidden mt-3 p-3
                rounded-xl text-xs
                font-bold text-center">
    </div>


    <div class="flex justify-end
                gap-2.5 pt-3 mt-3
                border-t">

        <button type="button"
                onclick="cerrarModalTicket()"
                class="px-4 py-2.5 rounded-xl
                       bg-slate-100
                       hover:bg-slate-200
                       text-slate-700
                       text-xs font-bold">

            Cancelar

        </button>


        <button id="btnGuardarModal"
                type="submit"
                class="px-5 py-2.5 rounded-xl
                       bg-emerald-600
                       hover:bg-emerald-700
                       text-white text-xs
                       font-extrabold
                       flex items-center gap-2">

            <span class="material-symbols-outlined text-sm">
                send
            </span>

            Guardar Comentario

        </button>

    </div>

</form>

</div>


</div>


<!-- FOOTER -->

<div class="bg-slate-50 px-6 py-3
            border-t text-[11px]
            text-slate-500 flex
            justify-between items-center">

    <span>

        Estado actual:

        <strong id="modalEstadoActual"
                class="text-slate-800">

            NUEVO

        </strong>

    </span>


    <button type="button"
            onclick="cerrarModalTicket()"
            class="font-extrabold">

        Cerrar

    </button>

</div>


</div>

</div>


<!-- ===================================================== -->
<!-- JAVASCRIPT -->
<!-- ===================================================== -->

<script>

let currentTicketId = null;

let estadoActualIndex = 0;

let currentFechaCreacion = 0;

let currentHorasSLA = 0;

let currentEstado = "NUEVO";


/*
 * IMPORTANTE:
 * Los estados se generan desde la BD.
 * Ya NO quedan fijados a los IDs 1,2,3,4,5.
 */

const LISTA_ESTADOS = [

<%
    if (estados != null && !estados.isEmpty()) {

        for (int i = 0; i < estados.size(); i++) {

            EstadoTicket estadoBD =
                    estados.get(i);

           String nombreEstadoBD = estadoBD.nombre();
nombreEstadoBD = nombreEstadoBD.replace("_", " ").trim().toUpperCase();

            nombreEstadoBD =
                    nombreEstadoBD
                            .replace("_", " ")
                            .trim()
                            .toUpperCase();
%>

    {
      id: <%= estadoBD.idEstado() %>,
        nombre: "<%= escaparHTML(nombreEstadoBD) %>"
    }<%= i < estados.size() - 1 ? "," : "" %>

<%
        }

    }
%>

];


const ticketEstadosCache = {};


/* =====================================================
   NORMALIZAR ESTADO
===================================================== */

function normalizarEstado(estado) {

    if (!estado) {
        return "NUEVO";
    }

    return String(estado)
        .replace(/_/g, " ")
        .trim()
        .toUpperCase();

}


/* =====================================================
   SLA
===================================================== */

function obtenerSlaMs(fechaCreacion, horasSLA) {

    return Number(fechaCreacion) +
           Number(horasSLA) *
           60 *
           60 *
           1000;

}


function formatearDuracion(ms) {

    let segundos =
        Math.floor(
            Math.abs(ms) / 1000
        );


    const dias =
        Math.floor(
            segundos / 86400
        );


    segundos %= 86400;


    const horas =
        Math.floor(
            segundos / 3600
        );


    segundos %= 3600;


    const minutos =
        Math.floor(
            segundos / 60
        );


    if (dias > 0) {

        return dias + " d " +
               horas + " h " +
               minutos + " min";

    }


    if (horas > 0) {

        return horas + " h " +
               minutos + " min";

    }


    return minutos + " min";

}


/* =====================================================
   SLA CARD
===================================================== */

function actualizarSlaCard(card) {

    const id =
        card.dataset.id;


    const fechaCreacion =
        Number(
            card.dataset.fechaMs
        );


    const horasSLA =
        Number(
            card.dataset.sla
        );


    const estado =
        normalizarEstado(
            card.dataset.estado
        );


    const texto =
        document.getElementById(
            "sla-text-" + id
        );


    const detalle =
        document.getElementById(
            "sla-detalle-" + id
        );


    const contenedor =
        document.getElementById(
            "sla-card-" + id
        );


    if (
        !fechaCreacion ||
        !horasSLA
    ) {

        if (texto) {

            texto.textContent =
                "SLA no disponible";

        }

        return;

    }


    if (
        estado === "RESUELTO" ||
        estado === "CERRADO"
    ) {

        if (texto) {

            texto.textContent =
                "✓ Atendido";

        }


        if (contenedor) {

            contenedor.className =
                "sla-card bg-emerald-50 " +
                "text-emerald-800 p-2 rounded-xl " +
                "border border-emerald-200 " +
                "flex items-center gap-1.5";

        }


        if (detalle) {

            detalle.innerHTML =
                '<p class="text-[9px] uppercase ' +
                'font-black text-slate-400">' +
                'Tiempo de atención' +
                '</p>' +

                '<p class="text-[11px] font-black ' +
                'text-emerald-700">' +
                '✓ Ticket atendido' +
                '</p>';

        }

        return;

    }


    const diferencia =
        obtenerSlaMs(
            fechaCreacion,
            horasSLA
        ) - Date.now();


    if (diferencia > 0) {

        const tiempo =
            formatearDuracion(
                diferencia
            );


        if (texto) {

            texto.textContent =
                "Faltan " + tiempo;

        }


        if (contenedor) {

            contenedor.className =
                "sla-card bg-amber-50 " +
                "text-amber-800 p-2 rounded-xl " +
                "border border-amber-200 " +
                "flex items-center gap-1.5";

        }


        if (detalle) {

            detalle.innerHTML =
                '<p class="text-[9px] uppercase ' +
                'font-black text-slate-400">' +
                'Tiempo de atención' +
                '</p>' +

                '<p class="text-[11px] font-black ' +
                'text-amber-700">' +
                '⏳ Faltan ' +
                tiempo +
                '</p>';

        }

    } else {

        const tiempo =
            formatearDuracion(
                diferencia
            );


        if (texto) {

            texto.textContent =
                "⚠ VENCIDO hace " +
                tiempo;

        }


        if (contenedor) {

            contenedor.className =
                "sla-card bg-red-50 " +
                "text-red-800 p-2 rounded-xl " +
                "border border-red-300 " +
                "flex items-center gap-1.5 " +
                "animate-pulse";

        }


        if (detalle) {

            detalle.innerHTML =
                '<p class="text-[9px] uppercase ' +
                'font-black text-red-400">' +
                'Tiempo de atención' +
                '</p>' +

                '<p class="text-[11px] font-black ' +
                'text-red-700">' +
                '🚨 VENCIDO hace ' +
                tiempo +
                '</p>';

        }

    }

}


/* =====================================================
   TODOS LOS SLA
===================================================== */

function actualizarTodosLosSLA() {

    document
        .querySelectorAll(".card-ticket")
        .forEach(
            actualizarSlaCard
        );


    actualizarSlaModal();

}


/* =====================================================
   SLA MODAL
===================================================== */

function actualizarSlaModal() {

    if (
        !currentTicketId ||
        !currentFechaCreacion ||
        !currentHorasSLA
    ) {

        return;

    }


    const texto =
        document.getElementById(
            "modalTiempoRestante"
        );


    const alerta =
        document.getElementById(
            "modalSlaAlerta"
        );


    const alertaContenido =
        document.getElementById(
            "modalSlaAlertaContenido"
        );


    const diferencia =
        obtenerSlaMs(
            currentFechaCreacion,
            currentHorasSLA
        ) - Date.now();


    if (
        currentEstado === "RESUELTO" ||
        currentEstado === "CERRADO"
    ) {

        texto.textContent =
            "✓ Atendido";

        texto.className =
            "font-extrabold text-emerald-700 block";


        alerta.classList.remove("hidden");


        alertaContenido.className =
            "rounded-xl p-3 text-xs font-bold " +
            "flex items-center gap-2 " +
            "bg-emerald-50 text-emerald-800 " +
            "border border-emerald-200";


        alertaContenido.innerHTML =
            '<span class="material-symbols-outlined">' +
            'check_circle' +
            '</span>' +
            '<span>Ticket atendido.</span>';

        return;

    }


    const tiempo =
        formatearDuracion(
            diferencia
        );


    alerta.classList.remove("hidden");


    if (diferencia > 0) {

        texto.textContent =
            "Faltan " + tiempo;

        texto.className =
            "font-extrabold text-emerald-700 block";


        alertaContenido.className =
            "rounded-xl p-3 text-xs font-bold " +
            "flex items-center gap-2 " +
            "bg-amber-50 text-amber-800 " +
            "border border-amber-200";


        alertaContenido.innerHTML =
            '<span class="material-symbols-outlined">' +
            'timer' +
            '</span>' +

            '<span>Quedan ' +
            tiempo +
            ' para atender este ticket.</span>';

    } else {

        texto.textContent =
            "⚠ VENCIDO hace " +
            tiempo;


        texto.className =
            "font-extrabold text-red-700 block";


        alertaContenido.className =
            "rounded-xl p-3 text-xs font-bold " +
            "flex items-center gap-2 " +
            "bg-red-50 text-red-800 " +
            "border border-red-300";


        alertaContenido.innerHTML =
            '<span class="material-symbols-outlined">' +
            'warning' +
            '</span>' +

            '<span>🚨 EL SLA YA VENCIÓ. ' +
            'Vencido hace ' +
            tiempo +
            '.</span>';

    }

}


/* =====================================================
   TABS
===================================================== */

function cambiarTab(nombreTab) {

    document
        .querySelectorAll(".tab-content")
        .forEach(tab => {

            tab.classList.add("hidden");

        });


    document
        .querySelectorAll(".tab-btn")
        .forEach(btn => {

            btn.classList.remove(
                "border-emerald-600",
                "text-emerald-700",
                "font-extrabold"
            );

            btn.classList.add(
                "border-transparent",
                "text-slate-500",
                "font-bold"
            );

        });


    let tab;
    let boton;


    if (nombreTab === "detalles") {

        tab =
            document.getElementById(
                "tabDetalles"
            );

        boton =
            document.getElementById(
                "tabBtnDetalles"
            );

    }


    if (nombreTab === "historial") {

        tab =
            document.getElementById(
                "tabHistorial"
            );

        boton =
            document.getElementById(
                "tabBtnHistorial"
            );

    }


    if (nombreTab === "responder") {

        tab =
            document.getElementById(
                "tabResponder"
            );

        boton =
            document.getElementById(
                "tabBtnResponder"
            );

    }


    if (tab) {

        tab.classList.remove(
            "hidden"
        );

    }


    if (boton) {

        boton.classList.remove(
            "border-transparent",
            "text-slate-500",
            "font-bold"
        );

        boton.classList.add(
            "border-emerald-600",
            "text-emerald-700",
            "font-extrabold"
        );

    }

}


/* =====================================================
   ACTUALIZAR GUIA
===================================================== */

function actualizarGuia() {

    const estado =
        LISTA_ESTADOS[
            estadoActualIndex
        ] || LISTA_ESTADOS[0];


    if (!estado) {

        return;

    }


    currentEstado =
        estado.nombre;


    const elementos = [

        "estadoActual",
        "modalEstadoActual",
        "lblEstadoIndicador"

    ];


    elementos.forEach(id => {

        const elemento =
            document.getElementById(id);

        if (elemento) {

            elemento.textContent =
                estado.nombre;

        }

    });


    for (
        let i = 1;
        i <= 5;
        i++
    ) {

        const circulo =
            document.getElementById(
                "circulo-" + i
            );


        const label =
            document.getElementById(
                "label-" + i
            );


        if (!circulo || !label) {

            continue;

        }


        const indice =
            i - 1;


        circulo.className =
            "w-8 h-8 rounded-full border-2 " +
            "font-black text-xs flex items-center " +
            "justify-center transition-all";


        label.className =
            "text-[9px] font-extrabold " +
            "tracking-wider text-center";


        if (indice < estadoActualIndex) {

            circulo.classList.add(
                "bg-emerald-600",
                "border-emerald-600",
                "text-white"
            );

            label.classList.add(
                "text-emerald-700"
            );

        } else if (
            indice === estadoActualIndex
        ) {

            circulo.classList.add(
                "bg-blue-600",
                "border-blue-600",
                "text-white",
                "ring-4",
                "ring-blue-100"
            );

            label.classList.add(
                "text-blue-700"
            );

        } else {

            circulo.classList.add(
                "bg-white",
                "border-slate-300",
                "text-slate-400"
            );

            label.classList.add(
                "text-slate-400"
            );

        }

    }


    const boton =
        document.getElementById(
            "btnAvanzarEstado"
        );


    if (!boton) {

        return;

    }


    if (
        estadoActualIndex >=
        LISTA_ESTADOS.length - 1
    ) {

        boton.disabled = true;

        boton.className =
            "px-4 py-2 rounded-xl bg-slate-300 " +
            "text-slate-500 text-xs font-extrabold " +
            "cursor-not-allowed flex items-center gap-1.5";

        boton.innerHTML =
            '<span class="material-symbols-outlined text-base">' +
            'check_circle</span>' +
            '<span>Ticket Cerrado</span>';

    } else {

        boton.disabled = false;

        boton.className =
            "px-4 py-2 rounded-xl bg-emerald-600 " +
            "hover:bg-emerald-700 text-white text-xs " +
            "font-extrabold flex items-center gap-1.5";

        boton.innerHTML =
            '<span class="material-symbols-outlined text-base">' +
            'forward</span>' +
            '<span>Avanzar Estado</span>';

    }

}


/* =====================================================
   AVANZAR ESTADO
===================================================== */

function avanzarEstadoAjax() {

    if (!currentTicketId) {

        alert(
            "No se ha seleccionado ningún ticket."
        );

        return;

    }


    if (
        estadoActualIndex >=
        LISTA_ESTADOS.length - 1
    ) {

        return;

    }


    const siguienteIndex =
        estadoActualIndex + 1;


    const siguienteEstado =
        LISTA_ESTADOS[
            siguienteIndex
        ];


    if (!siguienteEstado) {

        alert(
            "No existe un siguiente estado configurado."
        );

        return;

    }


    const boton =
        document.getElementById(
            "btnAvanzarEstado"
        );


    if (boton) {
        boton.disabled = true;
    }
    const ACCIONES_AVANZAR = ["asignar", "iniciar", "resolver", "cerrar"];
    const accion = ACCIONES_AVANZAR[estadoActualIndex];
    if (!accion) {
        alert("No hay una acción configurada para avanzar desde este estado.");
        return;
    }
    const params =
        new URLSearchParams();
    params.append(
        "id_ticket",
        currentTicketId
    );
    params.append(
        "accion",
        accion
    );
    fetch(
        "${pageContext.request.contextPath}/atender",
        {

            method: "POST",

            headers: {

                "Content-Type":
                    "application/x-www-form-urlencoded;charset=UTF-8",

                "X-Requested-With":
                    "XMLHttpRequest"

            },

            body:
                params.toString()

        }
    )

    .then(async response => {

        const texto =
            await response.text();


        if (!response.ok) {

            throw new Error(
                texto ||
                "HTTP " +
                response.status
            );

        }


        /*
         * Evita considerar exitoso un
         * response "false".
         */

        if (
            texto.trim().toLowerCase() === "false" ||
            texto.trim().toLowerCase().includes("error")
        ) {

            throw new Error(
                texto ||
                "No se pudo actualizar el estado."
            );

        }


        return texto;

    })

    .then(() => {

        estadoActualIndex =
            siguienteIndex;


        currentEstado =
            siguienteEstado.nombre;


        ticketEstadosCache[
            currentTicketId
        ] =
            siguienteEstado.nombre;


        actualizarGuia();


        const badge =
            document.getElementById(
                "badge-estado-" +
                currentTicketId
            );


        if (badge) {

            badge.textContent =
                siguienteEstado.nombre;

        }


        const card =
            document.getElementById(
                "card-ticket-" +
                currentTicketId
            );


        if (card) {

            card.dataset.estado =
                siguienteEstado.nombre;

        }


        actualizarTodosLosSLA();

    })

    .catch(error => {

        console.error(
            "Error actualizando estado:",
            error
        );


        alert(
            error.message ||
            "No se pudo actualizar el estado del ticket."
        );

    })

    .finally(() => {

        if (boton) {

            boton.disabled = false;

        }


        actualizarGuia();

    });

}


/* =====================================================
   ABRIR MODAL DESDE CARD
===================================================== */

function abrirModalTicketDesdeCard(id) {

    const card =
        document.getElementById(
            "card-ticket-" + id
        );


    if (!card) {

        alert(
            "No se encontró el ticket."
        );

        return;

    }


    const titulo =
        card.dataset.titulo || "";


    const descripcion =
        card.dataset.descripcion || "";


    const categoria =
        card.dataset.categoria || "";


    const solicitante =
        card.dataset.solicitante || "";


    const prioridad =
        card.dataset.prioridad || "MEDIA";


    const estado =
        normalizarEstado(
            card.dataset.estado
        );


    const fechaCreacion =
        Number(
            card.dataset.fechaMs
        );


    const horasSLA =
        Number(
            card.dataset.sla
        );


    const fechaTexto =
        formatearFechaModal(
            fechaCreacion
        );


    abrirModalTicket(

        id,

        titulo,

        descripcion,

        categoria,

        solicitante,

        prioridad,

        estado,

        fechaTexto,

        horasSLA,

        prioridad === "CRITICA",

        fechaCreacion

    );

}


/* =====================================================
   FECHA
===================================================== */

function formatearFechaModal(ms) {

    if (!ms) {

        return "N/A";

    }


    const fecha =
        new Date(ms);


    const dia =
        String(
            fecha.getDate()
        ).padStart(2, "0");


    const mes =
        String(
            fecha.getMonth() + 1
        ).padStart(2, "0");


    const año =
        fecha.getFullYear();


    const hora =
        String(
            fecha.getHours()
        ).padStart(2, "0");


    const minutos =
        String(
            fecha.getMinutes()
        ).padStart(2, "0");


    return dia + "/" +
           mes + "/" +
           año + " " +
           hora + ":" +
           minutos;

}


/* =====================================================
   ABRIR MODAL
===================================================== */

function abrirModalTicket(
    id,
    titulo,
    descripcion,
    categoria,
    solicitante,
    prioridad,
    estado,
    fecha,
    horasSLA,
    esCritico,
    fechaCreacion
) {

    currentTicketId =
        String(id);


    currentFechaCreacion =
        Number(fechaCreacion);


    currentHorasSLA =
        Number(horasSLA);


    currentEstado =
        normalizarEstado(
            estado
        );


    document.getElementById(
        "modalIdTicket"
    ).textContent =
        "#" + id;


    document.getElementById(
        "formIdTicket"
    ).value =
        id;


    document.getElementById(
        "modalTitulo"
    ).textContent =
        titulo || "";


    document.getElementById(
        "tituloModalTexto"
    ).textContent =
        titulo ||
        "Gestión de Solicitud";


    document.getElementById(
        "modalDescripcion"
    ).textContent =
        descripcion || "";


    document.getElementById(
        "modalCategoria"
    ).textContent =
        categoria ||
        "Sin categoría";


    document.getElementById(
        "modalSolicitante"
    ).textContent =
        solicitante ||
        "Sin usuario";


    document.getElementById(
        "modalPrioridad"
    ).textContent =
        prioridad ||
        "MEDIA";


    document.getElementById(
        "modalSLA"
    ).textContent =
        Number(horasSLA || 0) +
        " horas";


    document.getElementById(
        "modalFecha"
    ).textContent =
        fecha ||
        "N/A";


    let estadoEfectivo =
        ticketEstadosCache[
            currentTicketId
        ] ||
        estado ||
        "NUEVO";


    estadoEfectivo =
        normalizarEstado(
            estadoEfectivo
        );


    currentEstado =
        estadoEfectivo;


    let indice =
        LISTA_ESTADOS.findIndex(
            e =>
                normalizarEstado(
                    e.nombre
                ) ===
                estadoEfectivo
        );


    if (indice < 0) {

        indice = 0;

    }


    estadoActualIndex =
        indice;


    actualizarGuia();


    const banner =
        document.getElementById(
            "alertaCriticoBanner"
        );


    if (esCritico) {

        banner.classList.remove(
            "hidden"
        );

        banner.classList.add(
            "flex"
        );

    } else {

        banner.classList.add(
            "hidden"
        );

        banner.classList.remove(
            "flex"
        );

    }


    cargarComentarios(id);


    cambiarTab(
        "detalles"
    );


    document.getElementById(
        "modalTicket"
    ).classList.remove(
        "hidden"
    );


    document.body.classList.add(
        "overflow-hidden"
    );


    actualizarSlaModal();

}


/* =====================================================
   CERRAR MODAL
===================================================== */

function cerrarModalTicket() {

    const modal =
        document.getElementById(
            "modalTicket"
        );


    if (modal) {

        modal.classList.add(
            "hidden"
        );

    }


    document.body.classList.remove(
        "overflow-hidden"
    );


    const mensaje =
        document.getElementById(
            "mensajeEstadoForm"
        );


    if (mensaje) {

        mensaje.classList.add(
            "hidden"
        );

    }


    const comentario =
        document.getElementById(
            "comentario"
        );


    if (comentario) {

        comentario.value = "";

    }


    currentTicketId = null;

    currentFechaCreacion = 0;

    currentHorasSLA = 0;

    currentEstado = "NUEVO";

}


/* =====================================================
   BACKDROP
===================================================== */

function cerrarPorBackdrop(event) {

    if (
        event.target.id ===
        "modalTicket"
    ) {

        cerrarModalTicket();

    }

}


/* =====================================================
   ESC
===================================================== */

document.addEventListener(
    "keydown",
    function(event) {

        if (event.key === "Escape") {

            const modal =
                document.getElementById(
                    "modalTicket"
                );


            if (
                modal &&
                !modal.classList.contains(
                    "hidden"
                )
            ) {

                cerrarModalTicket();

            }

        }

    }
);


/* =====================================================
   FILTROS LOCALES
===================================================== */

function aplicarFiltros() {

    const buscar =
        (
            document.getElementById(
                "filtroBuscar"
            )?.value || ""
        )
        .toLowerCase()
        .trim();


    const prioridad =
        document.getElementById(
            "filtroPrioridad"
        )?.value ||
        "TODAS";


    const fecha =
        document.getElementById(
            "filtroFecha"
        )?.value ||
        "";


    const btnLimpiarFecha =
        document.getElementById(
            "btnLimpiarFecha"
        );


    if (btnLimpiarFecha) {

        btnLimpiarFecha.classList.toggle(
            "hidden",
            !fecha
        );

        btnLimpiarFecha.classList.toggle(
            "flex",
            !!fecha
        );

    }


    const cards =
        document.querySelectorAll(
            ".card-ticket"
        );


    let visibles = 0;


    cards.forEach(card => {

        const texto =
            (
                card.dataset.search ||
                ""
            )
            .toLowerCase();


        const prioridadCard =
            card.dataset.prioridad ||
            "";


        const fechaCard =
            card.dataset.fecha ||
            "";


        let mostrar = true;


        if (
            buscar &&
            !texto.includes(buscar)
        ) {

            mostrar = false;

        }


        if (
            prioridad !== "TODAS" &&
            prioridadCard !== prioridad
        ) {

            mostrar = false;

        }


        if (
            mostrar &&
            fecha
        ) {

            /*
             * fechaCard ya viene en formato ISO
             * yyyy-MM-dd (mismo formato que produce
             * el <input type="date">), así que se
             * compara directamente como texto sin
             * necesidad de construir objetos Date
             * (evita problemas de zona horaria).
             */

            if (fechaCard !== fecha) {

                mostrar = false;

            }

        }


        card.style.display =
            mostrar
            ? ""
            : "none";


        if (mostrar) {

            visibles++;

        }

    });


    const contador =
        document.getElementById(
            "contadorMostrados"
        );


    if (contador) {

        contador.textContent =
            visibles;

    }


    const sinResultados =
        document.getElementById(
            "sinResultados"
        );


    if (sinResultados) {

        sinResultados.classList.toggle(
            "hidden",
            visibles !== 0
        );

    }

}


/* =====================================================
   LIMPIAR FECHA
===================================================== */

function limpiarFiltroFecha() {

    const input =
        document.getElementById(
            "filtroFecha"
        );


    if (input) {

        input.value = "";

    }


    aplicarFiltros();

}


/* =====================================================
   LIMPIAR
===================================================== */

function limpiarFiltros() {

    window.location.href =
        "${pageContext.request.contextPath}/atender";

}


/* =====================================================
   ESTADO DESDE SERVIDOR
===================================================== */

function cambiarEstadoServidor(valor) {

    let url =
        "${pageContext.request.contextPath}/atender";


    if (
        valor &&
        valor !== "TODOS"
    ) {

        url +=
            "?estado=" +
            encodeURIComponent(valor);

    }


    window.location.href =
        url;

}


/* =====================================================
   PRIORIDAD DESDE SERVIDOR
===================================================== */

function cambiarPrioridadServidor(prioridad) {

    const url =
        "${pageContext.request.contextPath}/atender";

    const estado =
        document.getElementById("filtroEstado").value;

    const parametros =
        new URLSearchParams();

    parametros.append("estado", estado);
    parametros.append("prioridad", prioridad);

    window.location.href =
        url + "?" + parametros.toString();
}


/* =====================================================
   CARGAR COMENTARIOS
===================================================== */

function cargarComentarios(idTicket) {

    const contenedor =
        document.getElementById(
            "modalHistorialComentarios"
        );

    if (!contenedor) {
        return;
    }

    contenedor.innerHTML =
        '<div class="text-center py-6">' +
        '<span class="material-symbols-outlined ' +
        'animate-spin text-emerald-600">' +
        'progress_activity' +
        '</span>' +
        '<p class="text-xs text-slate-500 mt-2">' +
        'Cargando historial...' +
        '</p>' +
        '</div>';


    fetch(
        "${pageContext.request.contextPath}/comentarios?idTicket="
        + encodeURIComponent(idTicket)
    )

    .then(async response => {

        if (!response.ok) {

            throw new Error(
                "No se pudieron cargar los comentarios."
            );

        }

        return response.json();

    })

    .then(comentarios => {

    console.log("COMENTARIOS RECIBIDOS:", comentarios);

    contenedor.innerHTML = "";

        if (
            !comentarios ||
            comentarios.length === 0
        ) { contenedor.innerHTML =
                '<div class="bg-slate-50 ' +
                'border border-slate-200 ' +
                'rounded-2xl p-6 text-center">' +

                '<span class="material-symbols-outlined ' +
                'text-slate-400 text-3xl">' +
                'chat_bubble_outline' +
                '</span>' +

                '<p class="text-xs font-bold ' +
                'text-slate-600 mt-2">' +
                'No hay comentarios todavía.' +
                '</p>' +

                '</div>';

            return;

        }


        comentarios.forEach(comentario => {

            const tarjeta =
                document.createElement("div");

            tarjeta.className =
                "bg-white border border-slate-200 " +
                "rounded-2xl p-4 shadow-sm";


            const autor =
                comentario.autor ||
                comentario.nombreUsuario ||
                comentario.usuario ||
                "Usuario";


     const texto =
    comentario.mensaje ||
    comentario.texto ||
    comentario.comentario ||
    comentario.contenido ||
    "";


            const fecha =
                comentario.fecha ||
                comentario.fechaComentario ||
                comentario.fecha_creacion ||
                "";


            tarjeta.innerHTML =

                '<div class="flex items-start ' +
                'justify-between gap-3">' +

                    '<div class="flex items-center gap-2">' +

                        '<div class="w-8 h-8 rounded-full ' +
                        'bg-emerald-100 text-emerald-700 ' +
                        'flex items-center justify-center">' +

                            '<span class="material-symbols-outlined ' +
                            'text-sm">' +
                            'person' +
                            '</span>' +

                        '</div>' +

                        '<div>' +

                            '<p class="text-xs font-black ' +
                            'text-slate-800">' +

                                escaparTextoJS(autor) +

                            '</p>' +

                            '<p class="text-[10px] ' +
                            'text-slate-400">' +

                                escaparTextoJS(fecha) +

                            '</p>' +

                        '</div>' +

                    '</div>' +

                '</div>' +

                '<div class="mt-3 p-3 rounded-xl ' +
                'bg-slate-50 border border-slate-100">' +

                    '<p class="text-xs text-slate-700 ' +
                    'leading-relaxed whitespace-pre-wrap">' +

                        escaparTextoJS(texto) +

                    '</p>' +

                '</div>';


            contenedor.appendChild(
                tarjeta
            );

        });

    })

    .catch(error => {

        console.error(
            "Error cargando comentarios:",
            error
        );


        contenedor.innerHTML =
            '<div class="bg-red-50 ' +
            'border border-red-200 ' +
            'rounded-2xl p-5 text-center">' +

            '<span class="material-symbols-outlined ' +
            'text-red-500 text-3xl">' +
            'error' +
            '</span>' +

            '<p class="text-xs font-bold ' +
            'text-red-700 mt-2">' +
            'No fue posible cargar el historial.' +
            '</p>' +

            '<p class="text-[10px] text-red-500 mt-1">' +
            escaparTextoJS(
                error.message
            ) +
            '</p>' +

            '</div>';

    });

}


/* =====================================================
   ESCAPAR TEXTO PARA JAVASCRIPT
===================================================== */

function escaparTextoJS(texto) {

    if (
        texto === null ||
        texto === undefined
    ) {

        return "";

    }


    return String(texto)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");

}


/* =====================================================
   ENVIAR COMENTARIO
===================================================== */

function enviarComentarioAjax(event) {

    event.preventDefault();


    if (!currentTicketId) {

        mostrarMensajeComentario(
            "No se ha seleccionado ningún ticket.",
            "error"
        );

        return;

    }


    const textarea =
        document.getElementById(
            "comentario"
        );


    const boton =
        document.getElementById(
            "btnGuardarModal"
        );


    const texto =
        textarea
            ? textarea.value.trim()
            : "";


    if (!texto) {

        mostrarMensajeComentario(
            "Escribe un comentario antes de guardar.",
            "error"
        );

        return;

    }


    if (boton) {

        boton.disabled = true;

        boton.innerHTML =
            '<span class="material-symbols-outlined ' +
            'text-sm animate-spin">' +
            'progress_activity' +
            '</span>' +

            '<span>Guardando...</span>';

    }


    const params =
        new URLSearchParams();


    params.append(
        "idTicket",
        currentTicketId
    );


    params.append(
        "comentario",
        texto
    );


fetch(
    "${pageContext.request.contextPath}/agregarComentario",
    {

            method: "POST",

            headers: {

                "Content-Type":
                    "application/x-www-form-urlencoded;charset=UTF-8"

            },

            body:
                params.toString()

        }
    )

    .then(async response => {

        const respuesta =
            await response.text();


        if (!response.ok) {

            throw new Error(
                respuesta ||
                "No se pudo guardar el comentario."
            );

        }


        if (
            respuesta.trim().toLowerCase() ===
            "false"
        ) {

            throw new Error(
                "El comentario no fue guardado."
            );

        }


        if (
            respuesta
                .trim()
                .toLowerCase()
                .includes("error")
        ) {

            throw new Error(
                respuesta
            );

        }


        return respuesta;

    })

    .then(() => {

        mostrarMensajeComentario(
            "¡Comentario guardado correctamente!",
            "success"
        );


        if (textarea) {

            textarea.value = "";

        }


        /*
         * Recargamos el historial
         * para mostrar inmediatamente
         * el nuevo comentario.
         */

        cargarComentarios(
            currentTicketId
        );


        /*
         * Mostramos el historial
         * después de guardar.
         */

        cambiarTab(
            "historial"
        );

    })

    .catch(error => {

        console.error(
            "Error guardando comentario:",
            error
        );


        mostrarMensajeComentario(
            error.message ||
            "No fue posible guardar el comentario.",
            "error"
        );

    })

    .finally(() => {

        if (boton) {

            boton.disabled = false;

            boton.innerHTML =
                '<span class="material-symbols-outlined text-sm">' +
                'send' +
                '</span>' +

                '<span>Guardar Comentario</span>';

        }

    });

}


/* =====================================================
   MENSAJE DEL FORMULARIO
===================================================== */

function mostrarMensajeComentario(
    mensaje,
    tipo
) {

    const elemento =
        document.getElementById(
            "mensajeEstadoForm"
        );


    if (!elemento) {

        return;

    }


    elemento.textContent =
        mensaje;


    elemento.classList.remove(
        "hidden",
        "bg-emerald-50",
        "text-emerald-700",
        "border-emerald-200",
        "bg-red-50",
        "text-red-700",
        "border-red-200"
    );


    elemento.classList.add(
        "border"
    );


    if (tipo === "success") {

        elemento.classList.add(
            "bg-emerald-50",
            "text-emerald-700",
            "border-emerald-200"
        );

    } else {

        elemento.classList.add(
            "bg-red-50",
            "text-red-700",
            "border-red-200"
        );

    }

}


/* =====================================================
   INICIALIZAR FILTROS
===================================================== */

document.addEventListener(
    "DOMContentLoaded",
    function() {

        actualizarTodosLosSLA();


        aplicarFiltros();


        /*
         * Actualizar SLA cada minuto.
         */

        setInterval(
            actualizarTodosLosSLA,
            60000
        );

    }
);


/* =====================================================
   ACTUALIZAR SLA AL VOLVER A LA PÁGINA
===================================================== */

document.addEventListener(
    "visibilitychange",
    function() {

        if (
            document.visibilityState ===
            "visible"
        ) {

            actualizarTodosLosSLA();

        }

    }
);


/* =====================================================
   EVITAR ENVÍO DUPLICADO CON ENTER
===================================================== */

const formularioComentario =
    document.getElementById(
        "formRespuestaModal"
    );


if (formularioComentario) {

    formularioComentario.addEventListener(
        "keydown",
        function(event) {

            if (
                event.key === "Enter" &&
                event.ctrlKey
            ) {

                event.preventDefault();

                enviarComentarioAjax(
                    event
                );

            }

        }
    );

}

/* =====================================================
   FINAL
===================================================== */

</script>

</body>
</html>