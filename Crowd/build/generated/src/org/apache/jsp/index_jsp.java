package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.Date;
import java.util.Base64;
import java.io.InputStream;
import java.io.ByteArrayOutputStream;
import modelo.UsuarioN;
import modelo.UsuarioN;
import modelo.Proyecto;
import impDao.impProyectoDao;
import java.util.ArrayList;
import dao.iProyectoDao;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("          <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>CrowdFundingIPN</title>\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("  \n");
      out.write("        <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css\" integrity=\"sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO\" crossorigin=\"anonymous\">\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"CSS/css1.css\">\n");
      out.write("        <link type=\"text/css\" rel=\"stylesheet\" href=\"CSS/materialize.css\" media=\"screen,projection\">\n");
      out.write("        <link href=\"https://fonts.googleapis.com/icon?family=Material+Icons\" rel=\"stylesheet\">\n");
      out.write("         <link href=\"https://fonts.googleapis.com/css?family=Cookie|Dancing+Script|Gochi+Hand|Pacifico|Oswald|Bree+Serif\" rel=\"stylesheet\">\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");
HttpSession sesion = request.getSession();
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
        
      out.write("\n");
      out.write("        <!--MENU NAVEGADOR-->\n");
      out.write("        <header>\n");
      out.write("            \n");
      out.write("                <nav class=\"navbar navbar-expand-lg navbar-light bg-light\">\n");
      out.write("        <a class=\"navbar-brand\" href=\"http://www.ipn.mx/Paginas/inicio.aspx\">IPN</a>\n");
      out.write("        <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarNavDropdown\" aria-controls=\"navbarNavDropdown\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\n");
      out.write("            <span class=\"navbar-toggler-icon\"></span>\n");
      out.write("        </button>\n");
      out.write("        <div id=\"navbarNavDropdown\" class=\"navbar-collapse collapse\">\n");
      out.write("            <ul class=\"navbar-nav mr-auto\">\n");
      out.write("                <li class=\"nav-item active\">\n");
      out.write("                    <a class=\"nav-link\" href=\"index.jsp\">INICIO<span class=\"sr-only\">(current)</span></a>\n");
      out.write("                </li>\n");
      out.write("                <li class=\"nav-item\">\n");
      out.write("                    <a class=\"nav-link\" href=\"proyecto.jsp\">PROYECTOS</a>\n");
      out.write("                </li>\n");
      out.write("                \n");
      out.write("                <li class=\"nav-item\">\n");
      out.write("                    <a class=\"nav-link\" href=\"acercadenosotros.jsp\">ACERCA DE NOSOTROS</a>\n");
      out.write("                </li>\n");
      out.write("                <li class=\"nav-item\">\n");
      out.write("                    <a class=\"nav-link\" href=\"colaboradores.jsp\">COLABORADORES</a>\n");
      out.write("                            </li>\n");
      out.write("                            <li class=\"nav-item dropdown\">\n");
      out.write("                                <a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdownMenuLink\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n");
      out.write("                                   SOPORTE\n");
      out.write("                                </a>\n");
      out.write("                                <div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdownMenuLink\">\n");
      out.write("                                    <a class=\"dropdown-item\" href=\"faq.jsp\">FAQ</a>\n");
      out.write("                                    <a class=\"dropdown-item\" href=\"foro.jsp\">FORO</a>\n");
      out.write("                                    \n");
      out.write("                                    ");

                                    if(user.getBoleta()==2017090841){
                                        out.println("<a class='dropdown-item' href='contestaTicket.jsp'>Responde Ticket</a>");
                                    }else{
                                        out.println("<a class='dropdown-item' href='enviaTickets.jsp'>Tickets</a>");
                                    }
                                    
      out.write("\n");
      out.write("                                    \n");
      out.write("                                </div>\n");
      out.write("                               \n");
      out.write("                                    \n");
      out.write("                                    \n");
      out.write("                                \n");
      out.write("                            </li>\n");
      out.write("            </ul>\n");
      out.write("            <ul class=\"navbar-nav\">\n");
      out.write("                <li class=\"nav-item dropdown\">\n");
      out.write("                    <a class=\"nav-link dropdown-toggle\" href=\"#\" id=\"navbarDropdownMenuLink\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\n");
      out.write("                      ");
      out.print(saludo);
      out.write("\n");
      out.write("                    </a>\n");
      out.write("                    <div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdownMenuLink\">\n");
      out.write("                        <a class=\"dropdown-item\" href=\"informacionUsuario.jsp\">");
      out.print(primerNav);
      out.write("</a>\n");
      out.write("                                    <a class=\"dropdown-item\" href=\"logout\">");
      out.print(segundoNav);
      out.write("</a>\n");
      out.write("                    </div>\n");
      out.write("                </li>\n");
      out.write("                \n");
      out.write("            </ul>\n");
      out.write("        </div>\n");
      out.write("    </nav>\n");
      out.write("            \n");
      out.write("        </header>\n");
      out.write("        <!--VIDEO-->\n");
      out.write("        <object height=\"700vh\" width=\"100%\" data=\"videoObj.jsp\">\n");
      out.write("\n");
      out.write("        </object>\n");
      out.write("        <!--FAST OPTIONS-->\n");
      out.write("        <div id=\"opcs\">\n");
      out.write("            <div class=\"contenedor\">\n");
      out.write("                <div class=\"opc\">\n");
      out.write("                    <a href=\"registraColaborador.jsp\">\n");
      out.write("                        <img src=\"IMG/solidarity.png\" alt=\"\">\n");
      out.write("                        <h5 style=\"font-family:Gochi Hand; font-size: 30px;\">Ser Colaborador</h5>\n");
      out.write("                    </a>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"opc\">\n");
      out.write("                    <a href=\"registraProyecto.jsp\">\n");
      out.write("                        <img src=\"IMG/idea.png\" alt=\"\">\n");
      out.write("                        <h5 style=\"font-family:Gochi Hand; font-size: 30px;\">Crear Proyecto</h5>\n");
      out.write("                    </a>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"opc\">\n");
      out.write("                    <a href=\"misProyectos.jsp\">\n");
      out.write("                        <img src=\"IMG/projector.png\" alt=\"\">\n");
      out.write("                        <h5 style=\"font-family:Gochi Hand; font-size: 30px;\">Mis proyectos</h5>\n");
      out.write("                    </a>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"opc\">\n");
      out.write("                    <a href=\"metodosPago.jsp\">\n");
      out.write("                        <img src=\"IMG/credit-card.png\" alt=\"\">\n");
      out.write("                        <h5 style=\"font-family:Gochi Hand; font-size: 30px;\">Metodos de pago</h5>\n");
      out.write("                    </a>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <div id=\"despliegaproye\">\n");
      out.write("           <h5 style=\"font-family:Gochi Hand; font-size: 30px;text-align: center;\">Conoce los proyectos más populares</h5>\n");
      out.write("           <div class=\"bandera\">\n");
      out.write("       ");

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
       
      out.write("\n");
      out.write("           </div>\n");
      out.write("       </div>\n");
      out.write("         <section class=\"cajas2\">\n");
      out.write("            <section class=\"contenedor22\" id=\"about\">\n");
      out.write("                <section id=\"cont212\">\n");
      out.write("                    <h5 style=\"font-family:Oswald; font-size: 30px;color: black;text-align: center;\">¿Qué es el crowdfunding?...</h5>\n");
      out.write("                    <p class=\"texto \" style=\"font-family: Bree Serif;\"> El crowdfunding, es una red de financiación colectiva,normalmente online, que a través de donaciones económicas o de otro tipo, consiguen financiar un determinado proyecto a cambio de recompensas,<br/>\n");
      out.write("                        participaciones de forma altruista. Los proyectos para los que se utiliza el crowdfunding como fuente de financiación pueden ser muy variados: desde proyectos musicales o artísticos, <br/>\n");
      out.write("                        hasta campañas políticas, financiación de deudas, creación de escuelas o nacimiento de empresas, entre otros.</p>\n");
      out.write("                </section>    \n");
      out.write("                <div class=\"adjust2\">\n");
      out.write("                    <section class=\"adjust12\">\n");
      out.write("                        <img src=\"IMG/crowd.jpg\" alt=\"\">\n");
      out.write("                    </section>\n");
      out.write("                    <section class=\"adjust22\">\n");
      out.write("                        <p class=\"texto1 contenidoAlado\" style=\"font-family: Bree Serif;\">El emprendedor o creativo envía el proyecto a la web, indicando:\n");
      out.write("                            <br>\n");
      out.write("                            •\tDescripción <br>\n");
      out.write("                            •\tCantidad objetivo de financiamiento<br>\n");
      out.write("                            •\tTiempo de recaudación<br> \n");
      out.write("                            •\tRecompensas ofrecidas<br>\n");
      out.write("                            Posteriormente se publica el proyecto por un tiempo determinado (30,90,60,120 días)\n");
      out.write("                            Se promociona lo máximo posible utilizando diferentes recursos de mercadotecnia como fichas técnicas, fotografías, videos explicativos, videos del prototipo.\n");
      out.write("                        </p>\n");
      out.write("                    </section>\n");
      out.write("                </div>\n");
      out.write("            </section>    \n");
      out.write("        </section> \n");
      out.write("       <!--que es el crowd-->\n");
      out.write("        <!--<div id=\"bienvenidos\">\n");
      out.write("            <h2>¿Que es el CrowdFunding?</h2>\n");
      out.write("            <object data=\"carusel.html\" width=\"50%\" height=\"500px\">\n");
      out.write("                \n");
      out.write("            </object>\n");
      out.write("            <div class=\"contenedor\">\n");
      out.write("                <p>\n");
      out.write("                    El crowdfunding, es una red de financiación colectiva,normalmente online, que a través de donaciones económicas o de otro tipo, consiguen financiar un determinado proyecto a cambio de recompensas,<br/>\n");
      out.write("                    participaciones de forma altruista. Los proyectos para los que se utiliza el crowdfunding como fuente de financiación pueden ser muy variados: desde proyectos musicales o artísticos, <br/>\n");
      out.write("                    hasta campañas políticas, financiación de deudas, creación de escuelas o nacimiento de empresas, entre otros.<br/>\n");
      out.write("                </p>\n");
      out.write("            </div>\n");
      out.write("        </div>-->\n");
      out.write("        <!--<section id=\"blog\">\n");
      out.write("                <h3>Lo ultimo de nuestro blog</h3>\n");
      out.write("                <div class=\"contenedor\">\n");
      out.write("                    <article>\n");
      out.write("                        <img src=\"img/dibujo.jpg\" alt=\"\">\n");
      out.write("                        <h4>Escoge tu mascota perfecta</h4>\n");
      out.write("                    </article>\n");
      out.write("                    <article>\n");
      out.write("                        <img src=\"img/xd.jpg\" alt=\"\">\n");
      out.write("                        <h4>Los animales necesitan cariño</h4>\n");
      out.write("                    </article>\n");
      out.write("                    <article>\n");
      out.write("                        <img src=\"img/rule-1231705_1280.jpg\" alt=\"\">\n");
      out.write("                        <h4>Camina con tu mascota</h4>\n");
      out.write("                    </article> \n");
      out.write("                </div>\n");
      out.write("            </section>-->\n");
      out.write("       <!-- <section id=\"despliegaproye\">\n");
      out.write("            <h5>Conoce los proyectos recientes:</h5>\n");
      out.write("            <div class=\"bandera\">\n");
      out.write("\n");
      out.write("                <div class=\"info-des\">\n");
      out.write("                    <div class=\"card\">\n");
      out.write("                        <div class=\"card-image waves-effect waves-block waves-light\">\n");
      out.write("                            <img class=\"activator\" src=\"IMG/ipn-zacatenco.jpg\">\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"card-content\">\n");
      out.write("                            <span class=\"card-title activator grey-text text-darken-4\">Proyecto Ejemplo<i class=\"material-icons right\">more_vert</i></span>\n");
      out.write("                            <p><a href=\"#\">Conocer mas</a></p>\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"card-reveal\">\n");
      out.write("                            <span class=\"card-title grey-text text-darken-4\">Aqui va la descripcion del proyecto<i class=\"material-icons right\">close</i></span>\n");
      out.write("                            <p>Aqui va la descripcion del proyecto que eliga :)</p>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                 <div class=\"info-des\">\n");
      out.write("                    <div class=\"card\">\n");
      out.write("                        <div class=\"card-image waves-effect waves-block waves-light\">\n");
      out.write("                            <img class=\"activator\" src=\"IMG/cecyt13.jpg\">\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"card-content\">\n");
      out.write("                            <span class=\"card-title activator grey-text text-darken-4\">Proyecto Ejemplo<i class=\"material-icons right\">more_vert</i></span>\n");
      out.write("                            <p><a href=\"#\">Conocer mas</a></p>\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"card-reveal\">\n");
      out.write("                            <span class=\"card-title grey-text text-darken-4\">Aqui va la descripcion del proyecto<i class=\"material-icons right\">close</i></span>\n");
      out.write("                            <p>Aqui va la descripcion del proyecto que eliga :)</p>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"info-des\">\n");
      out.write("                    <div class=\"card\">\n");
      out.write("                        <div class=\"card-image waves-effect waves-block waves-light\">\n");
      out.write("                            <img class=\"activator\" src=\"IMG/esm.jpg\">\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"card-content\">\n");
      out.write("                            <span class=\"card-title activator grey-text text-darken-4\">Proyecto Ejemplo<i class=\"material-icons right\">more_vert</i></span>\n");
      out.write("                            <p><a href=\"#\">Conocer mas</a></p>\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"card-reveal\">\n");
      out.write("                            <span class=\"card-title grey-text text-darken-4\">Aqui va la descripcion del proyecto<i class=\"material-icons right\">close</i></span>\n");
      out.write("                            <p>Aqui va la descripcion del proyecto que eliga :)</p>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("               \n");
      out.write("            </div>\n");
      out.write("       \n");
      out.write("        </section>-->\n");
      out.write("       \n");
      out.write("       <!--contacto-->\n");
      out.write("        <!--<div id=\"contenido\">\n");
      out.write("            <div id=\"empareja\">\n");
      out.write("                <p>Contactanos</p>   \n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <div id=\"aparece\" style=\"align-items: center;\">\n");
      out.write("                <a class=\"btn-floating btn btn-large transparent\"  onclick=\"divAparece()\"><i class=\"material-icons\">arrow_drop_down</i></a>\n");
      out.write("            </div>\n");
      out.write("        </div>-->\n");
      out.write("        <!--<div id=\"caja\">\n");
      out.write("            <h1 style=\"text-align: center;color: black;\">Tanto online como por telefono</h1>\n");
      out.write("            <form action=\"\"  method=\"post\" class=\"form-register\" id=\"form-register\">\n");
      out.write("\n");
      out.write("                <div class=\"contenedor-inputs\">\n");
      out.write("                    <div class=\"row\">\n");
      out.write("\n");
      out.write("                        <br/>\n");
      out.write("                        <div class=\"input-field col s12\">\n");
      out.write("                            <input id=\"first_name\" type=\"text\" class=\"validate\" name=\"name\"  onlyread/>\n");
      out.write("                            <label for=\"first_name\">Nombre</label>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                    <br/>\n");
      out.write("                    <button class=\"btn waves-effect waves-light black\" type=\"submit\" name=\"action\">Registrar\n");
      out.write("                        <i class=\"material-icons right\">send</i>\n");
      out.write("                    </button>\n");
      out.write("                    <button class=\"btn waves-effect waves-light black\" type=\"reset\" name=\"action\">Borrar\n");
      out.write("                        <i class=\"material-icons right\">delete</i>\n");
      out.write("                    </button>\n");
      out.write("                    <br/>\n");
      out.write("                </div>\n");
      out.write("        </div>-->\n");
      out.write("       <!--footer-->\n");
      out.write("       <!--<footer>\n");
      out.write("            <div class=\"contenedor\">\n");
      out.write("                <p class=\"copy\">My pets &copy;2015</p>\n");
      out.write("                <div class=\"sociales\">\n");
      out.write("                    <a class=\"icon-facebook\" href=\"\"></a>\n");
      out.write("                    <a class=\"icon-twitter\" href=\"\"></a>\n");
      out.write("                    <a class=\"icon-instagram\" href=\"\"></a>\n");
      out.write("                    <a class=\"icon-gmail\" href=\"\"></a>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </footer>-->\n");
      out.write("        <!--<footer class=\"page-footer font-small black white-text\">\n");
      out.write("\n");
      out.write("            <!-- Copyright -->\n");
      out.write("            <!--<div class=\"footer-copyright text-center py-3\">© 2018 Novasoft S.A de C.V\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("            <!-- Copyright -->\n");
      out.write("\n");
      out.write("        <!--</footer>-->\n");
      out.write("          <script type=\"text/javascript\" src=\"JAVASCRIPT/materialize.min.js\"></script>\n");
      out.write("        <script type=\"text/javascript\" src=\"JAVASCRIPT/Extras.js\"></script>\n");
      out.write("        <script type=\"text/javascript\" src=\"https://code.jquery.com/jquery-3.2.1.min.js\"></script>\n");
      out.write("        \n");
      out.write("        <script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js\" integrity=\"sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49\" crossorigin=\"anonymous\"></script>\n");
      out.write("        <script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js\" integrity=\"sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy\" crossorigin=\"anonymous\"></script>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
