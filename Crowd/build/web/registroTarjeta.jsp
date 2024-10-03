<%-- 
    Document   : registroTarjeta
    Created on : 11/11/2018, 03:12:27 PM
    Author     : Ricardo Palomino
--%>

<%@page import="java.util.Calendar"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="org.owasp.esapi.ESAPI"%>
<%@page import="java.util.Date"%>
<%@page import="modelo.Tarjeta"%>
<%@page import="impDao.impTarjetaDao"%>
<%@page import="dao.iTarjetaDao"%>
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
        <script>
            $(document).ready(function () {
                $('.datepicker').datepicker();
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
        <%
           String btn = request.getParameter("registra") == null ? "":request.getParameter("registra");
           Calendar now = Calendar.getInstance();
           String fechaMin = now.get(Calendar.YEAR)+"-"+(now.get(Calendar.MONTH)+2);
           System.out.println(now.get(Calendar.YEAR)+"-"+(now.get(Calendar.MONTH)+1));
        if(btn.equals("Registrar")){
              String numTarjeta = "";
             
            try{
            numTarjeta= ESAPI.encoder().encodeForHTML( request.getParameter("numTarjeta"));
            System.out.println(numTarjeta);
            }catch(Exception E){
                    System.out.println("Error");
                    }
            int codigoSeg = Integer.parseInt(ESAPI.encoder().encodeForHTML(request.getParameter("codigoSeg")));
            String fechaVence = ESAPI.encoder().encodeForHTML(request.getParameter("fechaVence"));
            String Direccion = ESAPI.encoder().encodeForHTML(request.getParameter("Direccion"));
            String tipoTag = ESAPI.encoder().encodeForHTML(request.getParameter("tipoTag"));
            
            
            if((request.getParameter("codigoSeg").length()==3)&&(request.getParameter("numTarjeta").length()==16)){
            int verifica;
                
                iTarjetaDao tag = new impTarjetaDao();
                Tarjeta t = new Tarjeta(0, numTarjeta, codigoSeg, fechaVence, Direccion, tipoTag);
                verifica = tag.agregaTarjeta(t,user.getBoleta());
                if(verifica != -1){
                    System.out.println("Se guardo su método de pago");
                out.println("<script> alert('Método registrado con exito'); "
                        + "window.location = 'informacionUsuario.jsp';</script>");
                
                }else{
                    System.out.println("no se creo");
                out.println("<script> alert('Error método no registrado'); </script>");
                }
                
            }else{
                out.println("<script> alert('Los datos no tienen el formato correcto'); "
                        + "window.location = 'registroTarjeta.jsp';</script>");
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
        <section class="cuarto">
            <div class="posicion">
                <h1 class="letratitulo"><span class="title"><b>REGISTRA TU TARJETA</b></span></h1>
            </div>
            </section> 
        <div id="encaps3">
            <form methot="post" class="formuC">
                <br>
                <div class="contenint">
                    <div class="input-field col s12">
                        <label>Número Tarjeta</label><input type="text" placeholder="Escribe el número de tarjeta..." name="numTarjeta" id="numTarjeta" maxlength="16" minlength="16" autofocus=""/>
                    </div><br>
                    <div class="input-field col s12">
            <label>Código de Seguridad</label><input type="text" placeholder="Escribe el código de seguridad..." name="codigoSeg" id="codigoSeg" minlength="3" maxlength="3"/>
                    </div>
            <div class="input-field col s12">
                <label>Fecha de Vencimiento</label><br><br><input type="month" name="fechaVence" id="fechaVence"  min="<%=fechaMin%>" />
            </div><br>
       <div class="input-field col s12">
            <label>Dirección</label><input type="text" placeholder="Escribe tu dirección..." name="Direccion" id="Direccion"/>
            </div><br>
            <div class="input-field col s12">
            <!--<input type="text" placeholder="Escribe tipo tag..." name="tipoTag" id="tipoTag"/>-->
            <select name="tipoTag" id="tipoTag" >
                <option value="" disabled selected>Seleccione tu tipo de tarjeta</option>
                <option id="op1">Visa</option>
                <option id="op2">American Express</option>
                <option id="op3">Discover</option>
                <option id="op4">Mastercard</option>
            </select>
            <label>Tipo de Tarjeta</label>
            </div>
            <br>
            <input type="submit" value="Registrar" name="registra" id="registra" />
                </div>
            </form>
            </div>
        <script src="JAVASCRIPT/Extras.js"></script>
    </body>
</html>