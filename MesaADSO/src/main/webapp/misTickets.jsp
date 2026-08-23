<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="co.edu.sena.mesaayuda.dto.TicketDTO"%>
<%@page import="co.edu.sena.mesaayuda.modelo.Usuario"%>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }

    List<TicketDTO> tickets =
            (List<TicketDTO>) request.getAttribute("tickets");

    if (tickets == null) {
        tickets = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Mis Tickets - Mesa de Ayuda SENA</title>

    <!-- Tailwind -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Google Fonts -->
    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
          rel="stylesheet">

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>

        tailwind.config = {
            theme: {
                extend: {

                    colors: {

                        sena: {
                            DEFAULT: '#39A900',
                            dark: '#2E8B00',
                            light: '#E8F5E9',
                            bg: '#F4FBF7'
                        }

                    },

                    fontFamily: {
                        sans: ['Plus Jakarta Sans', 'sans-serif']
                    }

                }
            }
        };

    </script>

    <style>

        .custom-scrollbar::-webkit-scrollbar {
            height: 6px;
        }

        .custom-scrollbar::-webkit-scrollbar-track {
            background: #e8f5e9;
        }

        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: #a5d6a7;
            border-radius: 4px;
        }

    </style>

</head>


<body class="bg-sena-bg text-slate-800 min-h-screen flex flex-col font-sans antialiased">


<!-- ========================================================= -->
<!-- HEADER -->
<!-- ========================================================= -->

<header class="bg-sena text-white shadow-md relative overflow-hidden">

    <div class="absolute -right-10 -bottom-10 w-48 h-48 bg-white/10 rounded-full blur-xl pointer-events-none"></div>

    <div class="absolute right-40 -top-10 w-32 h-32 bg-white/10 rounded-full blur-lg pointer-events-none"></div>


    <div class="max-w-7xl mx-auto px-4 sm:px-6 py-5 relative z-10">

        <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">


            <div>

                <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-white/20 text-xs font-semibold tracking-wide uppercase">

                    Mesa de Ayuda SENA

                </span>


                <h1 class="text-2xl sm:text-3xl font-extrabold tracking-tight mt-1">

                    Mis Tickets

                </h1>


                <p class="text-xs sm:text-sm text-green-100 font-light mt-0.5">

                    Consulta y gestiona en tiempo real el estado de tus solicitudes

                </p>

            </div>


            <!-- USUARIO -->

            <div class="flex items-center gap-3 bg-white/10 backdrop-blur-md p-2.5 px-4 rounded-xl border border-white/20 self-start md:self-auto">

                <div class="text-right">

                    <p class="font-bold text-sm leading-tight text-white">

                        <%= usuario.getnombre_usuario() != null
                                ? usuario.getnombre_usuario()
                                : "Usuario" %>

                    </p>

                    <p class="text-[11px] text-green-100 font-medium">

                        Solicitante

                    </p>

                </div>


                <div class="w-9 h-9 bg-white text-sena rounded-lg font-black flex items-center justify-center shadow-sm text-base">

                    <%= usuario.getnombre_usuario() != null
                            && !usuario.getnombre_usuario().isEmpty()
                            ? usuario.getnombre_usuario()
                                    .substring(0, 1)
                                    .toUpperCase()
                            : "U" %>

                </div>

            </div>

        </div>

    </div>

</header>


<!-- ========================================================= -->
<!-- CONTENIDO -->
<!-- ========================================================= -->

