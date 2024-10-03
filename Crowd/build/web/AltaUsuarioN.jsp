<%-- 
    Document   : AltaUsuario
    Created on : 20/09/2018, 08:39:34 PM
    Author     : Benjamin
--%>

<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="cifrado.CifrarSHA"%>
<%@page import="org.owasp.esapi.ESAPI"%>
<%@page import="java.util.Date"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="impDao.impUsuarioNDao"%>
<%@page import="dao.iUsuarioNDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:Registrate:.</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="CSS/css2.css">
        <link rel="stylesheet" type="text/css" href="CSS/materialize.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        
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
    <%-- <%HttpSession sesion = request.getSession();
            String saludo = "";
            if(sesion.getAttribute("usuario")!= null){ 
            saludo = "Bienvenido "+ sesion.getAttribute("usuario");
            }
            else{
                response.sendRedirect("login.jsp");
            }
            out.println(saludo);
        %> --%>
    <%HttpSession sesion = request.getSession();
            String saludo = "";
            Date date = new Date();
            UsuarioN user2 =new UsuarioN(0, "", "", "", 0, "", "", date);
             String primerNav = "";
        String segundoNav = "";
            if(sesion.getAttribute("usuario")!= null){ 
                 primerNav = "Mi cuenta";
            segundoNav = "Cerrar Sesión";
                user2 = (UsuarioN) sesion.getAttribute("usuario");
            saludo = "Bienvenido "+ user2.getNombre();
            }
            else{
                primerNav = "Mi cuenta";
                segundoNav = "Iniciar Sesión";
                saludo="Inicia Sesion";
            }
         
          // ArrayList<Proyecto> list = py.consultaProyectosSinBuscar();
          // System.out.println(list.size());
        %>
    <%
        String btn = request.getParameter("registra") == null ? "":request.getParameter("registra");
        if(btn.equals("Registrar")){
            int boleta = Integer.parseInt(ESAPI.encoder().encodeForHTML(request.getParameter("boleta")));
            String nombre = ESAPI.encoder().encodeForHTML(request.getParameter("nombre"));
            String apellidos = ESAPI.encoder().encodeForHTML(request.getParameter("ape"));
            String escuela = ESAPI.encoder().encodeForHTML(request.getParameter("escuela"));
            int edad = Integer.parseInt(ESAPI.encoder().encodeForHTML(request.getParameter("edad")));
            String contra = ESAPI.encoder().encodeForHTML(request.getParameter("contra"));
            String confcontra = ESAPI.encoder().encodeForHTML(request.getParameter("confcontra"));
            String correo = ESAPI.encoder().encodeForHTML(request.getParameter("correo"));
            Date fecha = new Date();
            int verifica;
            
            CifrarSHA cf = new CifrarSHA();
            
                    
            if(contra.equals(confcontra)){
                String contraCifrada = new String(Base64.encodeBase64(cf.cifra(contra)));
                iUsuarioNDao user = new impUsuarioNDao();
                UsuarioN u = new UsuarioN(boleta, nombre, apellidos, escuela, edad, correo, contraCifrada, fecha);
                
                verifica =user.agregaUsuario(u);
                if(verifica != -1){
                    System.out.println("se agrego");
                out.println("<script> alert('Usuario registrado con exito'); "
                        + "window.location = 'inicioSesion.jsp';</script>");
                
                }else{
                    System.out.println("no se agrego");
                out.println("<script> alert('Tu numero de boleta o el correo no estan disponibles'); </script>");
                }
                
            }else{
                out.println("<script> alert('Las contraseñas no coinciden'); </script>");
            }
        }else{
            System.out.println("no ha enviado");
        }
    %>
   <body >
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
        <section class="segundo">
            <div class="posicion">
                <h1 class="letratitulo"><span class="title"><b>CREA UNA CUENTA</b></span></h1>
            </div>
            </section> 
       
        <div id="encaps3">
            <form method="post" name="formu" class="formuB">
                <div class="contenint">
                    <br>
                    <div class="input-field col s12">
                        
                        <label>Boleta</label><input type="number" placeholder="Escribe tu boleta..." name="boleta" id="boleta" maxlength="10" minlength="10" autofocus=""/>
                </div>
                    <div class="input-field col s12">
            <label>Nombre</label><input type="text" placeholder="Escribe tu nombre..." name="nombre" id="nombre"/>
            </div>
            <div class="input-field col s12">
            <label>Apellidos</label><input type="text" placeholder="Escribe tus apellidos..." name="ape" id="ape"/>
            </div>
            <!--<label>Escuela</label><input type="text" placeholder="Escribe tu escuela..." name="escuela" id="escuela"/>
            <br>-->
            <div class="input-field col s12">
            <select name="escuela" id="escuela">
                <option value="" disabled selected>Seleccione tu escuela de procedencia</option>
                <option id="v1" >CECyT 1</option>
                <option id="v2" >CECyT 2</option>
                <option id="v3" >CECyT 3</option>
                <option id="v4" >CECyT 4</option>
                <option id="v5" >CECyT 5</option>
                <option id="v6" >CECyT 6</option>
                <option id="v7" >CECyT 7</option>
                <option id="v8" >CECyT 8</option>
                <option id="v9" >CECyT 9</option>
                <option id="v10" >CECyT 10</option>
                <option id="v11" >CECyT 11</option>
                <option id="v12" >CECyT 12</option>
                <option id="v13" >CECyT 13</option>
                <option id="v14" >CECyT 14</option>
                <option id="v15" >CECyT 15</option>
                <option id="c1" >CET 1</option>
            </select>
                <label>Escuela</label>
            </div>
            <div class="input-field col s12">
            <label>Edad</label><input type="number" placeholder="Escribe tu edad..." name="edad" id="edad"/>
            </div>
            <div class="input-field col s12">
            <label>Correo</label><input type="email" placeholder="Escribe tu correo..." name="correo" id="correo"/>
            </div>
            <div class="input-field col s12">
            <label>Contraseña</label><input type="password" placeholder="Escribe tu contraseña..." name="contra" id="contra"/>
            </div>
            <div class="input-field col s12">
            <label>Confirme Contraseña</label><input type="password" placeholder="Confirma tu contraseña..." name="confcontra" id="confcontra"/>
            </div>
            <input type="submit" value="Registrar" name="registra" id="registra"/><br/>
            <a href="inicioSesion.jsp">¿Ya tienes una cuenta?</a>
            </div>
        </form>
            </div>
    </body>
    
    
</html>
