<%-- 
    Document   : informacionUsuario
    Created on : 2/11/2018, 11:24:07 PM
    Author     : Benjamin
--%>


<%@page import="modelo.Colaborador"%>
<%@page import="java.util.ArrayList"%>
<%@page import="impDao.impColaboradorDao"%>
<%@page import="dao.iColaboradorDao"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="cifrado.CifrarSHA"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="BD.ConexionBase"%>
<%@page import="impDao.impUsuarioNDao"%>
<%@page import="dao.iUsuarioNDao"%>
<%@page import="java.util.Date"%>
<%@page import="org.owasp.esapi.ESAPI"%>
<%@page import="modelo.UsuarioN"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:Informacion de Usuario:.</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="CSS/css2.css">
        <link rel="stylesheet" type="text/css" href="CSS/materialize.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
            UsuarioN user = new UsuarioN(0, "", "", "", 0, "", "", fecha);
            if (sesion.getAttribute("usuario") != null) {
                primerNav = "Mi cuenta";
                segundoNav = "Cerrar Sesión";
                user = (UsuarioN) sesion.getAttribute("usuario");
                saludo = "Bienvenido " + user.getNombre();
            } else {

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
            /* ConexionBase cnx = new ConexionBase();
             Connection con;
             ResultSet res;
             con = cnx.coectarbd();
             Statement sta = con.createStatement();
             res = sta.executeQuery("select * from UsuarioN where boleta = " + user.getBoleta() + ";");
             res.next();*/

            String modifica = request.getParameter("guardacambios") == null ? "" : request.getParameter("guardacambios");
            if (modifica.equals("Guardar Cambios")) {
                int boleta = Integer.parseInt(ESAPI.encoder().encodeForHTML(request.getParameter("boleta")));
                int edad = Integer.parseInt(ESAPI.encoder().encodeForHTML(request.getParameter("edad")));
                String nombre = ESAPI.encoder().encodeForHTML(request.getParameter("nombre"));
                String apellidos = ESAPI.encoder().encodeForHTML(request.getParameter("ape"));
                String escuela = ESAPI.encoder().encodeForHTML(request.getParameter("escuela"));
                String correo = ESAPI.encoder().encodeForHTML(request.getParameter("correo"));
                String contraseña = ESAPI.encoder().encodeForHTML(request.getParameter("contra"));
                String confcontra = ESAPI.encoder().encodeForHTML(request.getParameter("confcontra"));
                Date fechaRegistro = new Date();
                CifrarSHA cf = new CifrarSHA();
                if (contraseña.equals(confcontra)) {
                    String contraCifrada = new String(Base64.encodeBase64(cf.cifra(contraseña)));
                    //contraCifrada
                    UsuarioN aux = new UsuarioN(boleta, nombre, apellidos, escuela, edad, correo, contraCifrada, fechaRegistro);
                    //contra no cifrada
                    UsuarioN aux1 = new UsuarioN(boleta, nombre, apellidos, escuela, edad, correo, contraseña, fechaRegistro);
                    iUsuarioNDao usr = new impUsuarioNDao();
                    int ver = usr.editaUsuario(aux);
                    if (ver != -1) {
                        sesion.removeAttribute("usuario");

                        sesion.setAttribute("usuario", aux1);
                        out.println("<script> alert('Datos actualizados con exito'); "
                                + "window.location = 'informacionUsuario.jsp';</script>");

                    } else {
                        out.println("<script> alert('Ha ocurrido un error al actualizar sus datos'); "
                                + "window.location = 'informacionUsuario.jsp';</script>");
                    }
                } else {
                    out.println("<script> alert('Los campos de la contraseña no coinciden'); "
                            + "window.location = 'informacionUsuario.jsp';</script>");
                }
            } else {
                System.out.println("no ha enviado");
            }
            iColaboradorDao col = new impColaboradorDao();
            ArrayList<String> lista = new ArrayList<String>();
            Colaborador colab = col.consultaColabBoleta(user.getBoleta());
            if (colab != null) {
                lista = col.consultaSolicitudRecibida(colab.getIdColaborador());
                System.out.println(lista.size() + " solicitudes tiene");
            } else {
                System.out.println("no es colaborador");
            }
        %>
        <div id="banner">
            <img src="IMG/cecyt13.jpg" alt="">
            <div class="banderita">
                <h2>Informacion de Usuario</h2>
                <p>En este modulo podras modificar tus datos personales y realizar diferentes acciones</p>

            </div>
        </div>




        <div id="encaps2">
            <form method="post" class="formuC">
                <div class="contenint">
                    <br>
                    <div class="input-field col s12">

                        <label>Boleta</label><input type="number" placeholder="Escribe tu boleta..." name="boleta" id="boleta" value="<%=user.getBoleta()%>" maxlength="10" disabled/>
                        <input type="hidden" name="boleta" value="<%=user.getBoleta()%>"/>
                    </div>
                    <div class="input-field col s12">
                        <label>Nombre</label><input type="text" placeholder="Escribe tu nombre..." name="nombre" id="nombre" value="<%=user.getNombre()%>" disabled/>
                    </div>
                    <div class="input-field col s12">
                        <label>Apellidos</label><input type="text" placeholder="Escribe tus apellidos..." name="ape" id="ape" value="<%=user.getApellidos()%>" disabled/>
                    </div>
                    <div>
                        <label>Escuela</label>
                        <select name="escuela" id="escuela" disabled class="browser-default" >
                            <%
                                String esc = "CECyT ";

                                for (int i = 1; i < 17; i++) {
                                    String aux = "";
                                    if (i < 16) {
                                        aux = esc + i;
                                        if (aux.equals(user.getEscuela())) {
                                            out.println("<option id='v" + i + "' selected='selected' >" + aux + "</option>");
                                        } else {
                                            out.println("<option id='v" + i + "'>" + aux + "</option>");
                                        }
                                    } else {
                                        aux = "CET 1";
                                        if (aux.equals(user.getEscuela())) {
                                            out.println("<option id='v" + i + "' selected='selected' >" + aux + "</option>");
                                        } else {
                                            out.println("<option id='v" + i + "'>" + aux + "</option>");

                                        }
                                    }
                                }
                            %>
                            <!-- <option id="v1" >CECyT 1</option>
                             <option id="v2">CECyT 2</option>
                             <option id="v3">CECyT 3</option>
                             <option id="v4">CECyT 4</option>
                             <option id="v5">CECyT 5</option>
                             <option id="v6">CECyT 6</option>
                             <option id="v7">CECyT 7</option>
                             <option id="v8">CECyT 8</option>
                             <option id="v9">CECyT 9</option>
                             <option id="v10">CECyT 10</option>
                             <option id="v11">CECyT 11</option>
                             <option id="v12">CECyT 12</option>
                             <option id="v13">CECyT 13</option>
                             <option id="v14">CECyT 14</option>
                             <option id="v15">CECyT 15</option>
                             <option id="c1">CET 1</option> -->
                        </select>
                    </div>
                    <div class="input-field col s12">

                        <label>Edad</label><input type="number" placeholder="Escribe tu edad..." name="edad" id="edad" value="<%=user.getEdad()%>" disabled/>
                    </div>
                    <div class="input-field col s12">
                        <label>Correo</label><input type="email" placeholder="Escribe tu correo..." name="correo" id="correo" value="<%=user.getCorreo()%>" disabled/>
                        <input type="hidden" name="correo" value="<%=user.getCorreo()%>"/>
                    </div>
                    <div class="input-field col s12">
                        <label>Contraseña</label><input type="password" placeholder="Escribe tu contraseña..." name="contra" id="contra" value="<%=user.getContraseña()%>" disabled/>
                    </div>            
                    <div class="input-field col s12">
                        <label>Confirme Contraseña</label><input type="password" placeholder="Confirma tu contraseña..." name="confcontra" value="<%=user.getContraseña()%>" id="confcontra" disabled/>
                    </div>
                    <br>

                    <input type="button" value="Modificar" name="modifica" id="modifica" onclick="deshabilitacampos();"/><br>
                    <input type="button" value="Cancelar" name="cancelar" id="cancelar" onclick="cancela();" disabled/><br>
                    <input type="submit" value="Guardar Cambios" name="guardacambios" id="guardacambios" disabled/><br>
                    <br>
                    <script src="JAVASCRIPT/Extras.js"></script>
                </div>
            </form>
        </div>
        <!--<section id="boxbutton">
            
            <div class="contenedor">
                <div class="alignb">
                    <a href="registraProyecto.jsp" class="waves-effect waves-light btn-large grey"><i class="material-icons left">add_box</i>CREA UN PROYECTO</a>
                </div>
                <div class="alignb">
                    <a href="registraColaborador.jsp" class="waves-effect waves-light btn-large grey"><i class="material-icons left">assignment_ind</i>HASTE UN COLABORADOR</a>
                </div>
                <div class="alignb">
                    <a href="metodosPago.jsp" class="waves-effect waves-light btn-large grey"><i class="material-icons left">local_parking</i>MIS METODOS DE PAGO</a>
                </div>
                
                <div class="alignb">
                    <a href="misProyectos.jsp" class="waves-effect waves-light btn-large grey"><i class="material-icons left">brush</i>MIS PROYECTOS</a>
                </div>
                
            </div>
        </section> -->
        <section class="cajas">
            <section class="contenedor4">
                <h4 class="titulo" style="text-align: center">Elige la opcion deseada: </h4>
            </section>
        </section>
        <a href="registraProyecto.jsp">
            <section class="servicio">
                <img src="IMG/proyecto.jpg" alt="">
                <div class="contenedor">
                    <h2>CREAR PROYECTO</h2>
                </div>
            </section>
        </a>
        <a href="registraColaborador.jsp">
            <section class="servicio">
                <img src="IMG/colaboradores.jpg" alt="">
                <div class="contenedor">
                    <h2>PERFIL DE COLABORADOR</h2>
                </div>
            </section>
        </a>
        <a href="metodosPago.jsp">
            <section class="servicio">
                <img src="IMG/pago2.jpg" alt="">
                <div class="contenedor">
                    <h2>MIS METODOS DE PAGO</h2>
                </div>
            </section>
        </a>
        <a href="misProyectos.jsp">
            <section class="servicio">
                <img src="IMG/proyectos2.jpg" alt="">
                <div class="contenedor">
                    <h2>MIS PROYECTOS</h2>
                </div>
            </section>
        </a>
        <a href="Solicitudes.jsp">
            <section class="servicio">
                <img src="IMG/email-3249062.png" alt="">
                <div class="contenedor">
                    <h2>SOLICITUDES<span class="new badge" style="font-size: 24px;background: #6e1217;"><%=lista.size()%></span></h2>
                </div>
            </section>
        </a>
                 <a href="proyectosApoyados.jsp">
            <section class="servicio">
                <img src="IMG/proyecto3.jpg" alt="">
                <div class="contenedor">
                    <h2>PROYECTOS QUE APOYAS</h2>
                </div>
            </section>
        </a>
    </body>
</html>