<main class="max-w-7xl mx-auto px-4 sm:px-6 py-6 w-full flex-grow">


    <!-- BARRA DE ACCIONES -->

    <div class="flex flex-col sm:flex-row justify-between items-stretch sm:items-center gap-3 mb-6">


        <!-- VOLVER -->

        <a href="<%= request.getContextPath() %>/solicitante/misTickets"

           class="inline-flex items-center justify-center gap-2 px-4 py-2 bg-white text-emerald-900 border border-green-200 rounded-xl text-sm font-semibold hover:bg-green-50 shadow-sm transition">

            <svg class="w-4 h-4 text-emerald-700"
                 fill="none"
                 stroke="currentColor"
                 viewBox="0 0 24 24">

                <path stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M10 19l-7-7m0 0l7-7m-7 7h18"/>

            </svg>

            Volver a mis tickets

        </a>


        <!-- CREAR -->

        <a href="<%= request.getContextPath() %>/crearTicket"

           class="inline-flex items-center justify-center gap-2 px-5 py-2 bg-sena hover:bg-sena-dark text-white rounded-xl text-sm font-bold shadow-sm hover:shadow-md transition">

            <svg class="w-4 h-4"
                 fill="none"
                 stroke="currentColor"
                 viewBox="0 0 24 24">

                <path stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 4v16m8-8H4"/>

            </svg>

            Crear nuevo ticket

        </a>

    </div>


    <!-- ===================================================== -->
    <!-- CONTENEDOR -->
    <!-- ===================================================== -->

    <div class="bg-white rounded-2xl shadow-sm border border-green-100 overflow-hidden">


        <!-- HEADER -->

        <div class="px-6 py-4 bg-white border-b border-green-100 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">

            <div>

                <h2 class="text-lg font-bold text-gray-800">

                    Historial de solicitudes

                </h2>

                <p class="text-xs text-gray-500">

                    Listado ordenado con el detalle y seguimiento de tus requerimientos.

                </p>

            </div>


            <div class="inline-flex items-center gap-2 bg-sena-light border border-green-200 text-sena-dark px-3 py-1.5 rounded-xl text-xs font-bold">

                <span class="w-2 h-2 rounded-full bg-sena animate-pulse"></span>

                Total solicitudes: <%= tickets.size() %>

            </div>

        </div>


        <!-- ================================================= -->
        <!-- SIN TICKETS -->
        <!-- ================================================= -->

        <% if (tickets.isEmpty()) { %>


            <div class="px-6 py-16 text-center">

                <div class="w-16 h-16 mx-auto rounded-full bg-sena-light border border-green-200 flex items-center justify-center text-sena">

                    <svg class="w-8 h-8"
                         fill="none"
                         stroke="currentColor"
                         viewBox="0 0 24 24">

                        <path stroke-linecap="round"
                              stroke-linejoin="round"
                              stroke-width="1.5"
                              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>

                    </svg>

                </div>


                <h3 class="mt-4 text-lg font-bold text-gray-800">

                    No tienes tickets registrados

                </h3>


                <p class="text-gray-500 text-xs max-w-xs mx-auto mt-1">

                    Aún no has registrado solicitudes de ayuda.

                </p>


                <a href="<%= request.getContextPath() %>/crearTicket"

                   class="inline-flex items-center gap-2 mt-5 px-5 py-2.5 bg-sena hover:bg-sena-dark text-white text-xs font-bold rounded-xl shadow-md transition">

                    Crear mi primer ticket

                </a>

            </div>


        <% } else { %>


        <!-- ================================================= -->
        <!-- TABLA -->
        <!-- ================================================= -->

        <div class="overflow-x-auto custom-scrollbar">

            <table class="w-full text-left border-collapse">


                <thead>

                    <tr class="bg-slate-900 text-white text-[11px] font-bold uppercase tracking-wider">

                        <th class="px-5 py-3.5">
                            ID
                        </th>

                        <th class="px-5 py-3.5">
                            Asunto / Descripción
                        </th>

                        <th class="px-5 py-3.5">
                            Categoría
                        </th>

                        <th class="px-5 py-3.5 text-center">
                            Prioridad
                        </th>

                        <th class="px-5 py-3.5 text-center">
                            Estado
                        </th>

                        <th class="px-5 py-3.5">
                            Fecha Creación
                        </th>

                        <th class="px-5 py-3.5">
                            Agente Asignado
                        </th>

                        <th class="px-5 py-3.5 text-center">
                            Acción
                        </th>

                    </tr>

                </thead>


                <tbody class="divide-y divide-green-50 text-xs">


                <% for (TicketDTO ticket : tickets) {

                    String estado = ticket.getEstado();

                    String estadoNormalizado =
                            estado != null
                            ? estado.trim().toUpperCase()
                            : "";

                    String estadoComparacion =
                            estadoNormalizado.replace(" ", "_");


                    String claseEstado =
                            "bg-gray-50 text-gray-600 border-gray-200";


                    switch (estadoComparacion) {

                        case "NUEVO":

                            claseEstado =
                                    "bg-blue-50 text-blue-700 border-blue-200";

                            break;


                        case "ASIGNADO":

                            claseEstado =
                                    "bg-purple-50 text-purple-700 border-purple-200";

                            break;


                        case "EN_PROCESO":

                            claseEstado =
                                    "bg-amber-50 text-amber-700 border-amber-200";

                            break;


                        case "RESUELTO":

                            claseEstado =
                                    "bg-emerald-100 text-emerald-900 border-green-300";

                            break;


                        case "CERRADO":

                            claseEstado =
                                    "bg-gray-100 text-gray-600 border-gray-300";

                            break;


                        case "CANCELADO":

                            claseEstado =
                                    "bg-red-50 text-red-700 border-red-200";

                            break;

                    }


                    String prioridad = ticket.getPrioridad();

                    String clasePrioridad =
                            "bg-gray-50 text-gray-600 border-gray-200";


                    if (prioridad != null &&
                        !prioridad.trim().isEmpty()) {

                        String p =
                                prioridad.trim().toUpperCase();


                        if (p.contains("ALTA") ||
                            p.contains("CRITICA") ||
                            p.contains("CRÍTICA")) {

                            clasePrioridad =
                                    "bg-red-50 text-red-700 border-red-200";

                        }

                        else if (p.equals("MEDIA")) {

                            clasePrioridad =
                                    "bg-amber-50 text-amber-700 border-amber-200";

                        }

                        else if (p.equals("BAJA")) {

                            clasePrioridad =
                                    "bg-emerald-50 text-emerald-800 border-emerald-200";

                        }

                    }


                    String categoria = ticket.getCategoria();

                    String agente = ticket.getAgente();


                    String tituloTicket =
                            ticket.getTitulo() != null
                            ? ticket.getTitulo()
                            : "Sin título";


                    String tituloSeguro =
                            tituloTicket
                            .replace("&", "&amp;")
                            .replace("\"", "&quot;")
                            .replace("<", "&lt;")
                            .replace(">", "&gt;");

                %>


                <!-- ================================================= -->
                <!-- FILA -->
                <!-- ================================================= -->

                <tr class="hover:bg-sena-light/40 transition-colors">


                    <!-- ID -->

                    <td class="px-5 py-3.5 whitespace-nowrap">

                        <span class="px-2.5 py-1 bg-green-100 text-emerald-900 rounded-lg font-extrabold text-[11px] border border-green-200">

                            #<%= ticket.getId_ticket() %>

                        </span>

                    </td>


                    <!-- ASUNTO -->

                    <td class="px-5 py-3.5 min-w-[220px] max-w-[280px]">

                        <p class="font-bold text-gray-900 text-sm leading-snug truncate">

                            <%= tituloTicket %>

                        </p>


                        <p class="text-[11px] text-gray-500 truncate mt-0.5">

                            <%= ticket.getDescripcion() != null
                                    ? ticket.getDescripcion()
                                    : "Sin descripción" %>

                        </p>

                    </td>


                    <!-- CATEGORÍA -->

                    <td class="px-5 py-3.5 whitespace-nowrap">

                        <% if (categoria != null &&
                               !categoria.trim().isEmpty()) { %>

                            <span class="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full bg-emerald-50 text-emerald-800 border border-emerald-200 text-[11px] font-semibold">

                                <span class="w-1.5 h-1.5 rounded-full bg-sena"></span>

                                <%= categoria %>

                            </span>

                        <% } else { %>

                            <span class="text-gray-400 italic">

                                Sin categoría

                            </span>

                        <% } %>

                    </td>


                    <!-- PRIORIDAD -->

                    <td class="px-5 py-3.5 whitespace-nowrap text-center">

                        <% if (prioridad != null &&
                               !prioridad.trim().isEmpty()) { %>

                            <span class="px-2.5 py-0.5 rounded-full text-[11px] font-bold border <%= clasePrioridad %>">

                                <%= prioridad %>

                            </span>

                        <% } else { %>

                            <span class="text-gray-400 italic">

                                N/A

                            </span>

                        <% } %>

                    </td>


                    <!-- ESTADO -->

                    <td class="px-5 py-3.5 whitespace-nowrap text-center">

                        <% if (!estadoNormalizado.isEmpty()) { %>

                            <span class="px-2.5 py-0.5 rounded-full text-[11px] font-bold border <%= claseEstado %>">

                                <%= estado %>

                            </span>

                        <% } else { %>

                            <span class="text-gray-400 italic">

                                Sin estado

                            </span>

                        <% } %>

                    </td>


                    <!-- FECHA -->

                    <td class="px-5 py-3.5 whitespace-nowrap text-gray-600 font-medium">

                        <%= ticket.getFecha_creacion() != null
                                ? ticket.getFecha_creacion()
                                : "Sin fecha" %>

                    </td>


                    <!-- AGENTE -->

                    <td class="px-5 py-3.5 whitespace-nowrap">

                        <% if (agente != null &&
                               !agente.trim().isEmpty()) { %>

                            <div class="flex items-center gap-2">

                                <div class="w-6 h-6 rounded-full bg-sena-light text-sena border border-green-300 flex items-center justify-center font-bold text-[10px]">

                                    <%= agente.substring(0, 1).toUpperCase() %>

                                </div>


                                <span class="font-semibold text-gray-700">

                                    <%= agente %>

                                </span>

                            </div>

                        <% } else { %>

                            <span class="text-gray-400 italic">

                                Sin asignar

                            </span>

                        <% } %>

                    </td>


                    <!-- ================================================= -->
                    <!-- ACCIONES -->
                    <!-- ================================================= -->

                    <td class="px-5 py-3.5 whitespace-nowrap">

                        <div class="flex flex-col items-center gap-2">


                            <!-- VER DETALLE -->

                            <a href="<%= request.getContextPath() %>/detalleTicket?id=<%= ticket.getId_ticket() %>"

                               class="inline-flex items-center justify-center gap-1 px-3 py-1.5 bg-sena hover:bg-sena-dark text-white rounded-lg text-[11px] font-bold shadow-sm transition">

                                Ver detalle

                                <svg class="w-3 h-3"
                                     fill="none"
                                     stroke="currentColor"
                                     viewBox="0 0 24 24">

                                    <path stroke-linecap="round"
                                          stroke-linejoin="round"
                                          stroke-width="2"
                                          d="M9 5l7 7-7 7"/>

                                </svg>

                            </a>


                            <!-- ================================================= -->
                            <!-- CANCELAR -->
                            <!-- ================================================= -->

                            <%
                                /*
                                 * El solicitante puede cancelar:
                                 *
                                 * NUEVO
                                 * ASIGNADO
                                 * EN_PROCESO
                                 * RESUELTO
                                 *
                                 * No puede cancelar:
                                 *
                                 * CERRADO
                                 * CANCELADO
                                 */

                                if (!"CERRADO".equals(estadoComparacion)
                                        && !"CANCELADO".equals(estadoComparacion)) {
                            %>


                                <form action="<%= request.getContextPath() %>/cancelarTicket"

                                      method="post"

                                      class="formCancelar"

                                      data-ticket-id="<%= ticket.getId_ticket() %>"

                                      data-ticket-titulo="<%= tituloSeguro %>">


                                    <input type="hidden"
                                           name="id"
                                           value="<%= ticket.getId_ticket() %>">


                                    <button type="submit"

                                            class="inline-flex items-center justify-center gap-1 px-3 py-1.5 bg-red-600 hover:bg-red-700 text-white rounded-lg text-[11px] font-bold shadow-sm transition">

                                        <svg class="w-3 h-3"
                                             fill="none"
                                             stroke="currentColor"
                                             viewBox="0 0 24 24">

                                            <path stroke-linecap="round"
                                                  stroke-linejoin="round"
                                                  stroke-width="2"
                                                  d="M6 18L18 6M6 6l12 12"/>

                                        </svg>

                                        Cancelar ticket

                                    </button>

                                </form>


                            <% } %>


                            <!-- ================================================= -->
                            <!-- REABRIR -->
                            <!-- ================================================= -->

                            <%
                                /*
                                 * REGLA DEL SISTEMA:
                                 *
                                 * RESUELTO -> CERRADO
                                 *
                                 * CERRADO -> EN_PROCESO
                                 *
                                 * Por lo tanto:
                                 *
                                 * SOLO aparece el botón cuando
                                 * el ticket está CERRADO.
                                 */

                                if ("CERRADO".equals(estadoComparacion)) {
                            %>


                                <form action="<%= request.getContextPath() %>/reabrirTicket"

                                      method="post"

                                      class="formReabrir"

                                      data-ticket-id="<%= ticket.getId_ticket() %>"

                                      data-ticket-titulo="<%= tituloSeguro %>">


                                    <input type="hidden"
                                           name="id"
                                           value="<%= ticket.getId_ticket() %>">


                                    <button type="submit"

                                            class="inline-flex items-center justify-center gap-1 px-3 py-1.5 bg-amber-500 hover:bg-amber-600 text-white rounded-lg text-[11px] font-bold shadow-sm transition">

                                        <svg class="w-3 h-3"
                                             fill="none"
                                             stroke="currentColor"
                                             viewBox="0 0 24 24">

                                            <path stroke-linecap="round"
                                                  stroke-linejoin="round"
                                                  stroke-width="2"
                                                  d="M4 4v6h6M20 20v-6h-6M5.5 9A7 7 0 0118 6.5L20 9M18.5 15A7 7 0 016 17.5L4 15"/>

                                        </svg>

                                        Reabrir ticket

                                    </button>

                                </form>


                            <% } %>


                        </div>

                    </td>

                </tr>


                <% } %>

                </tbody>

            </table>

        </div>

        <% } %>

    </div>

