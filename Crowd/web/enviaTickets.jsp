<%-- 
    Document   : enviaTickets
    Created on : 18/03/2019, 08:38:25 PM
    Author     : benja
--%>

<%@page import="modelo.ticketsSoporte"%>
<%@page import="dao.iTicketsDao"%>
<%@page import="impDao.impTicketsDao"%>
<%@page import="org.owasp.esapi.ESAPI"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:Envia Tickets:.</title>
        <link rel="stylesheet" type="text/css" href="CSS/css1.css">
        <link rel="stylesheet" type="text/css" href="CSS/css2.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        
        
        <link type="text/css" rel="stylesheet" href="CSS/materialize.css" media="screen,projection">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
         <link href="https://fonts.googleapis.com/css?family=Cookie|Dancing+Script|Gochi+Hand|Pacifico|Oswald|Bree+Serif" rel="stylesheet">
         <script type="text/javascript" src="JAVASCRIPT/jquery-3.3.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script type="text/javascript" src="JAVASCRIPT/materialize.js"></script> 
        
         <script>
            $(document).ready(function () {
                $('select').formSelect();
            });
        </script>
    </head>
    <body>
        <%HttpSession sesion = request.getSession();
            String saludo = "";
            Date date = new Date();
            UsuarioN user =new UsuarioN(0, "", "", "", 0, "", "", date);
             String primerNav = "";
        String segundoNav = "";
            if(sesion.getAttribute("usuario")!= null){ 
                 primerNav = "Mi cuenta";
            segundoNav = "Cerrar Sesión";
                user = (UsuarioN) sesion.getAttribute("usuario");
            saludo = "Bienvenido "+ user.getNombre();
            }
            else{
                primerNav = "Mi cuenta";
                segundoNav = "Iniciar Sesión";
                saludo="Inicia Sesion";
                System.out.println("no hay sesion");
                out.println("<script>window.location = 'inicioSesion.jsp';</script>");
            }
           
          // ArrayList<Proyecto> list = py.consultaProyectosSinBuscar();
          // System.out.println(list.size());
        %>
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
                                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                    <a class="dropdown-item" href="enviaTickets.jsp">Tickets</a>
                                    
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
                    <%
        String btn = request.getParameter("enviar") == null ? "":request.getParameter("enviar");
        if(btn.equals("Enviar")){
            String asunto = ESAPI.encoder().encodeForHTML(request.getParameter("asunto"));
            String problema = ESAPI.encoder().encodeForHTML(request.getParameter("problema"));
            String tipo = ESAPI.encoder().encodeForHTML(request.getParameter("tipoProblema"));
            String receptor = "admin";
            
            Date fecha = new Date();
            int verifica;
            
           
            
                    
            
                
                iTicketsDao ti = new impTicketsDao();
                ticketsSoporte t = new ticketsSoporte(0, user.getBoleta(), receptor, problema, fecha, asunto, tipo);
                verifica =ti.realizaTicket(t);
                if(verifica != -1){
                    System.out.println("se envio");
                out.println("<script> alert('Ticket enviado con exito, un asesor tecnico estara trabando para resolver tu problema lo antes posible.'); "
                        + "window.location = 'index.jsp';</script>");
                
                }else{
                    System.out.println("no se envio");
                out.println("<script> alert('Error'); </script>");
                }
                
            
        }else{
            System.out.println("no ha enviado");
        }
    %>
    <h1 style="text-align: center">Tickets</h1>
        <p id="faq">En esta sección se encuentra el modulo de tickets donde podra registrar algun problema en el sistema que encuentre y este sera procesado por el administrador dentro de la mesa de ayuda</p>
        <div id="encapsRT">
                    <form method="post" class="formuRT" >
                        <div class="contenint">
                            <label>Asunto</label><input type="text" id="asunto" class="asunto" name="asunto" placeholder="Indique el asunto"> <br><br>
                            <label>Descripcion del problema</label><textarea placeholder="Realice una descripcion detallada del problema presentado" name="problema" ></textarea> <br><br>
                    <label>Tipo de Problema</label>
                    <select name="tipoProblema">
                        <option selected disabled>Selecciona el tipo de problema presentado</option>
                        <option value="Base de Datos">Base de Datos</option>
                        <option value="Fallo del sistema">Fallo del sistema</option>
                        <option value="Modulo Colaboradores">Modulo Colaboradores</option>
                        <option value="Modulo Donaciones">Modulo Donaciones</option>
                         <option value="Fallo al inicar sesión">Fallo al inicar sesión</option>
                    </select>
                    
                    <br><br>
                    <input type="submit" name="enviar" value="Enviar" id="registra"><br/><br/><br/>
                        </div>
                </form>
            <br/><br/>
            <p id="faq">Requieres ver el estado de tu reporte?<a href="misTickets.jsp">Haz click</a></p>
    </div>
            
                    
        <script type="text/javascript" src="JAVASCRIPT/Extras.js"></script>
        
   
    </body>
</html>
