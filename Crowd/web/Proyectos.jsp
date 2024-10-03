<%-- 
    Document   : Proyectos
    Created on : 13/11/2018, 07:59:16 AM
    Author     : Alumno
--%>

<%@page import="modelo.Proyecto"%>
<%@page import="impDao.impProyectoDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.iProyectoDao"%>
<%@page import="modelo.UsuarioN"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="CSS/css1.css">
        <link type="text/css" rel="stylesheet" href="CSS/materialize.css" media="screen,projection">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    </head>
    <body>
        <%HttpSession sesion = request.getSession();
            String saludo = "";
            UsuarioN user ;
             String primerNav = "";
        String segundoNav = "";
            if(sesion.getAttribute("usuario")!= null){ 
                 primerNav = "Mi cuenta";
            segundoNav = "Cerrar Sesión";
                user = (UsuarioN) sesion.getAttribute("usuario");
            saludo = "Bienvenido "+ user.getNombre();
            }
            else{
                primerNav = "Iniciar Sesión";
                segundoNav = "Iniciar Sesión";
                saludo="Inicia Sesion";
            }
           iProyectoDao py = new impProyectoDao();
           ArrayList<Proyecto> list = py.consultaProyectosSinBuscar(user.getBoleta());
           System.out.println(list.size());
        %>
        
         <div class="card">
    <div class="card-image waves-effect waves-block waves-light">
        <img class="activator" src="IMG/nopart.jp">
    </div>
    <div class="card-content">
      <span class="card-title activator grey-text text-darken-4">Card Title<i class="material-icons right">more_vert</i></span>
      <p><a href="#">This is a link</a></p>
    </div>
    <div class="card-reveal">
      <span class="card-title grey-text text-darken-4">Card Title<i class="material-icons right">close</i></span>
      <p>Here is some more information about this product that is only revealed once clicked on.</p>
    </div>
  </div>
        <script type="text/javascript" src="JAVASCRIPT/materialize.min.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        
    </body>
</html>
