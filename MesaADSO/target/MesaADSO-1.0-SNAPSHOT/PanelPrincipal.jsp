<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="co.edu.sena.mesaayuda.modelo.Usuario"%>
<!DOCTYPE html>
<html lang="es" class="h-full bg-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SENA CIMM - Panel de Control</title>
    
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- Google Fonts & Material Symbols -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;700;800&family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { 
                        sans: ['Plus Jakarta Sans', 'sans-serif'],
                        display: ['Space Grotesk', 'sans-serif']
                    },
                    colors: {
                        sena: {
                            400: '#39a900',
                            500: '#2e8800',
                            600: '#236900',
                            accent: '#00ff66'
                        }
                    }
                }
            }
        }
    </script>
</head>
<body class="h-full flex flex-col font-sans text-slate-800 antialiased bg-slate-100">

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    String nombreUsuario = (usuario != null) ? usuario.getnombre_usuario() : "Invitado";

    StringBuilder inicialesBuilder = new StringBuilder();
    if (usuario != null && nombreUsuario != null) {
        String[] partes = nombreUsuario.trim().split("\\s+");
        for (String parte : partes) {
            if (!parte.isEmpty()) {
                inicialesBuilder.append(parte.charAt(0));
            }
        }
    }
    
    String iniciales = inicialesBuilder.toString().toUpperCase();
    if (iniciales.isEmpty()) {
        iniciales = "U";
    } else if (iniciales.length() > 2) {
        iniciales = iniciales.substring(0, 2);
    }
