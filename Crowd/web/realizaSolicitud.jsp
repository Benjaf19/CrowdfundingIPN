<%-- 
    Document   : realizaSolicitud
    Created on : 11/03/2019, 11:27:34 PM
    Author     : benja
--%>

<%@page import="impDao.impUsuarioNDao"%>
<%@page import="dao.iUsuarioNDao"%>
<%@page import="impDao.impColaboradorDao"%>
<%@page import="dao.iColaboradorDao"%>
<%@page import="modelo.Proyecto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="impDao.impProyectoDao"%>
<%@page import="dao.iProyectoDao"%>
<%@page import="java.util.Date"%>
<%@page import="modelo.UsuarioN"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Solicitud</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        
        <link rel="stylesheet" type="text/css" href="CSS/css2.css">
        <link type="text/css" rel="stylesheet" href="CSS/materialize.css" media="screen,projection">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
         <link href="https://fonts.googleapis.com/css?family=Cookie|Dancing+Script|Gochi+Hand|Pacifico" rel="stylesheet">
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
                    iProyectoDao pro = new impProyectoDao();
                    ArrayList<Proyecto> lista = new ArrayList<Proyecto>();
                    lista = pro.consultaMisProyectos(user.getBoleta());
                    int idC = Integer.parseInt(request.getParameter("idC"));
                    String envia = request.getParameter("Envia") == null? "" : request.getParameter("Envia");
                    if(envia.equals("Envia")){
                    int idP = Integer.parseInt(request.getParameter("proyecto"));
                    iColaboradorDao coll = new impColaboradorDao();
                    int ver=coll.realizaSolicitud(idC, idP, user.getBoleta());
                    iUsuarioNDao us = new impUsuarioNDao();
                    UsuarioN user2 = us.relColaborador(idC);
                    if(ver != -1){
                         System.out.println("se envio la solicitud");
                out.println("<script> alert('Solicitud enviada a "+user2.getNombre()+" "+user2.getApellidos()+"'); "
                        + "window.location = 'colaboradores.jsp';</script>");
                    }else{
                         System.out.println("nel no envio soli");
                out.println("<script> alert('Ha ocurrido un error'); "
                        + "window.location = 'colaboradores.jsp';</script>");
                    }
                    }else{
                        System.out.println("no ha enviado");
                    }
                    
                    %>
                    <div id="banner">
                        <img src="IMG/zacatenco5.jpg" alt="">
                <div class="banderita">
                <h2>Solicitud de Colaborador</h2>
                
                
                </div>
            </div>
                    <div id="encaps4">
                        <form method="post" class="formuC">
                            <div class="contenint">
                            <input type="hidden" name="idC" value="<%=idC%>"/>
                        <select name="proyecto">
                            <option disabled selected >Selecciona el proyecto donde quieres que se colabore</option>
                            <%
                            for (int i = 0; i < lista.size(); i++) {
                                    out.println("<option value='"+lista.get(i).getIdProyecto()+"'>"+lista.get(i).getNombre()+"</option>");
                                }
                            %>
                        </select>
                        <input type="submit" name="Envia" value="Envia" id="crear"/>
                    </div>
                        </form>
        </div>
    </body>
</html>
