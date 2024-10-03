<%-- 
    Document   : recuperaContraseña
    Created on : 24/10/2018, 06:16:56 PM
    Author     : Benjamin
--%>

<%@page import="java.util.Date"%>
<%@page import="cifrado.CifrarSHA"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="impDao.impUsuarioNDao"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="dao.iUsuarioNDao"%>
<%@page import="org.owasp.esapi.ESAPI"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:recupera contraseña.:</title>
         <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="CSS/css2.css">
        <!--<link rel="stylesheet" type="text/css" href="CSS/materialize.css">-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
       <!-- <script type="text/javascript" src="JAVASCRIPT/materialize.js"></script>-->
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </head>
    <body style="background-image: url(IMG/ipn3.jpg);background-attachment: fixed;

          background-position: center;
          background-repeat: no-repeat;
          background-size: cover;">
        <%
        HttpSession sesion = request.getSession();
        Date fecha = new Date();
        
        String saludo = "";
        String primerNav = "";
        String segundoNav = "";
        UsuarioN user2 = new UsuarioN(0, "", "", "", 0, "", "",fecha) ;
        if (sesion.getAttribute("usuario") != null) {
            primerNav = "Mi cuenta";
            segundoNav = "Cerrar Sesión";
            user2 = (UsuarioN) sesion.getAttribute("usuario");
            saludo = "Bienvenido " + user2.getNombre();
        }else {
            
            System.out.println("ke pasa");
           
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
            if(request.getParameter("nfrp").equals("snofp")){
        %>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="account-box">
                        <label class="checkbox" style="text-align: center">
                               Escribe tu correo de inicio de sesión, te enviaremos un e-mail para la recuperación de la contraseña de tu cuenta:
                            </label>
                        <form class="form-signin" method="post" action="recuperaContrasena">
                            <div class="form-group">
                                <input type="email" class="form-control" placeholder="correo@mail.com" name="atx" id="correo" required autofocus />
                            </div>
                            
                            <button class="btn btn-lg btn-block purple-bg" type="submit" name="envia" id="envia" value="Enviar">
                                Entrar</button>
                            
                        </form>
                        
                        
                    </div>
                </div>
            </div>
        </div>
        <%
            } else {
                if (request.getParameter("nfrp").equals("sntwfp")) {
                    String correo = request.getParameter("atx");
                    CifrarSHA cf = new CifrarSHA();
                    String correosinEsapi = cf.descifra(Base64.decodeBase64(correo));
                    %>
        <!--<br><br><br><br>
        <div>
            <form method="post" action="recuperaContraseña.jsp?nfrp=snthfp&atx=<%=correo%>"/>
                <label>Escribe tu nueva contraseña</label>
                <input type="password" name="contra" id="contra" placeholder="Escribe tu contraseña"/>
                <input type="password" name="contra2" id="contra2" placeholder="Confirma tu contraseña"/>
                <input type="submit" name="cambiar" id="cambiar" value="cambiar"/>
            </form>
        </div>-->
                <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="account-box">
                        <label class="checkbox" style="text-align: center">
                               Escribe tu nueva contraseña:
                            </label>
                        <form class="form-signin" method="post" action="recuperaContraseña.jsp?nfrp=snthfp&atx=<%=correo%>">
                            <div class="form-group">
                                <input type="password" class="form-control" placeholder="Escribe tu contraseña" name="contra" id="contra" required autofocus />
                                 <input type="password" class="form-control" name="contra2" id="contra2" placeholder="Confirma tu contraseña" />
                            </div>
                            
                            <button class="btn btn-lg btn-block purple-bg" type="submit" name="cambiar" id="cambiar" value="cambiar">
                                Cambiar</button>
                            
                        </form>
                        
                        
                    </div>
                </div>
            </div>
        </div>
        <%
                        } else {
                                    if (request.getParameter("nfrp").equals("snthfp")) {
                                    String correo = request.getParameter("atx");
                                    
                    CifrarSHA cf = new CifrarSHA();
                    String correoshido = ESAPI.encoder().encodeForHTML(cf.descifra(Base64.decodeBase64(correo)));
                                    String contra = ESAPI.encoder().encodeForHTML(request.getParameter("contra"));
                                    String confcontra = ESAPI.encoder().encodeForHTML(request.getParameter("contra2"));
                                    if(contra.equals(confcontra)){
                                    String contraCifrada = new String(Base64.encodeBase64(cf.cifra(contra)));
                                    iUsuarioNDao user = new impUsuarioNDao();
                                    int ver =user.recuperaContra(correoshido, contraCifrada);
                                    if(ver != 0){
                                    out.println("<script> alert('Contraseña actualizada'); "
                        + "window.location = 'inicioSesion.jsp';</script>");
                                        }else{
                                          out.println("<script> alert('Ha ocurrido un error'); "
                        + "window.location = 'recuperaContraseña.jsp?nfrp=snthfp&atx="+ESAPI.encoder().decodeForHTML(correo)+"';</script>");
                                            }
                                        }else{
                                        out.println("<script> alert('Las contraseñas no coinciden'); "
                        + "window.location = 'recuperaContraseña.jsp?nfrp=sntwfp&atx="+ESAPI.encoder().decodeForHTML(correo)+"';</script>");
                                            }
                                    } else {
                                        out.println("No cambies la url prro");
                                    }
                                }
                            }
        %>
    </body>
</html>
