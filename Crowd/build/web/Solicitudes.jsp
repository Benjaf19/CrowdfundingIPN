<%-- 
    Document   : Solicitudes
    Created on : 12/03/2019, 09:32:33 PM
    Author     : benja
--%>

<%@page import="modelo.Colaborador"%>
<%@page import="java.util.ArrayList"%>
<%@page import="impDao.impColaboradorDao"%>
<%@page import="dao.iColaboradorDao"%>
<%@page import="java.util.Date"%>
<%@page import="modelo.UsuarioN"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Solicitudes</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="CSS/css2.css">
        <link rel="stylesheet" type="text/css" href="CSS/css1.css">
        <link href="https://fonts.googleapis.com/css?family=Cookie|Dancing+Script|Gochi+Hand|Pacifico|Oswald|Bree+Serif" rel="stylesheet">
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
    <body>
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
    <%
        iColaboradorDao col = new impColaboradorDao();
                        ArrayList<String> lista = new ArrayList<String>();
    
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
                         <img src="IMG/Nocturno ESIME 02.jpg" alt="">
            <div class="banderita">
                <h2>Solicutes Recibidas</h2>
               

            </div>
        </div>

                    <%
                        
                       
                         Colaborador colab = col.consultaColabBoleta(user.getBoleta());
                         if(colab!=null){
                             lista = col.consultaSolicitudRecibida(colab.getIdColaborador());
                             if(lista.size()>0){
                             for(int i = 0;i<lista.size();i++){
                             out.println(lista.get(i));
                             }
                             }else{
                                 System.out.println("No hay solicitudes");
                out.println("<script> alert('No tienes ninguna solicitud'); "
                        + "window.location = 'informacionUsuario.jsp';</script>");
                             }
                         }else{
                             System.out.println("No eres un colaborador");
                out.println("<script> alert('No eres un colaborador'); "
                        + "window.location = 'informacionUsuario.jsp';</script>");
                         }
                        
                    %>
    </body>
</html>
