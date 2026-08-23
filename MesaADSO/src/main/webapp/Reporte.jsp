<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="co.edu.sena.mesaayuda.modelo.Usuario"%>

<%
    // =====================================================
    // USUARIO EN SESIÓN
    // =====================================================

    Usuario usuario = (Usuario) session.getAttribute("usuario");

    String nombreUsuario =
            (usuario != null && usuario.getnombre_usuario() != null)
            ? usuario.getnombre_usuario()
            : "Invitado";

    // =====================================================
    // INICIALES
    // =====================================================

    String iniciales = "";

    if (usuario != null && nombreUsuario != null) {

        String[] partes = nombreUsuario.trim().split("\\s+");

        for (String parte : partes) {

            if (!parte.isEmpty()) {
                iniciales += parte.charAt(0);
            }
        }

        iniciales = iniciales.toUpperCase();

        if (iniciales.length() > 2) {
            iniciales = iniciales.substring(0, 2);
        }

    } else {

        iniciales = "?";
    }

    // =====================================================
    // DATOS DE REPORTES
    // =====================================================

    Integer totalTickets =
            (Integer) request.getAttribute("totalTickets");

    Integer slasVencidos =
            (Integer) request.getAttribute("slasVencidos");

    List<Map<String, Object>> ticketsEstado =
            (List<Map<String, Object>>) request.getAttribute("ticketsEstado");

    List<Map<String, Object>> ticketsPrioridad =
            (List<Map<String, Object>>) request.getAttribute("ticketsPrioridad");

    List<Map<String, Object>> ticketsCategoria =
            (List<Map<String, Object>>) request.getAttribute("ticketsCategoria");

    List<Map<String, Object>> ticketsAgente =
            (List<Map<String, Object>>) request.getAttribute("ticketsAgente");


    // =====================================================
    // EVITAR NULL
    // =====================================================

    if (ticketsEstado == null) {
        ticketsEstado = new java.util.ArrayList<Map<String, Object>>();
    }

    if (ticketsPrioridad == null) {
        ticketsPrioridad = new java.util.ArrayList<Map<String, Object>>();
    }

    if (ticketsCategoria == null) {
        ticketsCategoria = new java.util.ArrayList<Map<String, Object>>();
    }

    if (ticketsAgente == null) {
        ticketsAgente = new java.util.ArrayList<Map<String, Object>>();
    }

%>

<!DOCTYPE html>

<html lang="es" class="h-full">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>SENA CIMM - Dashboard de Reportes</title>


    <!-- =====================================================
         TAILWIND
         ===================================================== -->

    <script src="https://cdn.tailwindcss.com"></script>


    <!-- =====================================================
         CHART JS
         ===================================================== -->

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>


    <!-- =====================================================
         SWEET ALERT
         ===================================================== -->

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


    <!-- =====================================================
         FUENTES
         ===================================================== -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap"
          rel="stylesheet">


    <!-- =====================================================
         ICONOS
         ===================================================== -->

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0">


    <!-- =====================================================
         CONFIGURACIÓN TAILWIND
         ===================================================== -->

    <script>

        tailwind.config = {

            theme: {

                extend: {

                    fontFamily: {

                        sans: [
                            'Plus Jakarta Sans',
                            'sans-serif'
                        ]

                    },

                    colors: {

                        header: {

                            bg: '#1d590f',

                            mint: '#bdf4c3',

                            button: '#15430b'
                        },

                        sena: {

                            50: '#f0fdf4',
                            100: '#dcfce7',
                            200: '#bbf7d0',
                            300: '#86efac',
                            400: '#4ade80',
                            500: '#39a900',
                            600: '#2e8800',
                            700: '#236900',
                            800: '#1a4f00',
                            900: '#0f2900'

                        }

                    }

                }

            }

        };

    </script>


    <style>

        .bg-gradient-mesh {

            background-color: #f1f5f9;

            background-image:

                radial-gradient(
                    at 0% 0%,
                    rgba(29, 89, 15, 0.10) 0px,
                    transparent 50%
                ),

                radial-gradient(
                    at 100% 0%,
                    rgba(14, 165, 233, 0.10) 0px,
                    transparent 50%
                ),

                radial-gradient(
                    at 50% 100%,
                    rgba(245, 158, 11, 0.08) 0px,
                    transparent 50%
                );

        }

    </style>

</head>


