<%-- 
    Document   : metodosPago
    Created on : 20/11/2018, 06:36:02 PM
    Author     : Benjamin
--%>

<%@page import="modelo.Tarjeta"%>
<%@page import="impDao.impTarjetaDao"%>
<%@page import="dao.iTarjetaDao"%>
<%@page import="modelo.Paypal"%>
<%@page import="java.util.ArrayList"%>
<%@page import="impDao.impPaypalDao"%>
<%@page import="dao.iPaypalDao"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:Metodos de pago:.</title>
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
    </head>
    <body >
        
        <%
        HttpSession sesion = request.getSession();
        Date fecha = new Date();
        String saludo = "";
        String primerNav = "";
        String segundoNav = "";
        UsuarioN user = new UsuarioN(0, "", "", "", 0, "", "",fecha) ;
        if (sesion.getAttribute("usuario") != null) {
            primerNav = "Mi cuenta";
            segundoNav = "Cerrar Sesión";
            user = (UsuarioN) sesion.getAttribute("usuario");
            saludo = "Bienvenido " + user.getNombre();
        }else {
            
            System.out.println("ke pasa");
           out.println("<script>window.location = 'inicioSesion.jsp';</script>");  
        }

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
                   <div id="banner">
            <img src="IMG/upicsa2.jpg" alt="">
            <div class="banderita">
                <h2>Metodos de Pago</h2>
                <p>En este modulo podras ingresar metodos de pago y visualizar tu informacion</p>

            </div>
        </div>
        <section class="cajas">
            <section class="contenedor4">
                <h4 class="titulo" style="text-align: center">Metodos de Pago: </h4>
            </section>
        </section>
        <section id="boxbutton">

            <div class="contenedor">
                <div class="alignb">
                    <div class="card-panel white darken-4">
                        <span class="black-text">PayPal:
                            <%
                                iPaypalDao pay = new impPaypalDao();
                                ArrayList<Paypal> list = new ArrayList<Paypal>();
                                list = pay.consultaPaypal(user.getBoleta());
                                for (int i = 0; i < list.size(); i++) {
                                    out.println("<h5 style='color:black;'>" + list.get(i).getCorreoPP() + "</h5><br>");
                                }

                            %>
                        </span>
                    </div>
                </div>
                <div class="alignb">
                    <div class="card-panel white darken-4">
                        <span class="black-text">Tarjetas:
                            <%                 iTarjetaDao tag = new impTarjetaDao();
                                ArrayList<Tarjeta> lista = new ArrayList<Tarjeta>();
                                lista = tag.consultaTarjeta(user.getBoleta());
                                String ntag ="";
                                for (int i = 0; i < lista.size(); i++) {
                                     ntag= lista.get(i).getNumTarjeta();
                                    out.println("<h5 style='color:black;'> **** **** **** " + ntag.substring(12) + "</h5><br>");
                                }

                            %>
                        </span>
                    </div>
                </div>

            </div>
        </section> 
        <br>
        <a href="registroPaypal.jsp" >
            <section class="servicio">
                <img src="IMG/paypal-784404.png" alt="">
                <div class="contenedor">
                    <h2>AGREGAR PAYPAL</h2>
                </div>
            </section>
        </a>
        <a href="registroTarjeta.jsp">
            <section class="servicio">
                <img src="IMG/ecommerce-2607114_1920.jpg" alt="">
                <div class="contenedor">
                    <h2>AGREGAR TARJETA</h2>
                </div>
            </section>
        </a>
        <!--<section id="boxbutton">

            <div class="contenedor">
                <div class="alignb">
                    <a href="registroPaypal.jsp" class="waves-effect waves-light btn-large grey"><i class="material-icons left">local_parking</i>AGREGA PAYPAL</a>
                </div>
                <div class="alignb">
                    <a href="registroTarjeta.jsp" class="waves-effect waves-light btn-large grey"><i class="material-icons left">call_to_action</i>AGREGA TARJETA</a>
                </div>

            </div>
        </section> -->





    </body>
</html>
