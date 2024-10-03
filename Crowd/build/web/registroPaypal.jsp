<%-- 
    Document   : registroPaypal
    Created on : 11/11/2018, 04:30:01 PM
    Author     : Ricardo Palomino
--%>

<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="cifrado.CifrarSHA"%>
<%@page import="modelo.Paypal"%>
<%@page import="impDao.impPaypalDao"%>
<%@page import="dao.iPaypalDao"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="org.owasp.esapi.ESAPI"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CrowdFundingIPN</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="CSS/css2.css">
        <link rel="stylesheet" type="text/css" href="CSS/materialize.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script type="text/javascript" src="JAVASCRIPT/materialize.js"></script> 
        <script>
            $(document).ready(function () {
                $('select').formSelect();
            });
        </script>
        <script>
            $(document).ready(function () {
                $('input#input_text, textarea#textarea2').characterCounter();
            });
        </script>
    </head>
    <%
        HttpSession sesion = request.getSession();
            String saludo = "";
            UsuarioN user = null;
             String primerNav = "";
        String segundoNav = "";
            if(sesion.getAttribute("usuario")!= null){ 
                 primerNav = "Mi cuenta";
            segundoNav = "Cerrar Sesión";
                user = (UsuarioN) sesion.getAttribute("usuario");
            saludo = "Bienvenido "+ user.getNombre();
            }
            else{
                response.sendRedirect("inicioSesion.jsp");
                saludo="Inicia Sesion";
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
        
        <%
        String btn = request.getParameter("registra") == null ? "":request.getParameter("registra");
        if(btn.equals("Registrar")){
            
            String correoPP = ESAPI.encoder().encodeForHTML(request.getParameter("correopp"));
            String contraseñaPP = ESAPI.encoder().encodeForHTML(request.getParameter("pswdpp"));
             CifrarSHA cf = new CifrarSHA();
            int verifica;
                 String contraCifrada = new String(Base64.encodeBase64(cf.cifra(contraseñaPP)));
                iPaypalDao payp = new impPaypalDao();
                Paypal pp = new Paypal(0, correoPP, contraCifrada);
                verifica = payp.agregaPaypal(pp,user.getBoleta());
                if(verifica != -1){
                    System.out.println("Se guardo su método de pago");
                out.println("<script> alert('Método registrado con exito'); "
                        + "window.location = 'informacionUsuario.jsp';</script>");
                
                }else{
                    System.out.println("no se creo");
                out.println("<script> alert('Error Paypal no registrado'); </script>");
                }
                
            
        }else{
            System.out.println("no ha enviado");
        }
        %>
         <section class="tercero">
            <div class="posicion">
                <h1 class="letratitulo"><span class="title"><b>CREA UN PAYPAL</b></span></h1>
            </div>
            </section> 
        
        <div id="encaps3">
            <form method="post" class="formuC">
                <br><br><br>
                <div class="contenint">
                    <div class="input-field col s12">
                        <label>Correo Paypal</label><input type="email" placeholder="Escribe tu correo Paypal..." name="correopp" id="correopp" autofocus=""/>
            </div><br><br>
                    <div class="input-field col s12">
            <label>Contraseña</label><input type="password" placeholder="Escribe tu contraseña..." name="pswdpp" id="pswdpp"/>
                    </div>
            <br><br>
            <input type="submit" value="Registrar" name="registra" id="registra" />
            <br><br><br><br>
            </div>
        </form>
            </div>
    </body>
</html>