<body class="h-full font-sans text-slate-800 antialiased flex flex-col bg-gradient-mesh min-h-screen">


<!-- =========================================================
     HEADER
     ========================================================= -->

<header class="sticky top-0 z-50 bg-header-bg text-white shadow-md">

    <div class="max-w-7xl mx-auto h-20 px-4 sm:px-6 lg:px-8 flex items-center justify-between">


        <!-- LOGO -->

        <a href="PanelPrincipal.jsp"
           class="flex items-center gap-3.5 group">

            <div class="w-12 h-12 rounded-2xl bg-header-mint text-header-bg flex items-center justify-center shadow-sm">

                <span class="material-symbols-outlined text-2xl font-bold">
                    verified_user
                </span>

            </div>

            <div class="flex flex-col leading-tight">

                <h1 class="font-extrabold text-lg text-white tracking-tight">

                    SENA

                    <span class="text-header-mint">
                        CIMM
                    </span>

                </h1>

                <p class="text-[11px] font-extrabold text-slate-100 uppercase tracking-wider">

                    MESA DE AYUDA

                </p>

            </div>

        </a>


        <!-- USUARIO -->

        <div class="flex items-center gap-4">

            <a href="PanelPrincipal.jsp"
               class="hidden sm:inline-flex px-4 py-2.5 rounded-2xl bg-header-button hover:bg-black/30 text-white text-xs font-bold transition-all items-center gap-2 border border-white/10 shadow-sm">

                <span class="material-symbols-outlined text-base">
                    arrow_back
                </span>

                <span>
                    Volver al Panel
                </span>

            </a>


            <div class="flex items-center gap-3 bg-header-button p-1.5 pr-4 rounded-2xl border border-white/10 shadow-inner">

                <div class="w-9 h-9 rounded-xl bg-header-mint text-header-bg flex items-center justify-center text-xs font-black">

                    <%= iniciales %>

                </div>

                <div class="flex flex-col text-left leading-none">

                    <span class="text-[9px] uppercase font-extrabold text-header-mint tracking-wider">

                        Sesión Activa

                    </span>

                    <span class="text-xs font-black text-white mt-0.5">

                        <%= nombreUsuario %>

                    </span>

                </div>

            </div>

        </div>

    </div>

</header>


<!-- =========================================================
     CONTENIDO
     ========================================================= -->

<main class="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-8">


<!-- =========================================================
     TITULO Y FILTROS
     ========================================================= -->

<div class="bg-white/90 backdrop-blur-md rounded-3xl p-6 border border-slate-200/80 shadow-lg flex flex-col lg:flex-row lg:items-center justify-between gap-4">

    <div>

        <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-sena-50 text-sena-700 text-[11px] font-bold border border-sena-200 mb-2">

            <span class="w-2 h-2 rounded-full bg-sena-500 animate-pulse"></span>

            Métricas en tiempo real

        </div>

        <h2 class="text-2xl font-black text-slate-900 tracking-tight">

            Reportes y Estadísticas

        </h2>

        <p class="text-xs font-semibold text-slate-500 mt-0.5">

            Indicadores de distribución de los tickets registrados.

        </p>

    </div>


    <!-- FILTROS -->

    <div class="flex flex-wrap items-center gap-3 bg-slate-50 p-2.5 rounded-2xl border border-slate-200">

        <div class="flex items-center gap-1.5 text-xs font-extrabold text-slate-600 mr-1 pl-1">

            <span class="material-symbols-outlined text-sena-600 text-lg">
                tune
            </span>

            Filtros:

        </div>


        <div class="w-48">

            <select id="filtroCategoria"
                    onchange="aplicarFiltros()"
                    class="w-full px-3.5 py-2 rounded-xl bg-white border border-slate-300 text-xs font-bold text-slate-700">

                <option value="">
                    Todas las Categorías
                </option>

            </select>

        </div>


        <div class="w-44">

            <select id="filtroPrioridad"
                    onchange="aplicarFiltros()"
                    class="w-full px-3.5 py-2 rounded-xl bg-white border border-slate-300 text-xs font-bold text-slate-700">

                <option value="">
                    Todas las Prioridades
                </option>

            </select>

        </div>


        <button onclick="resetFiltros()"
                class="p-2 rounded-xl bg-white hover:bg-slate-100 text-slate-600 border border-slate-300">

            <span class="material-symbols-outlined text-lg">

                restart_alt

            </span>

        </button>

    </div>

