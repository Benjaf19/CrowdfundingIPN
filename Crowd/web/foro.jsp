<%-- 
    Document   : foro
    Created on : 30/03/2019, 07:59:25 PM
    Author     : benja
--%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Base64"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="modelo.foro"%>
<%@page import="java.util.ArrayList"%>
<%@page import="impDao.impForoDao"%>
<%@page import="dao.iForoDao"%>
<%@page import="java.util.Date"%>
<%@page import="modelo.UsuarioN"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Foro</title>
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
                            <h1 style="text-align: center">Foro de ayuda</h1><br/><br/>
                            <details style="width: 50%;margin: auto">
                                <summary >
                
                                    Tienes alguna duda? Agregala al foro para poder ayudarte
            </summary>
            <div id="encapsFORO">
                <form method="post" action="altaForo" enctype="multipart/form-data" class="formuRT">
                    <div class="contenint">
                        <label>Asunto</label><input type="text" name="asunto" placeholder="Coloca un encabezado"/><br>
                        <label>Pregunta o duda</label> <textarea name="preg" placeholder="Describe el problema o tu duda"></textarea><br>
                        <label>Categoria</label>
                        <select name="categ">
                    <option disabled selected>Selecciona una categoria</option>
                    <option > Fallo del sistema</option>
                    <option > Modulo Colaboradores</option>
                    <option > Modulo Proyectos</option>
                    <option > Modulo Usuario</option>
                                        <option > Modulo Donaciones</option>

                    
                </select><br>
                <label>Imagen</label>
                <input type="file" accept="image/*" name="foto"><br>
                <input type="submit" name="Subir" value="Subir " id="registra"/><br/><br/>
                </div>
            </form>
                </div>
        </details>
                            

        <br>
         <div id="encaps4">
       <form action="#" method="post" class="formuC">
    <div class="file-field input-field">
        <div class="btn" style="background: #6e1217;">
        <a class="btn-small transparent"><i class="material-icons">search</i></a>
        <input type="submit" name="envia" value="Buscar" id="Buscar" style="background: transparent;border: transparent;color: white;">
      </div>
      <div class="file-path-wrapper">
        <input class="file-path validate" type="text"  name="busca" placeholder="Busca por categoria, asunto, problema o creador del foro">
      </div>
    </div>
  </form>
           </div>
        <!--<form method="post">
            <input type="search" name="busca" placeholder="Busca por categoria, asunto, problema o creador del foro"/>
            <input type="submit" name="envia" value="Buscar"/>
        </form>-->
        <div id="encapsRT">
            <div class="formuFORO">

        <%
            String envia = request.getParameter("envia") == null ? "" : request.getParameter("envia");
            String busqueda = "";
            if (envia.equals("Buscar")) {
                busqueda = request.getParameter("busca");
            } else {

            }
            iForoDao fo = new impForoDao();
            ArrayList<foro> lista = new ArrayList<foro>();
            lista = fo.consultaForo(busqueda);
            for (int i = 0; i < lista.size(); i++) {
        %>
        
                <div class="col s12 m7">
            <div class="card horizontal" id="cardForo">
                <div class="card-image">
                    <%
                if (lista.get(i).getFoto() != null) {
                    ByteArrayOutputStream os = new ByteArrayOutputStream();
                    byte barray[] = new byte[1024];
                    int n = 0;
                    InputStream is = lista.get(i).getFoto();
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
                        <a href="consultaForo.jsp?idForo=<%=lista.get(i).getIdForo()%>"><h3 style="color: #6e1217;"><%=lista.get(i).getAsunto()%></h3></a>
            <p>Fecha: <%=lista.get(i).getFecha()%></p>  
            <p> De: <%=lista.get(i).getCreador()%> </p>
            <p >categoria: <%=lista.get(i).getCategoria()%></p>
            <p>Descripcion del problema: <%=lista.get(i).getPregunta()%></p>
                    </div>
                </div>
            </div>
        </div>
           

        
            
            
            <%
                } else {

                }
            %>


        



        <%
            }

        %>
         </div>
        </div>
    </body>
</html>
