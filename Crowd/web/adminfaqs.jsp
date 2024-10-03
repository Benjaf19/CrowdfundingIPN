<%-- 
    Document   : adminfaqs
    Created on : 18/02/2019, 11:54:18 AM
    Author     : Profesor
--%>

<%@page import="modelo.faqs"%>
<%@page import="java.util.ArrayList"%>
<%@page import="impDao.impfaqDao"%>
<%@page import="dao.ifaqDao"%>
<%@page import="impDao.impProyectoDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="BD.ConexionBase"%>
<%@page import="org.owasp.esapi.ESAPI"%>
<%@page import="dao.iProyectoDao"%>
<%@page import="dao.iProyectoDao"%>
<%@page import="modelo.UsuarioN"%>
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
            
            // ArrayList<Proyecto> list = py.consultaProyectosSinBuscar();
            // System.out.println(list.size());
%>
 <body>
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
        String btn = request.getParameter("Coloca") == null ? "" : request.getParameter("Coloca");
            if (btn.equals("Agregar a FAQs")) {

                String respuesta = ESAPI.encoder().encodeForHTML(request.getParameter("respuesta"));
                String preg = ESAPI.encoder().encodeForHTML(request.getParameter("preg"));
                System.out.println(preg);
                if(!(respuesta.equals(""))){
               faqs p = new faqs(0, preg, respuesta);
               ifaqDao f = new impfaqDao();
               int ver=f.editafaq(p);
               if(ver!=-1){
                    System.out.println("update");
                out.print("<script>alert('Pregunta agregada a FAQs');"
                        + "window.location='faq.jsp';</script>");
               }else{
                   System.out.println("sorry");
                out.print("<script>alert('Ha ocurrido un error');"
                        + "window.location='faq.jsp';</script>");
               }
                }else{
                    System.out.println("respuesta vacia");
                out.print("<script>alert('Escribe algo en el campo respuesta');"
                        + "window.location='adminfaqs.jsp';</script>");
                }

            } else {
                ArrayList<faqs> list = new ArrayList<faqs>();
                ifaqDao f = new impfaqDao();
                list = f.consultaAdmin();
                for (int i = 0; i < list.size(); i++) {
                    out.println("<form method='post'>"
                            + "<h3>Preguntas sugeridas para las FAQ's</h3>"
                            + "<h4>&iquest;" + list.get(i).getPregunta() + "&#x3f;</h4>"
                            + "<input type='text' name='respuesta' id='respuesta' />"
                                    + "<input type='hidden' name='preg' id='preg' value='"+list.get(i).getPregunta()+"' />"
                            + "<br>"
                            + "<input type='submit' name='Coloca' id='Coloca' value='Agregar a FAQs'/>"
                            + "</form>");
                }

            }
        %>
    
        
    </body>
</html>