</div>


<!-- =========================================================
     KPIS
     ========================================================= -->

<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">


    <!-- TOTAL -->

    <div class="bg-white rounded-3xl p-6 border border-slate-200 shadow-lg flex items-center justify-between">

        <div>

            <span class="text-[11px] font-extrabold uppercase tracking-wider text-slate-400">

                Total Solicitudes

            </span>

            <h3 id="kpiTotal"
                class="text-3xl font-black text-slate-900 mt-1">

                <%= totalTickets != null ? totalTickets : 0 %>

            </h3>

        </div>

        <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-emerald-400 to-sena-600 text-white flex items-center justify-center">

            <span class="material-symbols-outlined text-2xl">

                confirmation_number

            </span>

        </div>

    </div>


    <!-- CATEGORIAS -->

    <div class="bg-white rounded-3xl p-6 border border-slate-200 shadow-lg flex items-center justify-between">

        <div>

            <span class="text-[11px] font-extrabold uppercase tracking-wider text-slate-400">

                Categorías

            </span>

            <h3 id="kpiCategorias"
                class="text-3xl font-black text-slate-900 mt-1">

                0

            </h3>

        </div>

        <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-sky-400 to-sky-600 text-white flex items-center justify-center">

            <span class="material-symbols-outlined text-2xl">

                folder_open

            </span>

        </div>

    </div>


    <!-- PRIORIDADES -->

    <div class="bg-white rounded-3xl p-6 border border-slate-200 shadow-lg flex items-center justify-between">

        <div>

            <span class="text-[11px] font-extrabold uppercase tracking-wider text-slate-400">

                Prioridades

            </span>

            <h3 id="kpiPrioridades"
                class="text-3xl font-black text-slate-900 mt-1">

                0

            </h3>

        </div>

        <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-amber-400 to-amber-600 text-white flex items-center justify-center">

            <span class="material-symbols-outlined text-2xl">

                flag

            </span>

        </div>

    </div>


    <!-- SLA -->

    <div class="bg-white rounded-3xl p-6 border border-slate-200 shadow-lg flex items-center justify-between">

        <div>

            <span class="text-[11px] font-extrabold uppercase tracking-wider text-slate-400">

                SLA Vencidos

            </span>

            <h3 class="text-3xl font-black text-red-600 mt-1">

                <%= slasVencidos != null ? slasVencidos : 0 %>

            </h3>

        </div>

        <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-red-400 to-red-600 text-white flex items-center justify-center">

            <span class="material-symbols-outlined text-2xl">

                timer_off

            </span>

        </div>

    </div>

</div>


<!-- =========================================================
     GRAFICAS
     ========================================================= -->

