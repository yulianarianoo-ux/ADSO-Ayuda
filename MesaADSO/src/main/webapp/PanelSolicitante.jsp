<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="co.edu.sena.mesaayuda.modelo.Usuario"%>
<%
    // Validación de sesión
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }

    String nombreUsuario = (usuario.getnombre_usuario() != null) ? usuario.getnombre_usuario() : "Solicitante";
    
    // Generación dinámica de iniciales
    String iniciales = "";
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
    if (iniciales.isEmpty()) {
        iniciales = "US";
    }
%>
<!DOCTYPE html>
<html lang="es" class="h-full bg-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SENA CIMM - Panel del Solicitante</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts & Material Symbols -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Plus Jakarta Sans', 'sans-serif'] },
                    colors: {
                        sena: {
                            400: '#4ade80',
                            500: '#39a900',
                            600: '#2e8800',
                            700: '#236900',
                            800: '#194b00',
                            900: '#0f2900',
                        }
                    }
                }
            }
        }
    </script>
    <style>
        .hero-banner {
            background: linear-gradient(135deg, #236900 0%, #39a900 60%, #194b00 100%);
        }
    </style>
</head>
<body class="h-full flex flex-col font-sans text-slate-800 antialiased bg-slate-100">

    <!-- Header / Navbar -->
    <header class="bg-white/90 backdrop-blur-md border-b border-slate-200 sticky top-0 z-50">
        <div class="max-w-6xl mx-auto h-16 px-4 sm:px-6 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-xl bg-sena-500 text-white flex items-center justify-center font-bold shadow-md shadow-sena-500/30">
                    <span class="material-symbols-outlined text-2xl">person</span>
                </div>
                <div>
                    <h1 class="font-black text-base text-slate-900 leading-none">SENA <span class="text-sena-600">CIMM</span></h1>
                    <span class="text-[11px] font-bold text-slate-400">Mesa de Ayuda</span>
                </div>
            </div>

            <div class="flex items-center gap-3">
                <div class="flex items-center gap-3 bg-slate-50 border border-slate-200/80 rounded-2xl p-1.5 pr-4 shadow-sm">
                    <div class="w-9 h-9 rounded-xl bg-sena-500 text-white font-black text-xs flex items-center justify-center shadow-md shadow-sena-500/20 border-2 border-sena-200">
                        <%= iniciales %>
                    </div>
                    <div class="hidden sm:flex flex-col text-left">
                        <span class="text-xs font-extrabold text-slate-900 leading-tight"><%= nombreUsuario %></span>
                        <span class="text-[10px] text-sena-600 font-bold uppercase tracking-wider">Solicitante</span>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/Login.jsp" 
                   class="flex items-center justify-center w-10 h-10 rounded-2xl bg-rose-50 text-rose-600 hover:bg-rose-600 hover:text-white transition-all duration-300 shadow-sm border border-rose-100 group"
                   title="Cerrar sesión">
                    <span class="material-symbols-outlined text-xl group-hover:scale-110 transition-transform">logout</span>
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="flex-grow max-w-6xl w-full mx-auto px-4 sm:px-6 py-8 space-y-8">

        <!-- Hero Banner -->
        <div class="hero-banner rounded-3xl p-6 sm:p-8 text-white shadow-xl shadow-sena-700/20 relative overflow-hidden flex flex-col md:flex-row items-start md:items-center justify-between gap-6">
            <div class="z-10 max-w-2xl">
                <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white/20 backdrop-blur-sm text-white text-[11px] font-extrabold tracking-wider uppercase mb-3 border border-white/20">
                    <span class="w-2 h-2 rounded-full bg-white animate-pulse"></span>
                    Módulo de Solicitante
                </div>
                <h2 class="text-3xl sm:text-4xl font-black tracking-tight leading-tight">Panel del Solicitante</h2>
                <p class="text-xs sm:text-sm font-medium text-emerald-50 mt-2 leading-relaxed">
                    Bienvenido. Desde este panel puedes registrar nuevos requerimientos técnicos y dar seguimiento a tus tickets en tiempo real.
                </p>
            </div>
            <div class="absolute -right-10 -bottom-10 w-64 h-64 rounded-full bg-white/5 pointer-events-none"></div>
        </div>

        <!-- Opciones de Acción -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            
            <!-- Crear Ticket -->
            <div class="bg-white rounded-3xl border border-slate-200 p-8 shadow-sm hover:shadow-xl hover:border-sena-500 transition-all duration-300 flex flex-col justify-between space-y-6 group">
                <div>
                    <div class="w-14 h-14 rounded-2xl bg-sena-500 text-white flex items-center justify-center mb-6 shadow-lg shadow-sena-500/30 group-hover:scale-110 transition-transform">
                        <span class="material-symbols-outlined text-3xl">add_circle</span>
                    </div>
                    <h3 class="text-2xl font-black text-slate-900 tracking-tight group-hover:text-sena-600 transition-colors">Crear Ticket</h3>
                    <p class="text-sm text-slate-600 leading-relaxed font-medium mt-2">
                        Registra una nueva solicitud de soporte o reporta un problema técnico para que nuestro equipo lo atienda.
                    </p>
                </div>
                <a href="${pageContext.request.contextPath}/crearTicket" 
                   class="inline-flex items-center justify-center gap-2 w-full py-3 px-6 rounded-xl bg-sena-500 hover:bg-sena-600 text-white font-extrabold text-sm shadow-md shadow-sena-500/20 transition-all">
                    <span>+ Crear Nuevo Ticket</span>
                    <span class="material-symbols-outlined text-base group-hover:translate-x-1 transition-transform">arrow_forward</span>
                </a>
            </div>

            <!-- Mis Tickets -->
            <div class="bg-white rounded-3xl border border-slate-200 p-8 shadow-sm hover:shadow-xl hover:border-sena-500 transition-all duration-300 flex flex-col justify-between space-y-6 group">
                <div>
                    <div class="w-14 h-14 rounded-2xl bg-sena-500 text-white flex items-center justify-center mb-6 shadow-lg shadow-sena-500/30 group-hover:scale-110 transition-transform">
                        <span class="material-symbols-outlined text-3xl">confirmation_number</span>
                    </div>
                    <h3 class="text-2xl font-black text-slate-900 tracking-tight group-hover:text-sena-600 transition-colors">Mis Tickets</h3>
                    <p class="text-sm text-slate-600 leading-relaxed font-medium mt-2">
                        Consulta tus solicitudes registradas, revisa su estado actual, observaciones y agentes asignados.
                    </p>
                </div>
                <a href="${pageContext.request.contextPath}/solicitante/misTickets" 
                   class="inline-flex items-center justify-center gap-2 w-full py-3 px-6 rounded-xl bg-slate-900 hover:bg-sena-600 text-white font-extrabold text-sm shadow-md transition-all">
                    <span>Ver Mis Tickets</span>
                    <span class="material-symbols-outlined text-base group-hover:translate-x-1 transition-transform">arrow_forward</span>
                </a>
            </div>

        </div>

    </main>

    <!-- Footer -->
    <footer class="mt-auto bg-white border-t border-slate-200 py-4 text-center">
        <p class="text-xs font-bold text-slate-400">SENA CIMM — Análisis y Desarrollo de Software (ADSO)</p>
    </footer>

</body>
</html>