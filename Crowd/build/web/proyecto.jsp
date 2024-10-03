<%-- 
    Document   : proyecto
    Created on : 21/11/2018, 11:31:50 AM
    Author     : Alumno
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.util.Date"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="modelo.Proyecto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="impDao.impProyectoDao"%>
<%@page import="dao.iProyectoDao"%>
<%@page import="dao.iPaypalDao"%>
<%@page import="BD.ConexionBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:Proyectos:.</title>

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
            Date facha = new Date();
            UsuarioN user = new UsuarioN(0, "", "", "", 0, "", "", facha);

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
            }
            iProyectoDao py = new impProyectoDao();
            ArrayList<Proyecto> list = py.consultaProyectosSinBuscar(user.getBoleta());

            System.out.println(list.size());
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
        <input type="submit" name="Buscar" value="Buscar" id="Buscar" style="background: transparent;border: transparent;color: white;">
      </div>
      <div class="file-path-wrapper">
        <input class="file-path validate" type="text"  name="criterio" id="criterio" placeholder="Busca un proyecto por nombre, categoria y/o descripción...">
      </div>
    </div>
  </form>
           </div>
        <section id='despliegaproye2'>
            <div class="bandera">
                <%
                    ConexionBase base = new ConexionBase();
                    base.coectarbd();
                    String envio = request.getParameter("Buscar") == null ? "" : request.getParameter("Buscar");
                    iProyectoDao pro = new impProyectoDao();
                    ArrayList<Proyecto> lista = new ArrayList<Proyecto>();
                    if (envio.equals("Buscar")) {
                        String palabra = request.getParameter("criterio");
                        lista = pro.consultaProyectos(palabra, user.getBoleta());
                    } else {

                        lista = pro.consultaProyectosSinBuscar(user.getBoleta());

                    }
                    double suma = 0;
                    for (int i = 0; i < lista.size(); i++) {
                        ByteArrayOutputStream os = new ByteArrayOutputStream();
                        byte barray[] = new byte[1024];
                        int n = 0;
                        InputStream is = lista.get(i).getImagen();
                        while ((n = is.read(barray)) >= 0) {
                            os.write(barray, 0, n);
                        }
                        is.close();
                        byte[] bys = os.toByteArray();
                        byte[] encodedBytes = Base64.getEncoder().encode(bys);
                        String ruta = new String(encodedBytes, "UTF-8");
                        suma = pro.cantidadRecaudada(lista.get(i).getIdProyecto());
                        double porcentaje = (suma*100)/lista.get(i).getFinanciacion();
                        out.println(""
                                + "<div class='info-des'>"
                                + "<div class='card'>"
                                + "<div class='card-image waves-effect waves-block waves-light'>"
                                + "<img class='activator' src='data:image/jpg;base64," + ruta + "'>"
                                + "</div>"
                                + "<div class='card-content'>"
                                + "<span class='card-title activator grey-text text-darken-4' style='font-family: Bree Serif; font-size: 36px;'>" + lista.get(i).getNombre() + "<i class='material-icons right'>more_vert</i></span>"
                                + "<p><a href='#'>"
                                + "<form action='registraDonaciones.jsp' method='post'>"
                                + "<input type='hidden' name='idProyecto' value='" + lista.get(i).getIdProyecto() + "'/>"
                                + "<input type='submit' name='Donar' id='donarS' value='Donar' class='Don'/>"
                                + "</form>"
                                + "</a></p>"
                                + "</div>"
                                + "<div class='card-reveal'>"
                                + "<span class='card-title grey-text text-darken-4' style='font-family: Bree Serif; font-size: 36px;'>" + lista.get(i).getNombre() + "<i class='material-icons right'>close</i></span>"
                                + "<p style='font-family: Oswald; font-size: 18px;'>" + lista.get(i).getDescripcion() + "<br>"
                                + "Financiación: " + lista.get(i).getFinanciacion() + " pesos mexicanos<br>"
                                + "Plazo de tiempo: " + lista.get(i).getPlazotiempo() + " días<br>"
                                + "Recompensas : " + lista.get(i).getRecompensas() + "<br>"
                                + "Categoría: " + lista.get(i).getCategoria() + "</p>"
                                        + "<p style='font-family: Oswald; font-size: 18px;'>Progreso de fondeo: <div class='progress'><div class='progress-bar progress-bar-striped active' role='progressbar' aria-valuenow='"+suma+"' aria-valuemin='0' aria-valuemax='" + lista.get(i).getFinanciacion() + "' style='width:"+porcentaje+"%; height: 10px;'>"+porcentaje+"%</div></div>"
                                + "</p>"
                                + "</div></div></div>");

                        os.close();
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