<div class="grid grid-cols-1 lg:grid-cols-2 gap-8">


    <!-- ESTADO -->

    <div class="bg-white rounded-3xl p-6 border-t-8 border-t-[#1d590f] border-x border-b border-slate-200 shadow-xl">

        <div class="flex items-center justify-between pb-4 mb-4 border-b">

            <div>

                <h3 class="text-base font-extrabold text-slate-900">

                    Estado de Solicitudes

                </h3>

                <p class="text-xs font-semibold text-slate-400">

                    Porcentaje de tickets por etapa

                </p>

            </div>

            <span class="text-[10px] font-extrabold px-3 py-1 rounded-full bg-emerald-100 text-emerald-800">

                Porcentaje

            </span>

        </div>

        <div class="relative h-64 w-full">

            <canvas id="graficaEstado"></canvas>

        </div>

    </div>


    <!-- PRIORIDAD -->

    <div class="bg-white rounded-3xl p-6 border-t-8 border-t-amber-500 border-x border-b border-slate-200 shadow-xl">

        <div class="flex items-center justify-between pb-4 mb-4 border-b">

            <div>

                <h3 class="text-base font-extrabold text-slate-900">

                    Tickets por Prioridad

                </h3>

                <p class="text-xs font-semibold text-slate-400">

                    Distribución de niveles de urgencia

                </p>

            </div>

            <span class="text-[10px] font-extrabold px-3 py-1 rounded-full bg-amber-100 text-amber-800">

                Porcentaje

            </span>

        </div>

        <div class="relative h-64 w-full">

            <canvas id="graficaPrioridad"></canvas>

        </div>

    </div>


    <!-- CATEGORIA -->

    <div class="bg-white rounded-3xl p-6 border-t-8 border-t-sky-600 border-x border-b border-slate-200 shadow-xl lg:col-span-2">

        <div class="flex items-center justify-between pb-4 mb-4 border-b">

            <div>

                <h3 class="text-base font-extrabold text-slate-900">

                    Distribución por Categorías

                </h3>

                <p class="text-xs font-semibold text-slate-400">

                    Atenciones clasificadas en el sistema

                </p>

            </div>

            <span class="text-[10px] font-extrabold px-3 py-1 rounded-full bg-sky-100 text-sky-800">

                Porcentaje

            </span>

        </div>

        <div class="relative h-72 w-full">

            <canvas id="graficaCategoria"></canvas>

        </div>

    </div>


    <!-- =====================================================
         AGENTES
         ===================================================== -->

    <div class="bg-white rounded-3xl p-6 border-t-8 border-t-purple-600 border-x border-b border-slate-200 shadow-xl lg:col-span-2">

        <div class="flex items-center justify-between pb-4 mb-4 border-b">

            <div class="flex items-center gap-3">

                <div class="w-11 h-11 rounded-2xl bg-purple-100 text-purple-600 flex items-center justify-center">

                    <span class="material-symbols-outlined text-2xl">

                        support_agent

                    </span>

                </div>

                <div>

                    <h3 class="text-base font-extrabold text-slate-900">

                        Tickets por Agente

                    </h3>

                    <p class="text-xs font-semibold text-slate-400">

                        Cantidad de tickets asignados a cada agente

                    </p>

                </div>

            </div>

            <span class="text-[10px] font-extrabold px-3 py-1 rounded-full bg-purple-100 text-purple-800">

                Agentes

            </span>

        </div>


        <div class="relative h-80 w-full">

            <canvas id="graficaAgente"></canvas>

        </div>

    </div>

</div>


<!-- =========================================================
     TABLA AGENTES
     ========================================================= -->

<div class="bg-white rounded-3xl border border-slate-200 shadow-xl overflow-hidden">

    <div class="p-6 border-b border-slate-100">

        <div class="flex items-center gap-3">

            <div class="w-11 h-11 rounded-2xl bg-purple-100 text-purple-600 flex items-center justify-center">

                <span class="material-symbols-outlined text-2xl">

                    groups

                </span>

            </div>

            <div>

                <h3 class="text-base font-extrabold text-slate-900">

                    Resumen por Agente

                </h3>

                <p class="text-xs font-semibold text-slate-400">

                    Tickets gestionados por cada agente del sistema.

                </p>

            </div>

        </div>

    </div>


    <div class="overflow-x-auto">

        <table class="w-full text-sm">

            <thead class="bg-slate-50 border-b border-slate-200">

                <tr>

                    <th class="px-6 py-4 text-left text-[11px] uppercase tracking-wider font-extrabold text-slate-500">
                        #
                    </th>

                    <th class="px-6 py-4 text-left text-[11px] uppercase tracking-wider font-extrabold text-slate-500">
                        Agente
                    </th>

                    <th class="px-6 py-4 text-center text-[11px] uppercase tracking-wider font-extrabold text-slate-500">
                        Tickets
                    </th>

                </tr>

            </thead>


            <tbody>

                <%

                if (ticketsAgente != null && !ticketsAgente.isEmpty()) {

                    int contador = 1;

                    for (Map<String, Object> agente : ticketsAgente) {


                        // ==========================================
                        // OBTENER NOMBRE
                        // ==========================================

                        Object nombreObj = agente.get("nombre");

                        if (nombreObj == null) {
                            nombreObj = agente.get("nombre_agente");
                        }

                        if (nombreObj == null) {
                            nombreObj = agente.get("agente");
                        }

                        String nombre =
                                nombreObj != null
                                ? String.valueOf(nombreObj)
                                : "Sin nombre";


                        // ==========================================
                        // OBTENER CANTIDAD
                        // ==========================================

                        Object cantidadObj =
                                agente.get("cantidad");

                        if (cantidadObj == null) {
                            cantidadObj =
                                    agente.get("total");
                        }

                        int cantidad = 0;

                        if (cantidadObj != null) {

                            try {

                                cantidad =
                                        Integer.parseInt(
                                                String.valueOf(
                                                        cantidadObj
                                                )
                                        );

                            } catch (Exception e) {

                                cantidad = 0;

                            }

                        }


                        // ==========================================
                        // INICIAL DEL AGENTE
                        // ==========================================

                        String inicial =
                                nombre.trim().isEmpty()
                                ? "?"
                                : nombre.trim()
                                        .substring(0, 1)
                                        .toUpperCase();

                %>


                <tr class="border-b border-slate-100 hover:bg-slate-50 transition">


                    <td class="px-6 py-4 font-bold text-slate-400">

                        <%= contador %>

                    </td>


                    <td class="px-6 py-4">

                        <div class="flex items-center gap-3">

                            <div class="w-10 h-10 rounded-xl bg-purple-100 text-purple-700 flex items-center justify-center font-black">

                                <%= inicial %>

                            </div>

                            <span class="font-bold text-slate-800">

                                <%= nombre %>

                            </span>

                        </div>

                    </td>


                    <td class="px-6 py-4 text-center">

                        <span class="inline-flex items-center justify-center min-w-10 px-3 py-1.5 rounded-xl bg-purple-100 text-purple-700 font-black">

                            <%= cantidad %>

                        </span>

                    </td>

                </tr>


                <%

                        contador++;

                    }

                } else {

                %>


                <tr>

                    <td colspan="3"
                        class="px-6 py-10 text-center">

                        <div class="flex flex-col items-center gap-2">

                            <span class="material-symbols-outlined text-4xl text-slate-300">

                                person_off

                            </span>

                            <span class="text-slate-400 font-semibold">

                                No hay agentes con tickets registrados.

                            </span>

                        </div>

                    </td>

                </tr>


                <%

                }

                %>

            </tbody>

        </table>

    </div>

