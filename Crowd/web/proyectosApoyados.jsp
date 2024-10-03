<%-- 
    Document   : proyectosApoyados
    Created on : 25/11/2018, 11:37:00 PM
    Author     : benja
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="impDao.impProyectoDao"%>
<%@page import="modelo.Proyecto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.iProyectoDao"%>
<%@page import="BD.ConexionBase"%>
<%@page import="modelo.UsuarioN"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:Apoyados:.</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="CSS/css1.css">
        <link href="https://fonts.googleapis.com/css?family=Bree+Serif|Oswald" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="CSS/materialize.css" media="screen,projection">
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
                    <section id='despliegaproye2'>
            <div class="bandera">
                    
                     <%
            ConexionBase con = new  ConexionBase();
            con.coectarbd();
            iProyectoDao pro = new impProyectoDao();
           ArrayList<Proyecto> listaMisProyectos =  pro.consultaProyectosApoyados(user.getBoleta());
           
          
           
           int tamaño = listaMisProyectos.size();
           if(tamaño>0){
           for (int i = 0; i < tamaño; i++) {
                double suma =pro.cantidadDonada(listaMisProyectos.get(i).getIdProyecto(), user.getBoleta());
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

                        out.println(""
                                + "<div class='info-des'>"
                                + "<div class='card'>"
                                + "<div class='card-image waves-effect waves-block waves-light'>"
                                + "<img class='activator' src='data:image/jpg;base64," + ruta + "'>"
                                + "</div>"
                                + "<div class='card-content'>"
                                + "<span class='card-title activator grey-text text-darken-4' style='font-family: Bree Serif; font-size: 36px;'>" + listaMisProyectos.get(i).getNombre() + "<i class='material-icons right'>more_vert</i></span>"
                                + "<p><a href='#'>"
                                
                                + "</a></p>"
                                + "</div>"
                                + "<div class='card-reveal'>"
                                + "<span class='card-title grey-text text-darken-4' style='font-family: Bree Serif; font-size: 36px;'>" + listaMisProyectos.get(i).getNombre() + "<i class='material-icons right'>close</i></span>"
                                + "<p style='font-family: Oswald; font-size: 18px;'>" + listaMisProyectos.get(i).getDescripcion() + "<br>"
                                + "Financiación: " + listaMisProyectos.get(i).getFinanciacion() + " pesos mexicanos<br>"
                                + "Plazo de tiempo: " + listaMisProyectos.get(i).getPlazotiempo() + " días<br>"
                                + "Recompensas : " + listaMisProyectos.get(i).getRecompensas() + "<br>"
                                + "Categoría: " + listaMisProyectos.get(i).getCategoria() + "<br>"
                                        + "Dinero con el que apoyas: "+suma+"</p>"
                                                + "<p style='font-family: Oswald; font-size: 18px;'>Progreso de fondeo: <div class='progress'><div class='progress-bar progress-bar-striped active' role='progressbar' aria-valuenow='"+suma+"' aria-valuemin='0' aria-valuemax='" + listaMisProyectos.get(i).getFinanciacion() + "' style='width:"+porcentaje+"%; height: 10px;'>"+porcentaje+"%</div></div>"
                                + "</p>"
                                + "</div></div></div>");

                        os.close();
                                          
                                                   
                                           
                                           
               }
           }else{
                out.println("<script> alert('No apoyas a ningún proyecto aún');"
                        + "window.location = 'proyecto.jsp'; </script>");
                
}
            
        %>
        </div>
        </section>
        <script type="text/javascript" src="JAVASCRIPT/materialize.min.js"></script>
        <script type="text/javascript" src="JAVASCRIPT/Extras.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

    </body>
</html>
