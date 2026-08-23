<%-- 
    Document   : PanelAgente
    Created on : 13/08/2026, 1:54:11 p. m.
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="co.edu.sena.mesaayuda.modelo.Usuario"%>
<!DOCTYPE html>
<html lang="es" class="h-full bg-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SENA CIMM - Panel de Agente</title>
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

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    String nombreUsuario = (usuario != null) ? usuario.getnombre_usuario() : "Agente de Soporte";

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
        iniciales = "AG";
    }
%>

    <!-- Navbar Principal Superior -->
    <header class="bg-white/90 backdrop-blur-md border-b border-slate-200 sticky top-0 z-50">
        <div class="max-w-6xl mx-auto h-16 px-4 sm:px-6 flex items-center justify-between">
            
            <!-- Branding -->
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-xl bg-sena-500 text-white flex items-center justify-center font-bold shadow-md shadow-sena-500/30">
                    <span class="material-symbols-outlined text-2xl">support_agent</span>
                </div>
                <div>
                    <h1 class="font-black text-base text-slate-900 leading-none">SENA <span class="text-sena-600">CIMM</span></h1>
                    <span class="text-[11px] font-bold text-slate-400">Mesa de Ayuda</span>
                </div>
            </div>

            <!-- Perfil de Usuario Integrado + Botón Cerrar Sesión -->
            <div class="flex items-center gap-3">
                <!-- Card Integrada de Perfil -->
                <div class="flex items-center gap-3 bg-slate-50 border border-slate-200/80 rounded-2xl p-1.5 pr-4 shadow-sm">
                    <div class="w-9 h-9 rounded-xl bg-sena-500 text-white font-black text-xs flex items-center justify-center shadow-md shadow-sena-500/20 border-2 border-sena-200">
                        <%= iniciales %>
                    </div>
                    <div class="hidden sm:flex flex-col text-left">
                        <span class="text-xs font-extrabold text-slate-900 leading-tight"><%= nombreUsuario %></span>
                        <span class="text-[10px] text-sena-600 font-bold uppercase tracking-wider">Agente Técnico</span>
                    </div>
                </div>

                <!-- Botón Cerrar Sesión Destacado -->
                <a href="${pageContext.request.contextPath}/Login.jsp" 
                   class="flex items-center justify-center w-10 h-10 rounded-2xl bg-rose-50 text-rose-600 hover:bg-rose-600 hover:text-white transition-all duration-300 shadow-sm border border-rose-100 group"
                   title="Cerrar sesión">
                    <span class="material-symbols-outlined text-xl group-hover:scale-110 transition-transform">logout</span>
                </a>
            </div>

        </div>
    </header>

    <!-- Contenido Principal -->
    <main class="flex-grow max-w-6xl w-full mx-auto px-4 sm:px-6 py-8 space-y-8">

        <!-- Banner Hero Verde SENA -->
        <div class="hero-banner rounded-3xl p-6 sm:p-8 text-white shadow-xl shadow-sena-700/20 relative overflow-hidden flex flex-col md:flex-row items-start md:items-center justify-between gap-6">
            <div class="z-10 max-w-2xl">
                <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white/20 backdrop-blur-sm text-white text-[11px] font-extrabold tracking-wider uppercase mb-3 border border-white/20">
                    <span class="w-2 h-2 rounded-full bg-white animate-pulse"></span>
                    Módulo de Agente
                </div>
                <h2 class="text-3xl sm:text-4xl font-black tracking-tight leading-tight">Panel de Soporte Técnico</h2>
                <p class="text-xs sm:text-sm font-medium text-emerald-50 mt-2 leading-relaxed">
                    Gestiona, diagnostica y soluciona los requerimientos técnicos asignados a tu cuenta en tiempo real.
                </p>
            </div>

            <!-- Indicadores Operativos -->
            <div class="z-10 flex flex-wrap gap-3 self-stretch md:self-auto">
                <div class="flex-1 md:flex-none px-4 py-3 bg-black/20 backdrop-blur-md rounded-2xl border border-white/10 flex items-center gap-3">
                    <div class="w-9 h-9 rounded-xl bg-white/15 flex items-center justify-center text-white">
                        <span class="material-symbols-outlined text-xl">pending_actions</span>
                    </div>
                    <div>
                        <span class="block text-[10px] uppercase font-extrabold tracking-wider text-emerald-200">Bandeja Activa</span>
                        <span class="text-xs font-black text-white flex items-center gap-1.5">
                            <span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span> Casos Pendientes
                        </span>
                    </div>
                </div>

                <div class="flex-1 md:flex-none px-4 py-3 bg-black/20 backdrop-blur-md rounded-2xl border border-white/10 flex items-center gap-3">
                    <div class="w-9 h-9 rounded-xl bg-white/15 flex items-center justify-center text-white">
                        <span class="material-symbols-outlined text-xl">dns</span>
                    </div>
                    <div>
                        <span class="block text-[10px] uppercase font-extrabold tracking-wider text-emerald-200">Servidor CIMM</span>
                        <span class="text-xs font-black text-white">Operativo</span>
                    </div>
                </div>
            </div>

            <!-- Círculo decorativo de fondo -->
            <div class="absolute -right-10 -bottom-10 w-64 h-64 rounded-full bg-white/5 pointer-events-none"></div>
        </div>

        <!-- Módulo Unificado de Gestión -->
        <div class="w-full">
            <a href="${pageContext.request.contextPath}/atender" class="group bg-white rounded-3xl border border-slate-200 shadow-lg hover:shadow-2xl hover:border-sena-500 transition-all duration-300 overflow-hidden flex flex-col md:flex-row">
                
                <!-- Imagen Destacada -->
                <div class="relative md:w-5/12 h-64 md:h-auto overflow-hidden bg-slate-900">
                    <img src="https://images.unsplash.com/photo-1531482615713-2afd69097998?auto=format&fit=crop&w=1000&q=80" 
                         alt="Atención de Solicitudes" 
                         class="w-full h-full object-cover opacity-80 group-hover:scale-105 group-hover:opacity-95 transition-all duration-500" />
                    <div class="absolute inset-0 bg-gradient-to-t from-slate-950 via-slate-950/30 to-transparent md:bg-gradient-to-r md:from-transparent md:via-slate-950/20 md:to-slate-950/80"></div>
                    
                    <div class="absolute top-6 left-6 w-12 h-12 rounded-2xl bg-sena-500 text-white shadow-lg shadow-sena-500/40 flex items-center justify-center">
                        <span class="material-symbols-outlined text-3xl">handyman</span>
                    </div>
                </div>

                <!-- Detalle y Acción -->
                <div class="p-8 md:w-7/12 flex flex-col justify-between space-y-6">
                    <div>
                        <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-sena-50 text-sena-700 text-[11px] font-extrabold border border-sena-200 mb-3">
                            <span class="w-2 h-2 rounded-full bg-sena-500"></span>
                            Gestión Principal
                        </div>
                        <h3 class="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight group-hover:text-sena-600 transition-colors">
                            Atender Solicitudes y Tickets
                        </h3>
                        <p class="text-sm text-slate-600 leading-relaxed font-medium mt-3">
                            Accede a tu bandeja de entrada de tickets asignados. Realiza diagnósticos técnicos, cambia estados de incidentes y documenta las soluciones brindadas al usuario final.
                        </p>
                    </div>

                    <div class="pt-6 border-t border-slate-100 flex items-center justify-between">
                        <span class="text-xs font-bold text-slate-400 group-hover:text-sena-700 transition-colors">
                            Ingresar a la mesa de trabajo
                        </span>
                        <div class="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl bg-sena-500 group-hover:bg-sena-600 text-white text-xs font-extrabold shadow-md shadow-sena-500/20 transition-all">
                            <span>Atender Tickets</span>
                            <span class="material-symbols-outlined text-base group-hover:translate-x-1 transition-transform">arrow_forward</span>
                        </div>
                    </div>
                </div>
            </a>
        </div>

    </main>

    <!-- Footer Simple -->
    <footer class="mt-auto bg-white border-t border-slate-200 py-4 text-center">
        <p class="text-xs font-bold text-slate-400">SENA CIMM — Análisis y Desarrollo de Software (ADSO)</p>
    </footer>

</body>
</html>