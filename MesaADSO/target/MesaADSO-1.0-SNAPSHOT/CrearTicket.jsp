<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="co.edu.sena.mesaayuda.modelo.Categoria" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mesa de Ayuda - Crear Ticket</title>

    <!-- Google Fonts: Plus Jakarta Sans & FontAwesome Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        :root {
            --primary: #2e7d32;
            --primary-hover: #1b5e20;
            --primary-light: #e8f5e9;
            --primary-glow: rgba(46, 125, 50, 0.15);
            --accent-green: #43a047;
            
            --bg-gradient: linear-gradient(135deg, #f4f7f6 0%, #e2ebd8 100%);
            --card-bg: rgba(255, 255, 255, 0.95);
            
            --text-title: #1a2e1b;
            --text-body: #37474f;
            --text-muted: #78909c;
            
            --border-light: #e0e6ed;
            --border-focus: #2e7d32;
            
            --radius-lg: 20px;
            --radius-md: 12px;
            
            --shadow-card: 0 20px 40px rgba(0, 0, 0, 0.08), 0 1px 3px rgba(0, 0, 0, 0.05);
            --shadow-input: 0 2px 5px rgba(0, 0, 0, 0.02);
            --shadow-btn: 0 8px 20px rgba(46, 125, 50, 0.28);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            background: var(--bg-gradient);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
            position: relative;
            overflow-x: hidden;
        }

        /* Destellos decorativos de fondo */
        .ambient-glow {
            position: absolute;
            width: 380px;
            height: 380px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(76, 175, 80, 0.2) 0%, rgba(255,255,255,0) 70%);
            z-index: 0;
            pointer-events: none;
        }
        .glow-1 { top: -100px; left: -100px; }
        .glow-2 { bottom: -120px; right: -120px; }

        /* Tarjeta Principal */
        .ticket-card {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 620px;
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-card);
            border: 1px solid rgba(255, 255, 255, 0.8);
            overflow: hidden;
            animation: cardAppear 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes cardAppear {
            from { opacity: 0; transform: translateY(20px) scale(0.98); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        /* Línea Superior Animada */
        .card-top-bar {
            height: 6px;
            background: linear-gradient(90deg, #2e7d32, #66bb6a, #2e7d32);
            background-size: 200% 100%;
            animation: shimmerBar 4s infinite linear;
        }

        @keyframes shimmerBar {
            0% { background-position: 0% 0%; }
            100% { background-position: 200% 0%; }
        }

        /* Botón de Volver */
        .btn-back {
            position: absolute;
            top: 20px;
            left: 20px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 14px;
            background-color: var(--primary-light);
            color: var(--primary);
            text-decoration: none;
            border-radius: var(--radius-md);
            font-size: 0.85rem;
            font-weight: 700;
            border: 1px solid rgba(46, 125, 50, 0.15);
            transition: all 0.25s ease;
            z-index: 2;
        }

        .btn-back:hover {
            background-color: var(--primary);
            color: #ffffff;
            transform: translateX(-3px);
            box-shadow: 0 4px 12px rgba(46, 125, 50, 0.25);
        }

        /* Encabezado */
        .card-header {
            padding: 40px 35px 15px 35px;
            text-align: center;
        }

        .header-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 6px 14px;
            background-color: var(--primary-light);
            color: var(--primary);
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 12px;
            margin-top: 10px;
        }

        .header-badge .pulse-dot {
            width: 8px;
            height: 8px;
            background-color: var(--primary);
            border-radius: 50%;
            animation: pulse 1.8s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(46, 125, 50, 0.7); }
            70% { box-shadow: 0 0 0 8px rgba(46, 125, 50, 0); }
            100% { box-shadow: 0 0 0 0 rgba(46, 125, 50, 0); }
        }

        .card-header h2 {
            font-size: 1.75rem;
            color: var(--text-title);
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .card-header p {
            color: var(--text-muted);
            font-size: 0.95rem;
            margin-top: 6px;
        }

        /* Cuerpo del Formulario */
        .card-body {
            padding: 20px 35px 35px 35px;
        }

        /* Banner de Prioridad Automática */
        .auto-notice {
            background: linear-gradient(135deg, #f1f8f1 0%, #e8f5e9 100%);
            border: 1px solid #c8e6c9;
            border-radius: var(--radius-md);
            padding: 16px;
            margin-bottom: 25px;
            display: flex;
            align-items: flex-start;
            gap: 14px;
        }

        .notice-icon {
            width: 38px;
            height: 38px;
            min-width: 38px;
            background-color: #ffffff;
            color: var(--primary);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            box-shadow: 0 2px 6px rgba(0,0,0,0.06);
        }

        .notice-content h4 {
            font-size: 0.88rem;
            font-weight: 700;
            color: var(--primary-hover);
            margin-bottom: 2px;
        }

        .notice-content p {
            font-size: 0.82rem;
            color: var(--text-body);
            line-height: 1.4;
        }

        /* Campos de Entrada */
        .form-group {
            margin-bottom: 22px;
        }

        .form-label {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 600;
            font-size: 0.88rem;
            color: var(--text-title);
            margin-bottom: 8px;
        }

        .char-counter {
            font-size: 0.78rem;
            color: var(--text-muted);
            font-weight: 500;
        }

        .input-container {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            color: var(--text-muted);
            font-size: 1.05rem;
            transition: color 0.3s ease;
            pointer-events: none;
        }

        .input-field {
            width: 100%;
            padding: 14px 16px 14px 48px;
            background: #ffffff;
            border: 1.5px solid var(--border-light);
            border-radius: var(--radius-md);
            font-size: 0.95rem;
            color: var(--text-body);
            box-shadow: var(--shadow-input);
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            appearance: none;
        }

        select.input-field {
            cursor: pointer;
            padding-right: 42px;
        }

        .select-arrow {
            position: absolute;
            right: 16px;
            color: var(--text-muted);
            pointer-events: none;
            font-size: 0.85rem;
            transition: transform 0.3s ease;
        }

        textarea.input-field {
            min-height: 125px;
            resize: vertical;
            padding-top: 14px;
            line-height: 1.5;
        }

        /* Estados de Enfoque (Focus) */
        .input-field:focus {
            outline: none;
            border-color: var(--border-focus);
            box-shadow: 0 0 0 4px var(--primary-glow);
            background: #ffffff;
        }

        .input-container:focus-within .input-icon {
            color: var(--primary);
        }

        .input-container:focus-within .select-arrow {
            color: var(--primary);
            transform: rotate(180deg);
        }

        /* Botón de Envío */
        .btn-submit {
            width: 100%;
            padding: 16px;
            margin-top: 10px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--accent-green) 100%);
            color: #ffffff;
            border: none;
            border-radius: var(--radius-md);
            font-size: 1rem;
            font-weight: 700;
            letter-spacing: 0.3px;
            cursor: pointer;
            box-shadow: var(--shadow-btn);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(46, 125, 50, 0.35);
            background: linear-gradient(135deg, var(--primary-hover) 0%, var(--primary) 100%);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        /* Responsive */
        @media (max-width: 576px) {
            body { padding: 15px 10px; }
            .btn-back { position: relative; top: 0; left: 0; display: inline-flex; margin: 15px 0 0 20px; }
            .card-header { padding: 15px 20px 10px 20px; }
            .card-body { padding: 15px 20px 25px 20px; }
            .card-header h2 { font-size: 1.45rem; }
            .header-badge { margin-top: 5px; }
        }
    </style>
</head>
<body>

    <div class="ambient-glow glow-1"></div>
    <div class="ambient-glow glow-2"></div>

    <main class="ticket-card">
        <div class="card-top-bar"></div>

        <!-- Botón de Volver -->
        <a href="PanelSolicitante.jsp" class="btn-back" title="Volver a la página anterior">
            <i class="fa-solid fa-arrow-left"></i>
            <span>Volver</span>
        </a>

        <header class="card-header">
            <div class="header-badge">
                <span class="pulse-dot"></span>
                SENA - Mesa de Ayuda
            </div>
            <h2>Crear Nuevo Ticket</h2>
            <p>Reporta tu incidente o solicitud técnica de forma rápida</p>
        </header>

        <div class="card-body">
            
            <!-- Indicador Informativo Automático -->
            <div class="auto-notice">
                <div class="notice-icon">
                    <i class="fa-solid fa-wand-magic-sparkles"></i>
                </div>
                <div class="notice-content">
                    <h4>Prioridad y Agente Automatizados</h4>
                    <p>La prioridad (RF-03) y el agente responsable se asignan automáticamente según la categoría seleccionada.</p>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/crearTicket" method="POST">
                
                <!-- Título -->
                <div class="form-group">
                    <label for="titulo" class="form-label">Asunto / Título</label>
                    <div class="input-container">
                        <i class="fa-solid fa-heading input-icon"></i>
                        <input type="text" id="titulo" name="titulo" class="input-field" placeholder="Ej. Falla de red en sala de cómputo 3" required autocomplete="off">
                    </div>
                </div>

                <!-- Categoría -->
                <div class="form-group">
                    <label for="id_categoria" class="form-label">Categoría del Incidente</label>
                    <div class="input-container">
                        <i class="fa-solid fa-layer-group input-icon"></i>
                        <select id="id_categoria" name="id_categoria" class="input-field" required>
                            <option value="" disabled selected>Selecciona una categoría...</option>
                            <%
                                List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
                                if (categorias != null) {
                                    for (Categoria cat : categorias) {
                            %>
                                <option value="<%= cat.getId_categoria() %>"><%= cat.getnombre_categoria() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                        <i class="fa-solid fa-chevron-down select-arrow"></i>
                    </div>
                </div>

                <!-- Descripción con Contador -->
                <div class="form-group">
                    <label for="descripcion" class="form-label">
                        <span>Descripción Detallada</span>
                        <span class="char-counter" id="charCounter">0 / 500</span>
                    </label>
                    <div class="input-container">
                        <i class="fa-solid fa-align-left input-icon" style="top: 18px;"></i>
                        <textarea id="descripcion" name="descripcion" class="input-field" maxlength="500" placeholder="Describe el problema, mensajes de error o equipos afectados..." required></textarea>
                    </div>
                </div>

                <!-- Botón de Envío -->
                <button type="submit" class="btn-submit">
                    <i class="fa-solid fa-paper-plane"></i>
                    <span>Registrar Ticket</span>
                </button>
            </form>
        </div>
    </main>

    <!-- Scripts de Interacción y Alertas -->
    <script>
        // Contador de caracteres en tiempo real
        const descArea = document.getElementById('descripcion');
        const charCounter = document.getElementById('charCounter');

        descArea.addEventListener('input', () => {
            charCounter.textContent = `${descArea.value.length} / 500`;
        });

        // Captura de mensajes devueltos por el Servlet (SweetAlert2)
        <%
            String mensajeExito = (String) session.getAttribute("mensajeExito");
            String mensajeError = (String) session.getAttribute("mensajeError");
        %>

        <% if (mensajeExito != null) { %>
            Swal.fire({
                icon: 'success',
                title: '¡Ticket Registrado!',
                text: '<%= mensajeExito %>',
                confirmButtonColor: '#2e7d32',
                background: '#ffffff',
                borderRadius: '16px',
                confirmButtonText: 'Entendido'
            });
            <% session.removeAttribute("mensajeExito"); %>
        <% } %>

        <% if (mensajeError != null) { %>
            Swal.fire({
                icon: 'error',
                title: 'No se pudo crear el ticket',
                text: '<%= mensajeError %>',
                confirmButtonColor: '#d32f2f',
                background: '#ffffff',
                borderRadius: '16px',
                confirmButtonText: 'Intentar de nuevo'
            });
            <% session.removeAttribute("mensajeError"); %>
        <% } %>
    </script>
</body>
</html>