<%-- 
    Document   : faq
    Created on : 16/02/2019, 11:19:34 PM
    Author     : benja
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.faqs"%>
<%@page import="impDao.impfaqDao"%>
<%@page import="dao.ifaqDao"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="BD.ConexionBase"%>
<%@page import="org.owasp.esapi.ESAPI"%>
<%@page import="impDao.impProyectoDao"%>
<%@page import="dao.iProyectoDao"%>
<%@page import="modelo.UsuarioN"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FAQ</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="CSS/css1.css">
        <link type="text/css" rel="stylesheet" href="CSS/materialize.css" media="screen,projection">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Cookie|Dancing+Script|Gochi+Hand|Pacifico" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Josefin+Sans" rel="stylesheet">
    </head>
    <body>
        <%HttpSession sesion = request.getSession();
            String saludo = "";
            UsuarioN user;
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
            // ArrayList<Proyecto> list = py.consultaProyectosSinBuscar();
            // System.out.println(list.size());
        %>
        <%
            String preguntanew = "";
            String respu = "";
            String btn = request.getParameter("Envia") == null ? "" : request.getParameter("Envia");
            if (btn.equals("Envia")) {
                String prepreg = request.getParameter("nuevafaq");
                int caracter = 0;
                for (int i = 0; i < prepreg.length(); i++) {
                    if (prepreg.charAt(i) == '¿' || prepreg.charAt(i) == '?' || prepreg.charAt(i) == 'Â') {
                        caracter = 1;
                        break;
                    } else {
                        caracter = 0;
                    }
                }
                if (caracter == 0) {
                    String pregunta = ESAPI.encoder().encodeForHTML(request.getParameter("nuevafaq"));
                    System.out.println(pregunta);
                    System.out.println(prepreg);
                    if(!pregunta.isEmpty()){
                    int verifica = 0;
                    try {
                        ifaqDao fq = new impfaqDao();
                        faqs f = new faqs(0, pregunta, "Pendiente");
                        verifica = fq.agregaFAQ(f);
                        if (verifica != -1) {
                            System.out.println("agregado");
                            out.print("<script>alert('Pregunta enviada');"
                                    + "window.location='faq.jsp';</script>");
                        } else {
                            System.out.println("ups");
                            out.print("<script>alert('ups');"
                                    + "window.location='faq.jsp';</script>");
                        }
                        /* ConexionBase con = new ConexionBase();
                    CallableStatement sta ,sta2;
                Connection cnx = con.coectarbd();
               
                ResultSet res ;
                try{
                     sta= cnx.prepareCall("insert into faqs values(1,'"+pregunta+"','Respuesta pendiente');");
                     cnx= sta.getConnection();
                     sta.executeUpdate();*/

                    } catch (Exception e) {
                        System.out.println(e.toString());

                    }
                    }else{
                        System.out.println("vacio");
                    out.print("<script>alert('Intruduzca una pregunta');"
                            + "window.location='faq.jsp';</script>");
                    }

                } else {
                    System.out.println("signo detectado");
                    out.print("<script>alert('No introduzcas signos porfavor');"
                            + "window.location='faq.jsp';</script>");
                }

            } else {

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
                           
                            
                            
        <h1 style="text-align: center">Preguntas Frecuentes</h1>
        <p id="faq">En esta sección se encuentran las preguntas mas frecuentes sobre la página, aquí podrás encontrar información si tienes alguna duda, así como también podrás realizar alguna pregunta si tus dudas no se resuelven con la información que se encuentra aquí.</p>
        <div id="faq">
        
            <h4>Cuenta</h4>
            
            <details> 
                <summary> 
                    ¿Cómo crear una cuenta?
                </summary>
                <p>Al entrar en nuestra página puedes crear tu cuenta dando clic en “¿No tienes una cuenta?”, y automáticamente te manda al registro de tus datos, te das de alta y listo.</p>

            </details>
            
            <details> 
                <summary> 
                    ¿Cómo puedo recuperar mi contraseña en caso de que no la recuerde?
                </summary>
                <p>Es muy sencillo, solo tienes que dar clic en “¿Has olvidado tu contraseña?” y poner el correo electrónico con el cual te registraste. 
                    Posteriormente te llegará un correo electrónico al cual solo tienes que hacer clic en la liga y a continuación podrás ingresar tu nueva contraseña.</p>

            </details>
            
            <details> 
                <summary> 
                    ¿Puedo puedo cambiar los datos personales de mi perfil?
                </summary>
                <p>Si, dentro de “Mi Cuenta”, solo debes hacer clic en “Modificar”, y podrás modificar toda la 
                    información de tu perfil que desees, y al finalizar solo da clic en “Guardar cambios”.</p>
            </details>
            
            
            <h4>Proyectos</h4>
            
            <details> 
                <summary> 
                    ¿Cómo doy de alta mi proyecto?
                </summary>
                <p>Puedes dar clic en “Crear un proyecto” desde la página de inicio o entrando a “Mi cuenta”, 
                    llenas todos los datos necesarios del formulario, das clic en “Crear” y tu proyecto se subirá a la plataforma automáticamente.</p>

            </details>
            
            <details> 
                <summary> 
                    ¿Puedo tener varios colaboradores en mi proyecto?
                </summary>
                <p>Si, los que desees, siempre y cuando ellos acepten trabajar contigo.</p>

            </details>
            
            <h4>Colaboradores</h4>
            
             <details> 
                <summary> 
                    ¿Es necesario contar con un título en técnico para poder registrarme como colaborador?
                </summary>
                <p>No, solamente con que seas estudiante en alguno de los CECyTs, y si no tienes conocimientos de una carrera, 
                    te puedes registrar aun así con las habilidades que poseas.</p>
            </details>
            
            <h4>Donaciones</h4>
            
           
            
            <details> 
                <summary> 
                    ¿Hay una cantidad mínima para donar?
                </summary>
                <p>No, puedes donar con lo que puedas y quieras.</p>

            </details>
            
            <details> 
                <summary> 
                    ¿Qué posibilidad existe de que mi proyecto sea financiado?
                </summary>
                <p>Todo depende de que tan popular sea en la plataforma, de que tanta publicidad se le 
                    dé al mismo y sobre todo del interés de los usuarios por tu proyecto.</p>

            </details>
            
            <details> 
                <summary> 
                    Si el proyecto no se lleva acabo y realice una donación a ese proyecto, ¿qué le sucederá a mi dinero?
                </summary>
                <p>Si el proyecto que apoyas no llega a la meta en el plazo de tiempo estimado, se te devolverá la donación realizada.</p>

            </details>
            
            <h4>Métodos de Pago</h4>
            
             <details> 
                <summary> 
                    ¿Es seguro registrar mi tarjeta de débito/crédito en la página?
                </summary>
                <p>Sí, todos tus datos estarán seguros ya que toda tu información de tu tarjeta es cifrada mediante un 
                    algoritmo criptográfico llamado MD5 seguido de un AES, así que no tienes que preocuparte por eso.</p>

            </details>
            
            <details> 
                <summary> 
                    ¿Con que métodos de pago puedo donar a un proyecto?
                </summary>
                <p>Por el momento solo puedes donar mediante una tarjeta de crédito o débito y Paypal, ambos
                    métodos puedes registrarlos en el apartado de “Mi cuenta>>Mis métodos de pago”.</p>

            </details>
            
            
            <%
                    System.out.println("no ha enviado");
                    ArrayList<faqs> list = new ArrayList<faqs>();
                    ifaqDao f = new impfaqDao();
                    list = f.consultaUser();
                    for (int i = 0; i < list.size(); i++) {
                        out.println("<form method='post'>"
                                + "<details>"
                                + "<summary>"
                                + "&iquest;" + list.get(i).getPregunta() + "&#x3f;"
                                + "</summary>"
                                + "<p>"
                                + "" + list.get(i).getRespuesta() + ""
                                + "</p>"
                                + "</details>"
                                + "</form>");
                    }
                }
            %>




        </div>

            <br><br>
            
            <h4 style="text-align: center">¿No te fue útil la información?</h4>
        <form id="faq" method="post">
            <div class="input-field col s12">
                <div style="background-color: #999999">
                    <br>
                    <h5>
                        ¿Tienes alguna duda que crees que debería estar resuelta aquí? Mándanos tu sugerencia
                    </h5>
                    <br>
                </div>
                <br>
                <input type="text" id="nuevafaq" name="nuevafaq" placeholder="Escribe la pregunta sin signos de interrogación" onkeypress="Nosignosint()"/>
            </div>
            <input type="submit" name="Envia" value="Envia" id="Enviar"/>
        </form>
            <br><br><br>
    </body>
    <script src="JAVASCRIPT/validaciones.js"></script>
     <script type="text/javascript" src="JAVASCRIPT/materialize.min.js"></script>
        <script type="text/javascript" src="JAVASCRIPT/Extras.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    
</html>
