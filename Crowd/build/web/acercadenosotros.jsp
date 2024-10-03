<%-- 
    Document   : acercadenosotros
    Created on : 8/10/2018, 11:28:16 PM
    Author     : nadiasalinas
--%>

<%@page import="modelo.UsuarioN"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="CSS/css1.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
              rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </head>
    <%HttpSession sesion = request.getSession();
        String saludo = "";
        UsuarioN user;
        String primerNav = "";
        String segundoNav = "";
        if (sesion.getAttribute("usuario") != null) {
            primerNav = "Mi cuenta";
            segundoNav = "Cerrar Sesión";
            user = (UsuarioN) sesion.getAttribute("usuario");
            saludo = "Bienvenido " + user.getNombre();
        } else {
            primerNav = "Iniciar Sesión";
            segundoNav = "Iniciar Sesión";
            saludo = "Inicia Sesion";
        }

    %>
    <body class="cuerpo">
        <header>
            
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="http://www.ipn.mx/Paginas/inicio.aspx">IPN</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div id="navbarNavDropdown" class="navbar-collapse collapse">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">INICIO<span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="proyecto.jsp">PROYECTOS</a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="acercadenosotros.jsp">ACERCA DE NOSOTROS</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="colaboradores.jsp">COLABORADORES</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                   SOPORTE
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                    <a class="dropdown-item" href="faq.jsp">FAQ</a>
                                    
                                </div>
                            </li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <%=saludo%>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="informacionUsuario.jsp"><%=primerNav%></a>
                                    <a class="dropdown-item" href="logout"><%=segundoNav%></a>
                    </div>
                </li>
                
            </ul>
        </div>
    </nav>
            
        </header>
                                    <br>
        <div class="div1pag2">
            <div class="div2pag2">
                
                <h1 id="tituloAcerca" style="text-align: center">Acerca de Nosotros</h1>
                
            </div>
            <div class="div3pag2">
                <div>
                    <h3 id="gris">Vision 2027</h3>
                    <p>Novasoft empresa activa, innovadora en el desarrollo de software, cumpliendo con las necesidades que surjan en nuestro entorno, ayudando siempre a la sociedad, y por consecuente, será una empresa reconocida a nivel internacional, que generará diversos beneficios, ya sean económicos a la empresa o a los trabajadores, así como beneficios sociales que facilitará diferentes aspectos en la vida de la población.</p>

                    <h3 id="gris">Misión</h3>
                    <p>Institución creada con nuevas tecnologías que ayuden a resolver una problemática en los ámbitos de adicciones, optimización de recursos e inclusión social. Trabajando constantemente y de manera efectiva para cumplir con los proyectos que se presenten dependiendo de las problemáticas sociales, y llegar a ser una empresa distinguida por sus contribuciones en ayuda a la población.</p>
                   
                    <h3 id="gris">Objetivo General</h3>
                    <p>Desarrollar software que ayude a los alumnos en la proyección y seguimiento de sus proyectos y facilite las necesidades de nuestros clientes.</p>
                    
                    <h3 id="gris">Objetivos Específicos</h3>
                        <div class="lista">
                            <ul>
                                <li>Informar sobre la existencia de nuestro software a todos nuestros clientes para que se registren en la plataforma.</li>
                                <li>Incentivar a que los usuarios donen haciendo que los creadores del proyecto ofrezcan alguna recompensa por donar.</li>
                                <li>Salvaguardar los recursos monetarios de aquellos inversionistas, para que este sea entregado de forma correcta.</li>
                                <li>Hacer publicidad de todos los proyectos en nuestra plataforma para que se conozcan.</li>
                                <li>Permitir distintas formas de pago al usuario que donara para que pueda escoger la forma más sencilla para él.</li>
                                <li>Crear una red politécnica de apoyo, mediante esta plataforma, pudiendo solicitar distintos tipos de perfiles.</li>
                            </ul>      
                        </div>
                </div>
            </div>
        </div>
    </body>
</html>
