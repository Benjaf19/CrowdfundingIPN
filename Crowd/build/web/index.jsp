<%-- 
    Document   : index
    Created on : 8/11/2018, 08:21:35 PM
    Author     : juano
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.Base64"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="modelo.Proyecto"%>
<%@page import="impDao.impProyectoDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.iProyectoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
          <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CrowdFundingIPN</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
  
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="CSS/css1.css">
        <link type="text/css" rel="stylesheet" href="CSS/materialize.css" media="screen,projection">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
         <link href="https://fonts.googleapis.com/css?family=Cookie|Dancing+Script|Gochi+Hand|Pacifico|Oswald|Bree+Serif" rel="stylesheet">

    </head>
    <body>
        <%HttpSession sesion = request.getSession();
            String saludo = "";
            Date date = new Date();
            UsuarioN user =new UsuarioN(0, "", "", "", 0, "", "", date);
             String primerNav = "";
        String segundoNav = "";
            if(sesion.getAttribute("usuario")!= null){ 
                 primerNav = "Mi cuenta";
            segundoNav = "Cerrar Sesión";
                user = (UsuarioN) sesion.getAttribute("usuario");
            saludo = "Bienvenido "+ user.getNombre();
            }
            else{
                primerNav = "Mi cuenta";
                segundoNav = "Iniciar Sesión";
                saludo="Inicia Sesion";
            }
           iProyectoDao py = new impProyectoDao();
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
                                    <a class="dropdown-item" href="foro.jsp">FORO</a>
                                    
                                    <%
                                    if(user.getBoleta()==2017090841){
                                        out.println("<a class='dropdown-item' href='contestaTicket.jsp'>Responde Ticket</a>");
                                    }else{
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
        <!--VIDEO-->
        <object height="700vh" width="100%" data="videoObj.jsp">

        </object>
        <!--FAST OPTIONS-->
        <div id="opcs">
            <div class="contenedor">
                <div class="opc">
                    <a href="registraColaborador.jsp">
                        <img src="IMG/solidarity.png" alt="">
                        <h5 style="font-family:Gochi Hand; font-size: 30px;">Ser Colaborador</h5>
                    </a>
                </div>
                <div class="opc">
                    <a href="registraProyecto.jsp">
                        <img src="IMG/idea.png" alt="">
                        <h5 style="font-family:Gochi Hand; font-size: 30px;">Crear Proyecto</h5>
                    </a>
                </div>
                <div class="opc">
                    <a href="misProyectos.jsp">
                        <img src="IMG/projector.png" alt="">
                        <h5 style="font-family:Gochi Hand; font-size: 30px;">Mis proyectos</h5>
                    </a>
                </div>
                <div class="opc">
                    <a href="metodosPago.jsp">
                        <img src="IMG/credit-card.png" alt="">
                        <h5 style="font-family:Gochi Hand; font-size: 30px;">Metodos de pago</h5>
                    </a>
                </div>
            </div>
        </div>
        <div id="despliegaproye">
           <h5 style="font-family:Gochi Hand; font-size: 30px;text-align: center;">Conoce los proyectos más populares</h5>
           <div class="bandera">
       <%
       iProyectoDao pro = new impProyectoDao();
                    ArrayList<Proyecto> lista = new ArrayList<Proyecto>();
                    
                        

                        lista = pro.consultaPopulares(user.getBoleta());

                    double suma = 0;
                    for (int i = 0; i < lista.size(); i++) {
                        suma = pro.cantidadRecaudada(lista.get(i).getIdProyecto());
               double porcentaje = (suma*100)/lista.get(i).getFinanciacion();
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
                                        + "<p style='font-family: Oswald; font-size: 18px;'>Progreso de fondeo: <div class='progress'><div class='progress-bar progress-bar-striped active' role='progressbar' aria-valuenow='"+suma+"' aria-valuemin='0' aria-valuemax='" + lista.get(i).getFinanciacion() + "' style='width:"+porcentaje+"%'>"+porcentaje+"%</div></div>"
                                
                                + "</p>"
                                + "</div></div></div>");

                        os.close();
                    }
       %>
           </div>
       </div>
         <section class="cajas2">
            <section class="contenedor22" id="about">
                <section id="cont212">
                    <h5 style="font-family:Oswald; font-size: 30px;color: black;text-align: center;">¿Qué es el crowdfunding?...</h5>
                    <p class="texto " style="font-family: Bree Serif;"> El crowdfunding, es una red de financiación colectiva,normalmente online, que a través de donaciones económicas o de otro tipo, consiguen financiar un determinado proyecto a cambio de recompensas,<br/>
                        participaciones de forma altruista. Los proyectos para los que se utiliza el crowdfunding como fuente de financiación pueden ser muy variados: desde proyectos musicales o artísticos, <br/>
                        hasta campañas políticas, financiación de deudas, creación de escuelas o nacimiento de empresas, entre otros.</p>
                </section>    
                <div class="adjust2">
                    <section class="adjust12">
                        <img src="IMG/crowd.jpg" alt="">
                    </section>
                    <section class="adjust22">
                        <p class="texto1 contenidoAlado" style="font-family: Bree Serif;">El emprendedor o creativo envía el proyecto a la web, indicando:
                            <br>
                            •	Descripción <br>
                            •	Cantidad objetivo de financiamiento<br>
                            •	Tiempo de recaudación<br> 
                            •	Recompensas ofrecidas<br>
                            Posteriormente se publica el proyecto por un tiempo determinado (30,90,60,120 días)
                            Se promociona lo máximo posible utilizando diferentes recursos de mercadotecnia como fichas técnicas, fotografías, videos explicativos, videos del prototipo.
                        </p>
                    </section>
                </div>
            </section>    
        </section> 
       <!--que es el crowd-->
        <!--<div id="bienvenidos">
            <h2>¿Que es el CrowdFunding?</h2>
            <object data="carusel.html" width="50%" height="500px">
                
            </object>
            <div class="contenedor">
                <p>
                    El crowdfunding, es una red de financiación colectiva,normalmente online, que a través de donaciones económicas o de otro tipo, consiguen financiar un determinado proyecto a cambio de recompensas,<br/>
                    participaciones de forma altruista. Los proyectos para los que se utiliza el crowdfunding como fuente de financiación pueden ser muy variados: desde proyectos musicales o artísticos, <br/>
                    hasta campañas políticas, financiación de deudas, creación de escuelas o nacimiento de empresas, entre otros.<br/>
                </p>
            </div>
        </div>-->
        <!--<section id="blog">
                <h3>Lo ultimo de nuestro blog</h3>
                <div class="contenedor">
                    <article>
                        <img src="img/dibujo.jpg" alt="">
                        <h4>Escoge tu mascota perfecta</h4>
                    </article>
                    <article>
                        <img src="img/xd.jpg" alt="">
                        <h4>Los animales necesitan cariño</h4>
                    </article>
                    <article>
                        <img src="img/rule-1231705_1280.jpg" alt="">
                        <h4>Camina con tu mascota</h4>
                    </article> 
                </div>
            </section>-->
       <!-- <section id="despliegaproye">
            <h5>Conoce los proyectos recientes:</h5>
            <div class="bandera">

                <div class="info-des">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="IMG/ipn-zacatenco.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Proyecto Ejemplo<i class="material-icons right">more_vert</i></span>
                            <p><a href="#">Conocer mas</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Aqui va la descripcion del proyecto<i class="material-icons right">close</i></span>
                            <p>Aqui va la descripcion del proyecto que eliga :)</p>
                        </div>
                    </div>
                </div>
                 <div class="info-des">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="IMG/cecyt13.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Proyecto Ejemplo<i class="material-icons right">more_vert</i></span>
                            <p><a href="#">Conocer mas</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Aqui va la descripcion del proyecto<i class="material-icons right">close</i></span>
                            <p>Aqui va la descripcion del proyecto que eliga :)</p>
                        </div>
                    </div>
                </div>
                <div class="info-des">
                    <div class="card">
                        <div class="card-image waves-effect waves-block waves-light">
                            <img class="activator" src="IMG/esm.jpg">
                        </div>
                        <div class="card-content">
                            <span class="card-title activator grey-text text-darken-4">Proyecto Ejemplo<i class="material-icons right">more_vert</i></span>
                            <p><a href="#">Conocer mas</a></p>
                        </div>
                        <div class="card-reveal">
                            <span class="card-title grey-text text-darken-4">Aqui va la descripcion del proyecto<i class="material-icons right">close</i></span>
                            <p>Aqui va la descripcion del proyecto que eliga :)</p>
                        </div>
                    </div>
                </div>
                
               
            </div>
       
        </section>-->
       
       <!--contacto-->
        <!--<div id="contenido">
            <div id="empareja">
                <p>Contactanos</p>   
            </div>

            <div id="aparece" style="align-items: center;">
                <a class="btn-floating btn btn-large transparent"  onclick="divAparece()"><i class="material-icons">arrow_drop_down</i></a>
            </div>
        </div>-->
        <!--<div id="caja">
            <h1 style="text-align: center;color: black;">Tanto online como por telefono</h1>
            <form action=""  method="post" class="form-register" id="form-register">

                <div class="contenedor-inputs">
                    <div class="row">

                        <br/>
                        <div class="input-field col s12">
                            <input id="first_name" type="text" class="validate" name="name"  onlyread/>
                            <label for="first_name">Nombre</label>
                        </div>
                    </div>
                    <br/>
                    <button class="btn waves-effect waves-light black" type="submit" name="action">Registrar
                        <i class="material-icons right">send</i>
                    </button>
                    <button class="btn waves-effect waves-light black" type="reset" name="action">Borrar
                        <i class="material-icons right">delete</i>
                    </button>
                    <br/>
                </div>
        </div>-->
       <!--footer-->
       <!--<footer>
            <div class="contenedor">
                <p class="copy">My pets &copy;2015</p>
                <div class="sociales">
                    <a class="icon-facebook" href=""></a>
                    <a class="icon-twitter" href=""></a>
                    <a class="icon-instagram" href=""></a>
                    <a class="icon-gmail" href=""></a>
                </div>
            </div>
        </footer>-->
        <!--<footer class="page-footer font-small black white-text">

            <!-- Copyright -->
            <!--<div class="footer-copyright text-center py-3">© 2018 Novasoft S.A de C.V

            </div>
            <!-- Copyright -->

        <!--</footer>-->
          <script type="text/javascript" src="JAVASCRIPT/materialize.min.js"></script>
        <script type="text/javascript" src="JAVASCRIPT/Extras.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>