</div>


</main>


<!-- =========================================================
     FOOTER
     ========================================================= -->

<footer class="mt-auto bg-white border-t border-slate-200 py-4 text-center">

    <p class="text-xs font-semibold text-slate-400">

        SENA CIMM — Análisis y Desarrollo de Software (ADSO)

    </p>

</footer>


<!-- =========================================================
     JAVASCRIPT
     ========================================================= -->

<script>

    Chart.register(ChartDataLabels);


    // =====================================================
    // DATOS ESTADO
    // =====================================================

    const rawEstado = [

        <%

        for (int i = 0; i < ticketsEstado.size(); i++) {

            Map<String, Object> d =
                    ticketsEstado.get(i);

            String nombre =
                    String.valueOf(
                            d.get("nombre")
                    ).replace("'", "\\'");

        %>

        {
            nombre: '<%= nombre %>',
            cantidad: <%= d.get("cantidad") %>
        }

        <%= (i < ticketsEstado.size() - 1) ? "," : "" %>

        <%

        }

        %>

    ];


    // =====================================================
    // DATOS PRIORIDAD
    // =====================================================

    const rawPrioridad = [

        <%

        for (int i = 0; i < ticketsPrioridad.size(); i++) {

            Map<String, Object> d =
                    ticketsPrioridad.get(i);

            String nombre =
                    String.valueOf(
                            d.get("nombre")
                    ).replace("'", "\\'");

        %>

        {
            nombre: '<%= nombre %>',
            cantidad: <%= d.get("cantidad") %>
        }

        <%= (i < ticketsPrioridad.size() - 1) ? "," : "" %>

        <%

        }

        %>

    ];


    // =====================================================
    // DATOS CATEGORIA
    // =====================================================

    const rawCategoria = [

        <%

        for (int i = 0; i < ticketsCategoria.size(); i++) {

            Map<String, Object> d =
                    ticketsCategoria.get(i);

            String nombre =
                    String.valueOf(
                            d.get("nombre")
                    ).replace("'", "\\'");

        %>

        {
            nombre: '<%= nombre %>',
            cantidad: <%= d.get("cantidad") %>
        }

        <%= (i < ticketsCategoria.size() - 1) ? "," : "" %>

        <%

        }

        %>

    ];


    // =====================================================
    // DATOS AGENTE
    // =====================================================

    const rawAgente = [

        <%

        for (int i = 0; i < ticketsAgente.size(); i++) {

            Map<String, Object> d =
                    ticketsAgente.get(i);


            Object nombreObj =
                    d.get("nombre");

            if (nombreObj == null) {
                nombreObj = d.get("nombre_agente");
            }

            if (nombreObj == null) {
                nombreObj = d.get("agente");
            }


            Object cantidadObj =
                    d.get("cantidad");

            if (cantidadObj == null) {
                cantidadObj = d.get("total");
            }


            String nombre =
                    nombreObj != null
                    ? String.valueOf(nombreObj)
                            .replace("'", "\\'")
                    : "Sin nombre";


            String cantidad =
                    cantidadObj != null
                    ? String.valueOf(cantidadObj)
                    : "0";

        %>

        {
            nombre: '<%= nombre %>',
            cantidad: <%= cantidad %>
        }

        <%= (i < ticketsAgente.size() - 1) ? "," : "" %>

        <%

        }

        %>

    ];


    let chartE;
    let chartP;
    let chartC;
    let chartA;


    // =====================================================
    // CARGAR
    // =====================================================

    document.addEventListener(
        'DOMContentLoaded',
        function () {

            poblarFiltros();

            crearGraficas();

            actualizarKPIs(
                rawCategoria,
                rawPrioridad
            );

        }
    );


    // =====================================================
    // FILTROS
    // =====================================================

    function poblarFiltros() {

        const selC =
                document.getElementById(
                    'filtroCategoria'
                );

        const selP =
                document.getElementById(
                    'filtroPrioridad'
                );


        rawCategoria.forEach(
            function (item) {

                selC.add(
                    new Option(
                        item.nombre,
                        item.nombre
                    )
                );

            }
        );


        rawPrioridad.forEach(
            function (item) {

                selP.add(
                    new Option(
                        item.nombre,
                        item.nombre
                    )
                );

            }
        );

    }


    // =====================================================
    // GRAFICAS
    // =====================================================

    function crearGraficas() {


        Chart.defaults.color =
                '#475569';

        Chart.defaults.font.family =
                'Plus Jakarta Sans';


        // =================================================
        // ESTADO
        // =================================================

        chartE = new Chart(

            document.getElementById(
                'graficaEstado'
            ),

            {

                type: 'doughnut',

                data: {

                    labels:
                            rawEstado.map(
                                d => d.nombre
                            ),

                    datasets: [{

                        data:
                                rawEstado.map(
                                    d => d.cantidad
                                ),

                        backgroundColor: [

                            '#1d590f',
                            '#0284c7',
                            '#f59e0b',
                            '#ef4444',
                            '#64748b'

                        ],

                        borderWidth: 3,

                        borderColor: '#ffffff'

                    }]

                },

                options: {

                    responsive: true,

                    maintainAspectRatio: false,

                    cutout: '65%',

                    plugins: {

                        legend: {

                            position: 'right'

                        },

                        datalabels: {

                            color: '#ffffff',

                            font: {

                                weight: '800'

                            },

                            formatter:
                                    function (
                                        value,
                                        ctx
                                    ) {

                                const sum =
                                        ctx.dataset.data
                                        .reduce(
                                            (a, b) =>
                                                a + b,
                                            0
                                        );

                                if (sum === 0) {
                                    return '';
                                }

                                return (
                                    value * 100 / sum
                                ).toFixed(1) + '%';

                            }

                        }

                    }

                }

            }

        );


        // =================================================
        // PRIORIDAD
        // =================================================

        chartP = new Chart(

            document.getElementById(
                'graficaPrioridad'
            ),

            {

                type: 'bar',

                data: {

                    labels:
                            rawPrioridad.map(
                                d => d.nombre
                            ),

                    datasets: [{

                        data:
                                rawPrioridad.map(
                                    d => d.cantidad
                                ),

                        backgroundColor: [

                            '#f43f5e',
                            '#fb923c',
                            '#facc15',
                            '#38bdf8'

                        ],

                        borderRadius: 8

                    }]

                },

                options: {

                    responsive: true,

                    maintainAspectRatio: false,

                    plugins: {

                        legend: {
                            display: false
                        },

                        datalabels: {

                            anchor: 'end',

                            align: 'top',

                            color: '#0f172a',

                            font: {

                                weight: '800'

                            },

                            formatter:
                                    function (
                                        value,
                                        ctx
                                    ) {

                                const sum =
                                        ctx.dataset.data
                                        .reduce(
                                            (a, b) =>
                                                a + b,
                                            0
                                        );

                                if (sum === 0) {
                                    return '';
                                }

                                return (
                                    value * 100 / sum
                                ).toFixed(1) + '%';

                            }

                        }

                    },

                    scales: {

                        y: {

                            beginAtZero: true,

                            ticks: {

                                stepSize: 1

                            }

                        }

                    }

                }

            }

        );


        // =================================================
        // CATEGORIA
        // =================================================

        chartC = new Chart(

            document.getElementById(
                'graficaCategoria'
            ),

            {

                type: 'bar',

                data: {

                    labels:
                            rawCategoria.map(
                                d => d.nombre
                            ),

                    datasets: [{

                        data:
                                rawCategoria.map(
                                    d => d.cantidad
                                ),

                        backgroundColor:
                                '#0284c7',

                        borderRadius: 8

                    }]

                },

                options: {

                    responsive: true,

                    maintainAspectRatio: false,

                    plugins: {

                        legend: {

                            display: false

                        },

                        datalabels: {

                            anchor: 'end',

                            align: 'top',

                            color: '#0f172a',

                            font: {

                                weight: '800'

                            },

                            formatter:
                                    function (
                                        value,
                                        ctx
                                    ) {

                                const sum =
                                        ctx.dataset.data
                                        .reduce(
                                            (a, b) =>
                                                a + b,
                                            0
                                        );

                                if (sum === 0) {
                                    return '';
                                }

                                return (
                                    value * 100 / sum
                                ).toFixed(1) + '%';

                            }

                        }

                    },

                    scales: {

                        y: {

                            beginAtZero: true,

                            ticks: {

                                stepSize: 1

                            }

                        }

                    }

                }

            }

        );


        // =================================================
        // AGENTES
        // =================================================

        chartA = new Chart(

            document.getElementById(
                'graficaAgente'
            ),

            {

                type: 'bar',

                data: {

                    labels:
                            rawAgente.map(
                                d => d.nombre
                            ),

                    datasets: [{

                        label:
                                'Tickets asignados',

                        data:
                                rawAgente.map(
                                    d => d.cantidad
                                ),

                        backgroundColor:
                                '#9333ea',

                        borderRadius: 10

                    }]

                },

                options: {

                    responsive: true,

                    maintainAspectRatio: false,

                    plugins: {

                        legend: {

                            display: false

                        },

                        datalabels: {

                            anchor: 'end',

                            align: 'top',

                            color: '#581c87',

                            font: {

                                weight: '800',

                                size: 12

                            }

                        }

                    },

                    scales: {

                        y: {

                            beginAtZero: true,

                            ticks: {

                                stepSize: 1

                            }

                        },

                        x: {

                            ticks: {

                                font: {

                                    weight: '700'

                                }

                            }

                        }

                    }

                }

            }

        );

    }


    // =====================================================
    // FILTROS
    // =====================================================

    function aplicarFiltros() {

        const cat =
                document.getElementById(
                    'filtroCategoria'
                ).value;

        const prio =
                document.getElementById(
                    'filtroPrioridad'
                ).value;


        const cFiltrada =
                cat
                ? rawCategoria.filter(
                    d => d.nombre === cat
                )
                : rawCategoria;


        const pFiltrada =
                prio
                ? rawPrioridad.filter(
                    d => d.nombre === prio
                )
                : rawPrioridad;


        chartC.data.labels =
                cFiltrada.map(
                    d => d.nombre
                );

        chartC.data.datasets[0].data =
                cFiltrada.map(
                    d => d.cantidad
                );

        chartC.update();


        chartP.data.labels =
                pFiltrada.map(
                    d => d.nombre
                );

        chartP.data.datasets[0].data =
                pFiltrada.map(
                    d => d.cantidad
                );

        chartP.update();


        actualizarKPIs(
            cFiltrada,
            pFiltrada
        );

    }


    // =====================================================
    // RESET
    // =====================================================

    function resetFiltros() {

        document.getElementById(
            'filtroCategoria'
        ).value = '';

        document.getElementById(
            'filtroPrioridad'
        ).value = '';

        aplicarFiltros();

    }


    // =====================================================
    // KPIS
    // =====================================================

    function actualizarKPIs(
        cats,
        prios
    ) {

        document.getElementById(
            'kpiCategorias'
        ).textContent =
                cats.length;


        document.getElementById(
            'kpiPrioridades'
        ).textContent =
                prios.length;

    }

</script>


</body>

</html>