%>

    <!-- Header Limpio -->
    <header class="bg-white/90 backdrop-blur-md border-b border-slate-200 sticky top-0 z-50">
        <div class="max-w-6xl mx-auto h-20 px-4 sm:px-6 flex items-center justify-between">
            
            <!-- Logo & Brand -->
            <div class="flex items-center gap-3.5">
                <div class="w-11 h-11 rounded-2xl bg-sena-500 text-white shadow-lg shadow-sena-500/30 flex items-center justify-center font-bold">
                    <span class="material-symbols-outlined text-2xl">verified_user</span>
                </div>
                <div>
                    <h1 class="font-display font-bold text-xl tracking-wider text-slate-900 leading-none">SENA <span class="text-sena-500">CIMM</span></h1>
                    <span class="text-[11px] font-extrabold tracking-widest uppercase text-slate-400">Mesa de Ayuda</span>
                </div>
            </div>

            <!-- Profile & Actions -->
            <div class="flex items-center gap-4">
                <div class="flex items-center gap-3 bg-white border border-slate-200 rounded-2xl p-2 pr-5 shadow-sm">
                    <div class="w-9 h-9 rounded-xl bg-sena-500 text-white font-black text-sm flex items-center justify-center shadow-md">
                        <%= iniciales %>
                    </div>
                    <div class="hidden sm:flex flex-col text-left">
                        <span class="text-xs font-bold text-slate-900 leading-tight"><%= nombreUsuario %></span>
                        <span class="text-[10px] font-black text-sena-500 uppercase tracking-widest">Administrador</span>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/Login.jsp" 
                   class="flex items-center justify-center w-11 h-11 rounded-2xl bg-rose-50 text-rose-600 hover:bg-rose-600 hover:text-white transition-all duration-300 border border-rose-100 group shadow-sm"
                   title="Cerrar sesión">
                    <span class="material-symbols-outlined text-xl group-hover:scale-110 transition-transform">logout</span>
                </a>
            </div>

        </div>
    </header>

    <!-- Main Content -->
    <main class="flex-grow max-w-6xl w-full mx-auto px-4 sm:px-6 py-10 space-y-10">

        <!-- Banner Hero Verde SENA Dinámico -->
        <div class="relative rounded-3xl p-8 sm:p-10 bg-gradient-to-r from-sena-600 via-sena-500 to-emerald-600 text-white shadow-2xl shadow-sena-600/25 overflow-hidden">
            
            <!-- Patrón de Fondo -->
            <div class="absolute inset-0 bg-[linear-gradient(to_right,#ffffff10_1px,transparent_1px),linear-gradient(to_bottom,#ffffff10_1px,transparent_1px)] bg-[size:2rem_2rem]"></div>
            <div class="absolute -right-10 -bottom-10 w-72 h-72 bg-white/10 rounded-full blur-2xl pointer-events-none"></div>

            <div class="relative z-10 flex flex-col md:flex-row items-start md:items-center justify-between gap-8">
                <div class="max-w-2xl space-y-3">
                    <div class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-white/20 backdrop-blur-md text-white text-[11px] font-black tracking-widest uppercase border border-white/20">
                        <span class="w-2 h-2 rounded-full bg-white animate-ping"></span>
                        Centro de Control
                    </div>
                    <h2 class="font-display text-4xl sm:text-5xl font-extrabold tracking-tight leading-none">
                        PANEL DE CONTROL
                    </h2>
                    <p class="text-sm font-medium text-emerald-50 leading-relaxed max-w-lg">
                        Gestión Integral de Requerimientos e Informes Estadísticos en Tiempo Real.
                    </p>
                </div>

                <!-- Indicadores Flotantes -->
                <div class="flex flex-col sm:flex-row md:flex-col gap-3 w-full md:w-auto">
                    <div class="px-5 py-3.5 bg-black/20 backdrop-blur-md rounded-2xl border border-white/15 flex items-center gap-4">
                        <div class="w-10 h-10 rounded-xl bg-white/20 flex items-center justify-center text-white">
                            <span class="material-symbols-outlined text-2xl">dns</span>
                        </div>
                        <div>
                            <span class="block text-[10px] uppercase font-black tracking-widest text-emerald-200">Servidor CIMM</span>
                            <span class="text-xs font-bold text-white flex items-center gap-2 mt-0.5">
                                <span class="w-2 h-2 rounded-full bg-sena-accent"></span> Operativo
                            </span>
                        </div>
                    </div>

                    <div class="px-5 py-3.5 bg-black/20 backdrop-blur-md rounded-2xl border border-white/15 flex items-center gap-4">
                        <div class="w-10 h-10 rounded-xl bg-white/20 flex items-center justify-center text-white">
                            <span class="material-symbols-outlined text-2xl">support_agent</span>
                        </div>
                        <div>
                            <span class="block text-[10px] uppercase font-black tracking-widest text-emerald-200">Soporte Técnico</span>
                            <span class="text-xs font-bold text-white mt-0.5">Prioridad Alta</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Módulos Operativos (Cards Coloridas sobre Fondo Blanco) -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">

            <!-- Card 1: Gestión de Tickets (Oscura con Acentos Verdes) -->
            <a href="${pageContext.request.contextPath}/tickets" 
               class="group relative rounded-3xl bg-slate-900 text-white shadow-xl hover:shadow-2xl hover:shadow-sena-500/20 hover:-translate-y-1.5 transition-all duration-300 overflow-hidden flex flex-col justify-between">
                
                <div class="relative h-56 overflow-hidden bg-slate-950">
                    <img src="https://images.unsplash.com/photo-1581092921461-eab62e97a780?auto=format&fit=crop&w=800&q=80" 
                         alt="Gestión de Tickets" 
                         class="w-full h-full object-cover opacity-60 group-hover:scale-105 group-hover:opacity-80 transition-all duration-500" />
                    <div class="absolute inset-0 bg-gradient-to-t from-slate-900 via-slate-900/40 to-transparent"></div>
                    
                    <div class="absolute top-5 left-5 w-12 h-12 rounded-2xl bg-sena-500 text-white shadow-lg shadow-sena-500/40 flex items-center justify-center">
                        <span class="material-symbols-outlined text-2xl">confirmation_number</span>
                    </div>

                    <div class="absolute top-5 right-5 w-10 h-10 rounded-2xl bg-white/20 backdrop-blur-md text-white flex items-center justify-center group-hover:bg-sena-500 transition-all duration-300">
                        <span class="material-symbols-outlined text-xl group-hover:translate-x-1 transition-transform">arrow_forward</span>
                    </div>

                    <div class="absolute bottom-4 left-6 right-6">
                        <span class="text-[10px] font-black uppercase tracking-widest text-sena-accent">Módulo Operativo</span>
                        <h3 class="font-display text-2xl font-black mt-0.5">GESTIÓN DE TICKETS</h3>
                    </div>
                </div>

                <div class="p-6 flex-1 flex flex-col justify-between bg-slate-900">
                    <p class="text-xs text-slate-300 leading-relaxed font-medium">
                        Atención, asignación y seguimiento en tiempo real a solicitudes de hardware, redes y soporte técnico del centro.
                    </p>

                    <div class="mt-6 pt-4 border-t border-slate-800 flex items-center justify-between text-xs font-bold text-slate-400 group-hover:text-sena-accent transition-colors">
                        <span>Acceso a requerimientos</span>
                        <span class="material-symbols-outlined text-base group-hover:translate-x-1 transition-transform">chevron_right</span>
                    </div>
                </div>
            </a>

            <!-- Card 2: Reportes Analíticos (Estilo Gradiente Cian/Azul) -->
            <a href="${pageContext.request.contextPath}/reportes" 
               class="group relative rounded-3xl bg-slate-900 text-white shadow-xl hover:shadow-2xl hover:shadow-sky-500/20 hover:-translate-y-1.5 transition-all duration-300 overflow-hidden flex flex-col justify-between">
                
                <div class="relative h-56 overflow-hidden bg-slate-950">
                    <img src="https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=800&q=80" 
                         alt="Reportes Analíticos" 
                         class="w-full h-full object-cover opacity-60 group-hover:scale-105 group-hover:opacity-80 transition-all duration-500" />
                    <div class="absolute inset-0 bg-gradient-to-t from-slate-900 via-slate-900/40 to-transparent"></div>
                    
                    <div class="absolute top-5 left-5 w-12 h-12 rounded-2xl bg-sky-500 text-white shadow-lg shadow-sky-500/40 flex items-center justify-center">
                        <span class="material-symbols-outlined text-2xl">analytics</span>
                    </div>

                    <div class="absolute top-5 right-5 w-10 h-10 rounded-2xl bg-white/20 backdrop-blur-md text-white flex items-center justify-center group-hover:bg-sky-500 transition-all duration-300">
                        <span class="material-symbols-outlined text-xl group-hover:translate-x-1 transition-transform">arrow_forward</span>
                    </div>

                    <div class="absolute bottom-4 left-6 right-6">
                        <span class="text-[10px] font-black uppercase tracking-widest text-sky-400">Módulo Estadístico</span>
                        <h3 class="font-display text-2xl font-black mt-0.5">REPORTES ANALÍTICOS</h3>
                    </div>
                </div>

                <div class="p-6 flex-1 flex flex-col justify-between bg-slate-900">
                    <p class="text-xs text-slate-300 leading-relaxed font-medium">
                        Visualización de datos, métricas de rendimiento e informes dinámicos de solicitudes registradas en la plataforma.
                    </p>

                    <div class="mt-6 pt-4 border-t border-slate-800 flex items-center justify-between text-xs font-bold text-slate-400 group-hover:text-sky-400 transition-colors">
                        <span>Estadísticas y gráficas</span>
                        <span class="material-symbols-outlined text-base group-hover:translate-x-1 transition-transform">chevron_right</span>
                    </div>
                </div>
            </a>

        </div>

    </main>

    <!-- Footer Claro -->
    <footer class="mt-auto bg-white border-t border-slate-200 py-6 text-center">
        <p class="text-xs font-bold text-slate-400">
            SENA CIMM &mdash; <span class="text-slate-600">Análisis y Desarrollo de Software (ADSO)</span>
        </p>
    </footer>

</body>
</html>