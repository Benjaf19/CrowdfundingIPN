<%-- 
    Document   : contestaTicket
    Created on : 21/03/2019, 11:15:51 PM
    Author     : benja
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.ticketsSoporte"%>
<%@page import="impDao.impTicketsDao"%>
<%@page import="dao.iTicketsDao"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:Contesta Tickets:.</title>
      
        <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="CSS/css1.css">
        <link rel="stylesheet" type="text/css" href="CSS/css2.css">
        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Cookie|Dancing+Script|Gochi+Hand|Pacifico" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Bree+Serif|Oswald" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="CSS/materialize.css" media="screen,projection">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    </head>
    <body>
        <%HttpSession sesion = request.getSession();
            String saludo = "";
            Date date = new Date();
            UsuarioN user = new UsuarioN(0, "", "", "", 0, "", "", date);
            String primerNav = "";
            String segundoNav = "";
            if (sesion.getAttribute("usuario") != null) {
                primerNav = "Mi cuenta";
                segundoNav = "Cerrar Sesión";
                user = (UsuarioN) sesion.getAttribute("usuario");
                saludo = "Bienvenido " + user.getNombre();
                if (user.getBoleta() == 2017090841) {
                    System.out.println("yes");
                } else {
                    out.println("<script>alert('No tienes acceso a esta página');"
                            + "window.location = 'index.jsp';</script>");
                }
            } else {
                primerNav = "Mi cuenta";
                segundoNav = "Iniciar Sesión";
                saludo = "Inicia Sesion";
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
        <section class="cajas">
            <section class="contenedor4">
                <h4 class="titulo" style="text-align: center">Realiza la busqueda deseada: </h4>
            </section>
        </section>
        <div id="encaps4">
            <form action="#" method="post" class="formuC">
                <div class="file-field input-field">
                    <div class="btn" style="background: #6e1217;">
                        <a class="btn-small transparent"><i class="material-icons">search</i></a>
                        <input type="submit" name="busca" value="Buscar" id="Buscar" style="background: transparent;border: transparent;color: white;">
                    </div>
                    <div class="file-path-wrapper">
                        <input class="file-path validate" type="text"  name="folio" placeholder="Busque su ticket con el numero de folio o estado del ticket">
                    </div>
                </div>
            </form>
        </div>

        <!--<form method="post" >
            <input type="search" name="folio" placeholder="Busque su ticket con el numero de folio o estado del ticket" />
            <input type="submit" name="busca" value="Buscar"/>
        </form>-->

        <%
            String folio = request.getParameter("folio") == null ? "" : request.getParameter("folio");

            iTicketsDao ti = new impTicketsDao();
            ArrayList<ticketsSoporte> lista = new ArrayList<ticketsSoporte>();

            lista = ti.consultaTodos(folio);
            if (lista.size() != 0) {
                for (int i = 0; i < lista.size(); i++) {

                    out.println("<div id='opcsTXT'>"
                                       + "<div class='contenedor'>"
                                       + "<div class='opc'>"
                            +"<form method='post' action='editaTicket.jsp'><input type='submit'  id='ticks' name='folio' value='" + lista.get(i).getFolio() + "'/></form>"
                             + "</div>"
                                               + "</div>"
                                               + "</div>");
                }
            } else {
                System.out.println("vacio tickets");
                out.println("<p>No hay resultados de la búsqueda</p>");

            }

            /*System.out.println("no hay folio");
            out.println("<script> alert('No existe ese folio'); "
                    + "window.location = 'misTickets.jsp';</script>");*/

        %>


        <script type="text/javascript" src="JAVASCRIPT/materialize.min.js"></script>
        <script type="text/javascript" src="JAVASCRIPT/Extras.js"></script>
        

    </body>
</html>
