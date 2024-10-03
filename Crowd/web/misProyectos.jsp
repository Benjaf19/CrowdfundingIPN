<%-- 
    Document   : misProyectos
    Created on : 19/11/2018, 04:44:04 PM
    Author     : Benjamin
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="modelo.Proyecto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="impDao.impProyectoDao"%>
<%@page import="dao.iProyectoDao"%>
<%@page import="BD.ConexionBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html" charset=UTF-8">
        <title>.:Mis proyectos:.</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
       <link type="text/css" rel="stylesheet" href="CSS/materialize.css" media="screen,projection">
       <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
   <link href="https://fonts.googleapis.com/css?family=Cookie|Dancing+Script|Gochi+Hand|Pacifico" rel="stylesheet">
         <link rel="stylesheet" type="text/css" href="CSS/css1.css">
         <link href="https://fonts.googleapis.com/css?family=Bree+Serif|Oswald" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    
    </head>
    
    <body>
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
                        <img src="IMG/document-3268750_1920.jpg" alt="">
                        <div class="banderita">
                            <h2>Mis Proyectos</h2>
                            <p>En este modulo podras modificar tus proyectos y realizar diferentes acciones</p>

                        </div>
                    </div>
                    <section class="cajas">
            <section class="contenedor4">
                
            </section>
        </section>
                    <!--<section id="boxbutton">
                
                <div class="contenedor">
                    <div class="alignb">
                        <a href="proyectosApoyados.jsp" class="waves-effect waves-light btn-large grey"><i class="material-icons left">add_box</i>Proyectos a los que apoyas</a>
                    </div>
                </div>
                    </section>-->
                    <section id='despliegaproye2'>
            <div class="bandera">
        <%
            ConexionBase con = new  ConexionBase();
            con.coectarbd();
            iProyectoDao pro = new impProyectoDao();
           ArrayList<Proyecto> listaMisProyectos =  pro.consultaMisProyectos(user.getBoleta());
           double suma = 0;
           int tamaño = listaMisProyectos.size();
           if(tamaño>0){
           for (int i = 0; i < tamaño; i++) {
               suma = pro.cantidadRecaudada(listaMisProyectos.get(i).getIdProyecto());
               double porcentaje = (suma*100)/listaMisProyectos.get(i).getFinanciacion();
               ByteArrayOutputStream os = new ByteArrayOutputStream();
                        byte barray[] = new byte[1024];
                        int n = 0;
                        InputStream is = listaMisProyectos.get(i).getImagen();
                        while ((n = is.read(barray)) >= 0) {
                            os.write(barray, 0, n);
                        }
                        is.close();
                        byte[] bys = os.toByteArray();
                        byte[] encodedBytes = Base64.getEncoder().encode(bys);
                        String ruta = new String(encodedBytes, "UTF-8");
                         if(suma==0){
                   out.println(//"<div><h1>"+listaMisProyectos.get(i).getNombre()+"</h1>"
                          /* + "<h2>"+listaMisProyectos.get(i).getImagen()+"</br>"
                           + "Descripción: "+listaMisProyectos.get(i).getDescripcion()+"</br>"
                           + "Financiación: "+listaMisProyectos.get(i).getFinanciacion()+"</br>"
                           + "Plazo de tiempo: "+listaMisProyectos.get(i).getPlazotiempo()+"</br>"
                                   + "Recompensas : "+listaMisProyectos.get(i).getRecompensas()+"</br>"
                                   + "Categoria: "+listaMisProyectos.get(i).getCategoria()+"</br>"
                                           + "Cantidad recaudada: "+suma+""*/
                            "<div class='info-des'>"
                                + "<div class='card'>"
                                + "<div class='card-image waves-effect waves-block waves-light'>"
                                + "<img class='activator' src='data:image/jpg;base64," + ruta + "'>"
                                + "</div>"
                                + "<div class='card-content'>"
                                + "<span class='card-title activator grey-text text-darken-4' style='font-family: Bree Serif; font-size: 36px;'>" + listaMisProyectos.get(i).getNombre() + "<i class='material-icons right'>more_vert</i></span>"
                                + "<p><a href='#'>"
                                 + "<form action='editaProyecto.jsp' method='post'>"
                                        + "<input type='hidden' name='nombre' value='"+listaMisProyectos.get(i).getNombre()+"'/>"
                                           + "<input type='submit' name='Modifica' value='Modificar' class='Don'/>"
                                        + "</form>"
                                        + "<form method='post'><input type='hidden' name='nombre' value='"+listaMisProyectos.get(i).getNombre()+"'/>"
                                                           + "<input type='hidden' name='idProyecto' id='idProyecto' value='"+listaMisProyectos.get(i).getIdProyecto()+"'/>"
                                                           + "<input type='button' name='elimina' value='Eliminar' onclick='eliminaProyecto()' class='Don'/></form><br>"
                                + "</a></p>"
                                + "</div>"
                                + "<div class='card-reveal'>"
                                + "<span class='card-title grey-text text-darken-4' style='font-family: Bree Serif; font-size: 36px;'>" + listaMisProyectos.get(i).getNombre() + "<i class='material-icons right'>close</i></span>"
                                + "<p style='font-family: Oswald; font-size: 18px;'>" + listaMisProyectos.get(i).getDescripcion() + "<br>"
                                + "Financiación: " + listaMisProyectos.get(i).getFinanciacion() + " pesos mexicanos<br>"
                                + "Plazo de tiempo: " + listaMisProyectos.get(i).getPlazotiempo() + " días<br>"
                                + "Recompensas : " + listaMisProyectos.get(i).getRecompensas() + "<br>"
                                + "Categoría: " + listaMisProyectos.get(i).getCategoria() + "</p><br>"
                                        + "<p style='font-family: Oswald; font-size: 18px;'>Cantidad recaudada: "+suma+" pesos mexicanos</p>"
                                              + "<p style='font-family: Oswald; font-size: 18px;'>Progreso de fondeo: <div class='progress'><div class='progress-bar progress-bar-striped active' role='progressbar' aria-valuenow='"+suma+"' aria-valuemin='0' aria-valuemax='" + listaMisProyectos.get(i).getFinanciacion() + "' style='width:"+porcentaje+"%'>"+porcentaje+"%</div></div>"
                                + "</p>"
                                + "</div></div></div>"
                                                   
                           + "</h2>");
                         }else{
                                        out.println(//"<div><h1>"+listaMisProyectos.get(i).getNombre()+"</h1>"
                          /* + "<h2>"+listaMisProyectos.get(i).getImagen()+"</br>"
                           + "Descripción: "+listaMisProyectos.get(i).getDescripcion()+"</br>"
                           + "Financiación: "+listaMisProyectos.get(i).getFinanciacion()+"</br>"
                           + "Plazo de tiempo: "+listaMisProyectos.get(i).getPlazotiempo()+"</br>"
                                   + "Recompensas : "+listaMisProyectos.get(i).getRecompensas()+"</br>"
                                   + "Categoria: "+listaMisProyectos.get(i).getCategoria()+"</br>"
                                           + "Cantidad recaudada: "+suma+""*/
                            "<div class='info-des'>"
                                + "<div class='card'>"
                                + "<div class='card-image waves-effect waves-block waves-light'>"
                                + "<img class='activator' src='data:image/jpg;base64," + ruta + "'>"
                                + "</div>"
                                + "<div class='card-content'>"
                                + "<span class='card-title activator grey-text text-darken-4' style='font-family: Bree Serif; font-size: 36px;'>" + listaMisProyectos.get(i).getNombre() + "<i class='material-icons right'>more_vert</i></span>"
                                + "<p><a href='#'>"
                                 + "<form action='editaProyecto.jsp' method='post'>"
                                        + "<input type='hidden' name='nombre' value='"+listaMisProyectos.get(i).getNombre()+"'/>"
                                           + "<input type='submit' name='Modifica' value='Modificar' class='Don'/>"
                                        + "</form>"
                                        + "<form method='post'><input type='hidden' name='nombre' value='"+listaMisProyectos.get(i).getNombre()+"'/></form>"
                                + "</a></p>"
                                + "</div>"
                                + "<div class='card-reveal'>"
                                + "<span class='card-title grey-text text-darken-4' style='font-family: Bree Serif; font-size: 36px;'>" + listaMisProyectos.get(i).getNombre() + "<i class='material-icons right'>close</i></span>"
                                + "<p style='font-family: Oswald; font-size: 18px;'>" + listaMisProyectos.get(i).getDescripcion() + "<br>"
                                + "Financiación: " + listaMisProyectos.get(i).getFinanciacion() + " pesos mexicanos<br>"
                                + "Plazo de tiempo: " + listaMisProyectos.get(i).getPlazotiempo() + " días<br>"
                                + "Recompensas : " + listaMisProyectos.get(i).getRecompensas() + "<br>"
                                + "Categoría: " + listaMisProyectos.get(i).getCategoria() + "</p><br>"
                                        + "<p style='font-family: Oswald; font-size: 18px;'>Cantidad recaudada: "+suma+" pesos mexicanos</p>"
                                                + "<p style='font-family: Oswald; font-size: 18px;'>Progreso de fondeo: <div class='progress'><div class='progress-bar progress-bar-striped active' role='progressbar' aria-valuenow='"+suma+"' aria-valuemin='0' aria-valuemax='" + listaMisProyectos.get(i).getFinanciacion() + "' style='width:"+porcentaje+"%'>"+porcentaje+"%</div></div>"
                                + "</p>"
                                + "</div></div></div>"
                                                   
                           + "</h2>");            
                                                  }
                   
                                          
                                                   
                                           
                                           
                                                  
                                                   
               }
           }else{
                out.println("<script> alert('No tienes proyectos registrados aun');"
                        + "window.location = 'registraProyecto.jsp'; </script>");
                
}
            
        %>
        </div>
        </section>
        
       
        <script type="text/javascript" src="JAVASCRIPT/materialize.min.js"></script>
       
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

        <script src="JAVASCRIPT/Extras.js"></script>
    </body>
</html>
