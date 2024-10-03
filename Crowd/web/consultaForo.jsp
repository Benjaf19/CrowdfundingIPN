<%-- 
    Document   : consultaForo
    Created on : 30/03/2019, 11:38:27 PM
    Author     : benja
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.respuestaForo"%>
<%@page import="impDao.impRespuestaForoDao"%>
<%@page import="dao.iRespuestaForoDao"%>
<%@page import="org.owasp.esapi.ESAPI"%>
<%@page import="java.util.Base64"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="modelo.foro"%>
<%@page import="impDao.impForoDao"%>
<%@page import="dao.iForoDao"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FORO</title>
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
                response.sendRedirect("inicioSesion.jsp");
            }

            // ArrayList<Proyecto> list = py.consultaProyectosSinBuscar();
            // System.out.println(list.size());
        %>
        <!--MENU NAVEGADOR-->
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

                                <%                                        if (user.getBoleta() == 2017090841) {
                                        out.println("<a class='dropdown-item' href='contestaTicket.jsp'>Responde Ticket</a>");
                                    } else {
                                        out.println("<a class='dropdown-item' href='enviaTickets.jsp'>Tickets</a>");
                                    }
                                %>

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
            String idF = request.getParameter("idForo") == null ? "0" : request.getParameter("idForo");
            try {
                int idForo = Integer.parseInt(idF);
                String envia = request.getParameter("envia") == null ? "" : request.getParameter("envia");

                if (envia.equals("Responder")) {
                    String respuesta = ESAPI.encoder().encodeForHTML(request.getParameter("respuesta"));

                    iRespuestaForoDao res = new impRespuestaForoDao();
                    respuestaForo rf = null;
                    if(user.getBoleta()==2017090841){
                    rf = new respuestaForo(0, idForo, respuesta, user.getNombre() + " " + user.getApellidos()+" (Administrador)");
                    }else{
                       rf=  new respuestaForo(0, idForo, respuesta, user.getNombre() + " " + user.getApellidos());
                    }
                    int verifica = res.resspondeForo(rf);

                    if (verifica != -1) {
                        System.out.println("Respuesta enviada");
                        out.println("<script> alert('Respuesta enviada'); "
                                + "window.location = 'consultaForo.jsp?idForo=" + idForo + "';</script>");

                    } else {
                        System.out.println("Error");
                        out.println("<script> alert('Error'); "
                                + "window.location = 'consultaForo.jsp?idForo=" + idForo + "';</script>");
                    }
                } else {

                }

                if (idForo != 0) {
                    iForoDao fo = new impForoDao();
                    iRespuestaForoDao ress = new impRespuestaForoDao();
                    ArrayList<respuestaForo> lista = new ArrayList<respuestaForo>();
                    lista = ress.consultaRespuestas(idForo);
                    foro f = fo.consultaDeUno(idForo);
        %>
        <div id="encapsRT2">
            <div class="formuFORO">
                <div class="col s12 m7">
                    <div class="card horizontal" id="cardForo">
                        <div class="card-image">
                            <%
                                if (f.getFoto() != null) {
                                    ByteArrayOutputStream os = new ByteArrayOutputStream();
                                    byte barray[] = new byte[1024];
                                    int n = 0;
                                    InputStream is = f.getFoto();
                                    while ((n = is.read(barray)) >= 0) {
                                        os.write(barray, 0, n);
                                    }
                                    is.close();
                                    byte[] bys = os.toByteArray();
                                    byte[] encodedBytes = Base64.getEncoder().encode(bys);
                                    String ruta = new String(encodedBytes, "UTF-8");

                            %>

                            <img style="height: 250px; width: 250px;" src="data:image/jpg;base64,<%=ruta%>" alt="No hay fotos">
                        </div>
                        <div class="card-stacked">
                            <div class="card-content" id="cardInfoForo">
                                <a href="consultaForo.jsp?idForo=<%=f.getIdForo()%>"><h3><%=f.getAsunto()%></h3></a>
                                <p>Fecha: <%=f.getFecha()%></p>  
                                <p> De: <%=f.getCreador()%> </p>
                                <p >categoria: <%=f.getCategoria()%></p>
                                <p>Descripcion del problema: <%=f.getPregunta()%></p>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="encapsSol2">
            <div class="encuadSol3">
                <div class="contenint">
                    <form method="post">
                        <input type="text" name="respuesta" placeholder="Escribe una respuesta"/><br/>
                        <input type="hidden" name="idForo" value="<%=idForo%>"/>
                        <input type="submit"name="envia" value="Responder" id="registra" /><br/>

                    </form>
                </div>
            </div>
        </div>
        <!--<div>
            <a href="consultaForo.jsp?idForo=<%=f.getIdForo()%>"><h3><%=f.getAsunto()%></h3></a>
            <p>Fecha: <%=f.getFecha()%></p>  
            <p> De: <%=f.getCreador()%> </p>
            <p >categoria: <%=f.getCategoria()%></p>
            <p>Descripcion del problema: <%=f.getPregunta()%></p>
            </div>
            
        <img style="height: 200px; width: 200px;" src="data:image/jpg;base64,<%=ruta%>" alt="No hay fotos">-->

        <h3 style="text-align: center;">Respuestas: </h3>
        <div id="encapsSol2">  
            <div class="encuadSol2">
                <div class="contenint">
                    <%
                        for (int i = 0; i < lista.size(); i++) {
                            
                    %>
                    <p style="font-size: 20px;"><%=lista.get(i).getUsuario()%> respondio: <%=lista.get(i).getRespuesta()%>  </p> 


                    <%
                            }

                        } else {

                        }
                    %>
                </div>
            </div>
        </div>







        <%
                } else {
                    System.out.println("Es 0 no hay");
                    out.println("<script> alert('No existe el foro que buscas'); "
                            + "window.location = 'foro.jsp';</script>");

                }
            } catch (Exception e) {
                System.out.println(e.toString());
                out.println("<script> alert('No camnies la url ;)'); "
                        + "window.location = 'foro.jsp';</script>");
            }

        %>
    </body>
</html>
