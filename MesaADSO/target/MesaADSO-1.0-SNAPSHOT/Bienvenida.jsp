<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="light" lang="es">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Bienvenido | SENA CIMM Help Desk</title>
    
    <!-- Fonts e Iconos de Material Symbols -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>

    <!-- CDN de SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Tailwind CSS Config idéntica a Login -->
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

        /* Estilo personalizado para adaptar SweetAlert2 al diseño SENA */
        .swal-sena-modal {
            border-radius: 1.25rem !important;
            padding: 2rem !important;
            box-shadow: 0 25px 60px rgba(0,0,0,0.3) !important;
            border: 1px solid rgba(255, 255, 255, 0.8) !important;
            background: rgba(255, 255, 255, 0.98) !important;
        }
    </style>
</head>

<body class="min-h-screen w-full flex items-center justify-center font-body-md relative overflow-hidden bg-slate-900 selection:bg-primary selection:text-white">

    <!-- Capa del Fondo Animada (Tu imagen screen.png sin filtro oscuro) -->
    <div class="fixed inset-0 z-0 overflow-hidden pointer-events-none">
        <img alt="Aprendices e Instalaciones SENA CIMM" 
             class="w-full h-full object-cover object-center animate-bg-zoom transform-gpu" 
             src="${pageContext.request.contextPath}/Imagenes/screen.png"/>
    </div>

    <!-- Contenedor central elevado detrás de la alerta (Card del Login) -->
    <main class="relative z-10 w-full max-w-[420px] px-4 flex flex-col items-center my-auto py-8 animate-fade-in-card">
        
        <div class="w-full bg-white/95 rounded-2xl shadow-[0_20px_50px_rgba(0,0,0,0.3)] border border-white/60 p-8 flex flex-col items-center gap-6 text-center">
            
            <div class="w-16 h-16 bg-primary-container text-on-primary rounded-full flex items-center justify-center shadow-lg shadow-primary-container/30 animate-pulse">
                <span class="material-symbols-outlined text-4xl" style="font-variation-settings: 'FILL' 1;">
                    support_agent
                </span>
            </div>
            
            <div>
                <h1 class="text-2xl font-bold text-primary tracking-tight">Mesa de Ayuda CIMM</h1>
                <p class="text-sm font-medium text-on-surface-variant mt-1">Iniciando sesión en el sistema...</p>
            </div>
        </div>

        <!-- Pie de página -->
        <div class="mt-6 text-center flex flex-col gap-1 drop-shadow-[0_2px_8px_rgba(0,0,0,0.8)]">
            <p class="text-xs text-white tracking-wider uppercase font-bold">Regional Boyacá — CIMM</p>
            <p class="text-xs text-white/90 font-semibold">Análisis y Desarrollo de Software (ADSO)</p>
        </div>

    </main>

    <!-- Script de SweetAlert2 con redirección y estilo verde/blanco SENA -->
    <script>
        Swal.fire({
            icon: 'success',
            iconColor: '#39a900',
            title: '¡Bienvenido!',
            text: '<%= session.getAttribute("exito") != null ? session.getAttribute("exito") : "Ingreso exitoso al sistema." %>',
            confirmButtonText: 'Continuar ➔',
            confirmButtonColor: '#39a900',
            customClass: {
                popup: 'swal-sena-modal',
                title: 'text-2xl font-bold text-primary tracking-tight',
                htmlContainer: 'text-sm font-medium text-on-surface-variant mt-2',
                confirmButton: 'w-full py-3 px-4 rounded-xl font-semibold text-xs text-white uppercase tracking-wider shadow-md hover:bg-primary transition-all duration-200 active:scale-95'
            },
            allowOutsideClick: false,
            allowEscapeKey: false
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = '<%= request.getContextPath() %>/<%= session.getAttribute("paginaDestino") %>';
            }
        });
    </script>

</body>
</html>