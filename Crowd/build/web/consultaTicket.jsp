<%-- 
    Document   : consultaTicket
    Created on : 18/03/2019, 10:43:38 PM
    Author     : benja
--%>

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
        <title>.:ConsultaTicket:.</title>
        <link rel="stylesheet" type="text/css" href="CSS/css1.css">
        <link rel="stylesheet" type="text/css" href="CSS/css2.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

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
            String folio = request.getParameter("folio");
            String color = "black";
            if (folio != null) {
                int folior = Integer.parseInt(folio);
                iTicketsDao ti = new impTicketsDao();
                ticketsSoporte t = ti.consultaTicket(folior);
                if (t.getEstado().equals("Pendiente")) {
                    color = "red";

                } else {
                    if (t.getEstado().equals("En proceso")) {
                        color = "yellow";
                    } else {
                        color = "green";
                    }
                }

        %>

           <h1 style="text-align: center;margin-top: 4%;">Informacion del Ticket</h1>
        <div id="encapsSol">
            <div class="encuadSol">
                <div class="contenint">
                    <h3>
                        Folio del ticket: <%=t.getFolio()%>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Asunto:         <%=t.getAsunto()%>
                    </h3>
                    <div class="row">
                        <div class="input-field col s12">
                            <table width='100%' class='responsive-table'>
                                <thead>
                                    <tr>
                                        
                                        <th>Fecha</th>
                                        <th>Responsable</th>
                                        <th>Categoria</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <tr>
                                        <td><%=t.getFecha()%></td>
                                        <td><%=t.getReceptor()%></td>
                                        <td><%=t.getTipoProblema()%></td>
                                    </tr>
                                    
                                </tbody>
                                 <thead>
                                    <tr>
                                        
                                        <th>Estado</th>
                                        <th>Descripcion del problema</th>
                                        <th>Solucion personal tecnico</th>
                                    </tr>
                                </thead>
                                 <tbody>
                                    <tr>
                                        <td style="background-color:  <%=color%>;"><%=t.getEstado()%></td>
                                        <td><%=t.getProblema()%></td>
                                        <td><%=t.getAvance()%></td>
                                    </tr>
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <!--<h1 style="text-align: center">Informacion del Ticket</h1>
        <div id="encapsSol">
            <div class="encuadSol">
                <div class="contenint">
                    <h3>
                        <%=t.getAsunto()%>
                    </h3>
                    <p>Fecha: <%=t.getFecha()%></p>
                    <p>Responsable: <%=t.getReceptor()%></p>
                    <p>Categoria: <%=t.getTipoProblema()%></p>
                    <p style="background-color:  <%=color%>;">Estado: <%=t.getEstado()%></p>
                </div>
            </div>
        </div>
        <h1 style="text-align: center">Descripcion del Problema</h1>
        <div id="encapsSol2">
            <div class="encuadSol2">
                <div class="contenint">
                    <p><%=t.getProblema()%></p>
                </div>
            </div>
        </div>
        <h1 style="text-align: center">Solucion del personal tecnico</h1>
        <div id="encapsSol2">
            <div class="encuadSol3">
                <div class="contenint">
                    <p><%=t.getAvance()%></p>
                </div>
            </div>
        </div>-->



        <%
            } else {
                System.out.println("no hay folio");
                out.println("<script> alert('No existe ese folio'); "
                        + "window.location = 'misTickets.jsp';</script>");
            }
        %>
    </body>
</html>