</main>


<!-- ========================================================= -->
<!-- FOOTER -->
<!-- ========================================================= -->

<footer class="max-w-7xl mx-auto px-6 py-4 w-full mt-auto border-t border-green-200/60">

    <p class="text-center text-xs text-gray-500 font-medium">

        SENA CIMM · Mesa de Ayuda ©

        <%= java.time.Year.now().getValue() %>

    </p>

</footer>


<!-- ========================================================= -->
<!-- JAVASCRIPT -->
<!-- ========================================================= -->

<script>

document.addEventListener("DOMContentLoaded", function () {


    /* =========================================================
       CANCELAR TICKET
       ========================================================= */

    const formulariosCancelar =
            document.querySelectorAll(".formCancelar");


    formulariosCancelar.forEach(function (formulario) {

        formulario.addEventListener("submit", function (event) {

            event.preventDefault();

            const id =
                    formulario.dataset.ticketId;

            const titulo =
                    formulario.dataset.ticketTitulo;


            Swal.fire({

                title: "¿Cancelar ticket?",

                html:

                    "<p class='text-gray-600 text-sm'>" +

                    "Vas a cancelar el ticket " +

                    "<strong>#" + id + "</strong>." +

                    "</p>" +

                    "<p class='text-gray-500 text-xs mt-2'>" +

                    titulo +

                    "</p>" +

                    "<p class='text-red-600 text-xs font-semibold mt-3'>" +

                    "El estado cambiará a CANCELADO." +

                    "</p>",

                icon: "warning",

                showCancelButton: true,

                confirmButtonText: "Sí, cancelar",

                cancelButtonText: "No, mantener ticket",

                confirmButtonColor: "#dc2626",

                cancelButtonColor: "#6b7280",

                reverseButtons: true,

                allowOutsideClick: false,

                customClass: {

                    popup:
                        "rounded-2xl shadow-2xl",

                    title:
                        "text-xl font-extrabold"

                }

            }).then(function (resultado) {

                if (!resultado.isConfirmed) {
                    return;
                }

                formulario.submit();

            });

        });

    });


    /* =========================================================
       REABRIR TICKET
       ========================================================= */

    const formulariosReabrir =
            document.querySelectorAll(".formReabrir");


    formulariosReabrir.forEach(function (formulario) {

        formulario.addEventListener("submit", function (event) {

            event.preventDefault();

            const id =
                    formulario.dataset.ticketId;

            const titulo =
                    formulario.dataset.ticketTitulo;


            Swal.fire({

                title: "¿Reabrir ticket?",

                html:

                    "<p class='text-gray-600 text-sm'>" +

                    "El ticket " +

                    "<strong>#" + id + "</strong> " +

                    "está cerrado y volverá a estado " +

                    "<strong>EN PROCESO</strong>." +

                    "</p>" +

                    "<p class='text-gray-500 text-xs mt-2'>" +

                    titulo +

                    "</p>" +

                    "<p class='text-amber-600 text-xs font-semibold mt-3'>" +

                    "El agente podrá continuar con la atención." +

                    "</p>",

                icon: "question",

                showCancelButton: true,

                confirmButtonText: "Sí, reabrir",

                cancelButtonText: "No, mantener cerrado",

                confirmButtonColor: "#f59e0b",

                cancelButtonColor: "#6b7280",

                reverseButtons: true,

                allowOutsideClick: false,

                customClass: {

                    popup:
                        "rounded-2xl shadow-2xl",

                    title:
                        "text-xl font-extrabold"

                }

            }).then(function (resultado) {

                if (!resultado.isConfirmed) {
                    return;
                }

                formulario.submit();

            });

        });

    });


    /* =========================================================
       NOTIFICACIÓN DE CAMBIO DE ESTADO
       ========================================================= */

    const idSolicitante =
            "<%= usuario.getId_usuario() %>";


    const claveStorage =
            "estadoTicketsSolicitante_" +
            idSolicitante;


    let estadosGuardados = {};


    try {

        const guardado =
                localStorage.getItem(claveStorage);

        if (guardado) {

            estadosGuardados =
                    JSON.parse(guardado);

        }

    } catch (error) {

        console.error(
                "Error leyendo los estados guardados:",
                error
        );

    }


    const ticketsActuales = [

        <% for (int i = 0; i < tickets.size(); i++) {

            TicketDTO ticket = tickets.get(i);


            String estadoActual =
                    (ticket.getEstado() != null &&
                     !ticket.getEstado().trim().isEmpty())

                    ? ticket.getEstado()
                            .trim()
                            .toUpperCase()

                    : "SIN ESTADO";


            String titulo =
                    ticket.getTitulo() != null

                    ? ticket.getTitulo()
                            .replace("\\", "\\\\")
                            .replace("\"", "\\\"")
                            .replace("\r", "")
                            .replace("\n", " ")

                    : "Sin título";

        %>


        {

            id:
                <%= ticket.getId_ticket() %>,

            titulo:
                "<%= titulo %>",

            estado:
                "<%= estadoActual %>"

        }


        <%= (i < tickets.size() - 1) ? "," : "" %>


        <% } %>

    ];


    let cambiosDetectados = {};

    let nuevosEstadosGuardar = {};


    ticketsActuales.forEach(function (ticket) {


        nuevosEstadosGuardar[ticket.id] =
                ticket.estado;


        if (

            estadosGuardados[ticket.id] &&

            estadosGuardados[ticket.id] !==
                    ticket.estado

        ) {


            cambiosDetectados[ticket.id] = {

                id:
                    ticket.id,

                titulo:
                    ticket.titulo,

                estadoAnterior:
                    estadosGuardados[ticket.id],

                estadoNuevo:
                    ticket.estado

            };

        }

    });


    localStorage.setItem(

        claveStorage,

        JSON.stringify(
            nuevosEstadosGuardar
        )

    );


    const cambios =
            Object.values(cambiosDetectados);


    if (cambios.length > 0) {


        let mensajeHtml =

            "<div style='text-align:left;" +
            "background-color:#fef2f2;" +
            "border:1px solid #fecaca;" +
            "padding:12px;" +
            "border-radius:10px;" +
            "margin-top:10px;'>";


        mensajeHtml +=

            "<p style='color:#991b1b;" +
            "font-weight:bold;" +
            "margin-bottom:8px;" +
            "font-size:0.9em;'>" +

            "Se han actualizado las siguientes solicitudes:" +

            "</p>";


        mensajeHtml +=

            "<ul style='margin:0;" +
            "padding-left:18px;" +
            "font-size:0.85em;" +
            "color:#7f1d1d;'>";


        cambios.forEach(function (item) {


            mensajeHtml +=

                "<li style='margin-bottom:6px;'>" +

                "<b>Ticket #" +

                item.id +

                " (" +

                item.titulo +

                "):</b><br>" +

                "Cambió de " +

                "<span style='text-decoration:line-through;" +
                "color:#991b1b;'>" +

                item.estadoAnterior +

                "</span> a " +

                "<span style='color:#065f46;" +
                "font-weight:bold;" +
                "background:#d1fae5;" +
                "padding:2px 6px;" +
                "border-radius:4px;'>" +

                item.estadoNuevo +

                "</span>" +

                "</li>";

        });


        mensajeHtml += "</ul></div>";


        Swal.fire({

            title:
                "¡AVISO IMPORTANTE!",

            html:
                mensajeHtml,

            icon:
                "warning",

            iconColor:
                "#dc2626",

            confirmButtonText:
                "Entendido, revisar",

            confirmButtonColor:
                "#dc2626",

            background:
                "#ffffff",

            customClass: {

                title:
                    "text-xl font-extrabold text-red-600",

                popup:
                    "rounded-2xl shadow-2xl border-2 border-red-500"

            }

        });

    }

});

</script>


</body>

</html>