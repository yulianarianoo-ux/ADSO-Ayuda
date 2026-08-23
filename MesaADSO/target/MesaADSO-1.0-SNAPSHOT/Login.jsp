<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="es">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SENA CIMM Help Desk - Login</title>
    
    <!-- Fonts e Iconos -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet"/>

    <!-- CDN de SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Tailwind CSS Config -->
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script id="tailwind-config">
        tailwind.config = {
          darkMode: "class",
          theme: {
            extend: {
              colors: {
                    primary: "#226d00",
                    "on-primary": "#ffffff",
                    "primary-container": "#39a900",
                    "on-primary-container": "#0c3400",
                    surface: "#ffffff",
                    "on-surface": "#181c1b",
                    "on-surface-variant": "#3f4a38",
                    outline: "#6f7b66",
                    "outline-variant": "#becbb3",
                    secondary: "#3c627f",
                    background: "#f7faf8"
              },
              fontFamily: {
                    "body-md": ["Inter"],
                    "label-md": ["Inter"],
                    "headline-lg-mobile": ["Inter"]
              },
              keyframes: {
                kenburns: {
                  '0%': { transform: 'scale(1)' },
                  '50%': { transform: 'scale(1.08)' },
                  '100%': { transform: 'scale(1)' },
                },
                fadeInUp: {
                  '0%': { opacity: '0', transform: 'translateY(20px)' },
                  '100%': { opacity: '1', transform: 'translateY(0)' },
                }
              },
              animation: {
                'bg-zoom': 'kenburns 25s infinite ease-in-out',
                'fade-in-card': 'fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards',
              }
            },
          },
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
    </style>
</head>

<body class="min-h-screen w-full flex items-center justify-center font-body-md relative overflow-hidden bg-slate-900 selection:bg-primary selection:text-white">

    <!-- Capa del Fondo Animada (Sin filtro oscuro) -->
    <div class="fixed inset-0 z-0 overflow-hidden pointer-events-none">
        <img alt="Aprendices e Instalaciones SENA CIMM" 
             class="w-full h-full object-cover object-center animate-bg-zoom transform-gpu" 
             src="${pageContext.request.contextPath}/Imagenes/screen.png"/>
    </div>

    <!-- Login Container -->
    <main class="relative z-10 w-full max-w-[420px] px-4 flex flex-col items-center my-auto py-8 animate-fade-in-card">
        
        <!-- Tarjeta del Formulario (Efecto Elevado con Microinteracción al Hover) -->
        <div class="w-full bg-white/95 rounded-2xl shadow-[0_20px_50px_rgba(0,0,0,0.3)] border border-white/60 p-8 flex flex-col items-center gap-6 transition-all duration-300 hover:shadow-[0_25px_60px_rgba(0,0,0,0.4)]">
            
            <!-- Encabezado con Ícono Animado -->
            <div class="flex flex-col items-center text-center gap-2">
                <div class="w-16 h-16 bg-primary-container text-on-primary-container rounded-full flex items-center justify-center mb-2 shadow-md transition-transform duration-300 hover:scale-110">
                    <span class="material-symbols-outlined text-4xl" style="font-variation-settings: 'FILL' 1;">
                        support_agent
                    </span>
                </div>
                <h1 class="text-2xl font-bold text-primary tracking-tight">Mesa de Ayuda CIMM</h1>
                <p class="text-sm font-medium text-on-surface-variant">Sistema de Soporte Técnico</p>
            </div>

            <!-- Formulario -->
<form action="${pageContext.request.contextPath}/UsuarioWeb" method="POST" class="w-full flex flex-col gap-4">                
                <!-- Campo Usuario / Correo -->
                <div class="flex flex-col gap-1">
                    <label class="text-xs font-semibold text-on-surface" for="correo">Correo Electrónico o Usuario</label>
                    <div class="relative group">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <span class="material-symbols-outlined text-outline group-focus-within:text-primary transition-colors">person</span>
                        </div>
                        <input class="block w-full pl-10 pr-3 py-2.5 border border-outline-variant rounded-xl bg-surface focus:ring-2 focus:ring-primary focus:border-primary text-sm text-on-surface transition-all duration-200 placeholder:text-gray-400 outline-none" 
                               id="correo" 
                               name="correo" 
                               placeholder="usuario@sena.edu.co" 
                               required 
                               type="text"/>
                    </div>
                </div>

                <!-- Campo Contraseña -->
                <div class="flex flex-col gap-1">
                    <label class="text-xs font-semibold text-on-surface" for="contrasena">Contraseña</label>
                    <div class="relative group">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <span class="material-symbols-outlined text-outline group-focus-within:text-primary transition-colors">lock</span>
                        </div>
                        <input class="block w-full pl-10 pr-10 py-2.5 border border-outline-variant rounded-xl bg-surface focus:ring-2 focus:ring-primary focus:border-primary text-sm text-on-surface transition-all duration-200 placeholder:text-gray-400 outline-none" 
                               id="contrasena" 
                               name="contrasena" 
                               placeholder="••••••••" 
                               required 
                               type="password"/>
                        <button type="button" 
                                onclick="togglePasswordVisibility()" 
                                class="absolute inset-y-0 right-0 pr-3 flex items-center text-outline hover:text-primary transition-colors focus:outline-none">
                            <span id="eye-icon" class="material-symbols-outlined">visibility</span>
                        </button>
                    </div>
                </div>

              

                <!-- Botón de Iniciar Sesión con animación hover/active -->
                <button class="w-full flex justify-center items-center gap-2 py-3 px-4 border border-transparent rounded-xl shadow-md text-xs font-semibold text-on-primary bg-primary-container hover:bg-primary hover:shadow-lg transition-all duration-200 active:scale-95 mt-2 group" 
                        type="submit">
                    <span class="material-symbols-outlined text-[18px] transition-transform group-hover:translate-x-1" style="font-variation-settings: 'FILL' 1;">login</span>
                    Iniciar Sesión
                </button>
            </form>
        </div>

        <!-- Pie de página con sombra desplegada para visibilidad sobre la foto -->
        <div class="mt-6 text-center flex flex-col gap-1 drop-shadow-[0_2px_8px_rgba(0,0,0,0.8)]">
            <p class="text-xs text-white tracking-wider uppercase font-bold">Regional Boyacá — CIMM</p>
            <p class="text-xs text-white/90 font-semibold">Análisis y Desarrollo de Software (ADSO)</p>
        </div>

    </main>

    <!-- Script de Visibilidad de Contraseña -->
    <script>
        function togglePasswordVisibility() {
            const passwordInput = document.getElementById('contrasena');
            const eyeIcon = document.getElementById('eye-icon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                eyeIcon.textContent = 'visibility_off';
            } else {
                passwordInput.type = 'password';
                eyeIcon.textContent = 'visibility';
            }
        }
    </script>

    <!-- Integración SweetAlert2 -->
    <% 
        String error = (String) request.getAttribute("error");
        String exito = (String) request.getAttribute("exito");
    %>
    <script>
        <% if (error != null && !error.trim().isEmpty()) { %>
            Swal.fire({
                icon: 'error',
                title: 'Error de Autenticación',
                text: '<%= error %>',
                confirmButtonColor: '#226d00',
                confirmButtonText: 'Aceptar',
                customClass: { popup: 'rounded-2xl' }
            });
        <% } %>

        <% if (exito != null && !exito.trim().isEmpty()) { %>
            Swal.fire({
                icon: 'success',
                title: '¡Acceso Correcto!',
                text: '<%= exito %>',
                confirmButtonColor: '#226d00',
                confirmButtonText: 'Continuar',
                customClass: { popup: 'rounded-2xl' }
            });
        <% } %>
    </script>

</body>
</html>