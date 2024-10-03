<%-- 
    Document   : registraDonaciones
    Created on : 12/11/2018, 12:53:14 AM
    Author     : Benjamin
--%>

<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="cifrado.CifrarSHA"%>
<%@page import="impDao.impPaypalDao"%>
<%@page import="dao.iPaypalDao"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="BD.ConexionBase"%>
<%@page import="modelo.Donacion"%>
<%@page import="impDao.impDonacionDao"%>
<%@page import="dao.iDonacionDao"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="java.sql.Date"%>
<%@page import="org.owasp.esapi.ESAPI"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:Donar:.</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            int bandera = 0;
            String saludo = "";
            UsuarioN user = null;
            String primerNav = "";
            String segundoNav = "";
            if (sesion.getAttribute("usuario") != null) {
                primerNav = "Mi cuenta";
                segundoNav = "Cerrar Sesión";
                user = (UsuarioN) sesion.getAttribute("usuario");
                saludo = "Bienvenido " + user.getNombre();
            } else {
                response.sendRedirect("inicioSesion.jsp");
                saludo = "Inicia Sesion";
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

            String btn = request.getParameter("donar") == null ? "" : request.getParameter("donar");
            int boleta = 0;
            double monto = 0;
            int idpp = 0;
            String idPro = request.getParameter("idProyecto") == null ? "0" : request.getParameter("idProyecto");
            idpp = Integer.parseInt(idPro);
            
                
            if (btn.equals("Donar")) {
                boleta = user.getBoleta();
                monto = Double.parseDouble(ESAPI.encoder().encodeForHTML(request.getParameter("monto")));
                
                if (request.getParameter("MetodoPago").equals("TARJETADEBITO/CREDITO")) {
        %>
        <section class="quinto">
            <div class="posicion">
                <h1 class="letratitulo"><span class="title"><b>REALIZA DONACION</b></span></h1>
            </div>
        </section> 
        <div id="encaps3">
            <form method="post"  action="registraDonaciones.jsp" class="formuC">
                <div class="contenint">
                    <input type="hidden" name="donar" value="Donar"/>
                    <input type="hidden" name="monto" value="<%=monto%>"/>
                    <input type="hidden" name="idProyecto" value="<%=idpp%>"/>
                    <br><br><select name="Metodopag" id="Metodopag">

                        <%
                            ConexionBase cnx = new ConexionBase();
                            Connection con;
                            ResultSet res2,res3;
                            con = cnx.coectarbd();
                            Statement sta = con.createStatement();
                            res3 = sta.executeQuery("select count(tag.numTrajeta) as Tag from reltarjetausn inner join Tarjeta as tag ON reltarjetausn.idTarjeta = tag.idTarjeta where boleta = " + user.getBoleta() + ";");
                            res3.next();
                            int bd2 = res3.getInt("Tag");
                            if(bd2>0){
                            res2 = sta.executeQuery("select tag.numTrajeta as Tag from reltarjetausn inner join Tarjeta as tag ON reltarjetausn.idTarjeta = tag.idTarjeta where boleta = " + user.getBoleta() + ";");
                    
                            while (res2.next()) {
                        
                               out.println("<option value='" + res2.getString("Tag") + "'> Tarjeta: **** **** **** " + res2.getString("Tag").substring(12) + "</option>");
                            }
        }else{
                                bandera = 0;
                                 out.println("<script> alert('No tienes ninguna Terjeta registrada'); "
                                            + "window.location = 'registroTarjeta.jsp';</script>");
                        
                            }
                        %>
                    </select>
                    <input type="hidden" name="MetodoPago" value="tag"/>
                    <br><br><input type="submit" name="finalizar" value="Finalizar" id="crear"/><br><br>
                </div>
            </form>
        </div>
        <%            } else {
            if (request.getParameter("MetodoPago").equals("PAYPAL")) {
        %>
        <section class="quinto">
            <div class="posicion">
                <h1 class="letratitulo"><span class="title"><b>REALIZA DONACION</b></span></h1>
            </div>
        </section> 
        <div id="encaps3">
            <form method="post" action="registraDonaciones.jsp" class="formuC">
                <div class="contenint">
                    <input type="hidden" name="donar" value="Donar"/>
                    <input type="hidden" name="monto" value="<%=monto%>"/>
                    <input type="hidden" name="idProyecto" value="<%=idpp%>"/>
                    <br><select name="Metodopag" id="Metodopag">
                        <%
                            ConexionBase cnx = new ConexionBase();
                            Connection con;
                            ResultSet res,res4;
                            con = cnx.coectarbd();
                            Statement sta = con.createStatement();
                            res4 = sta.executeQuery("select count(pp.correoPP) as payp from relpaypalusn inner join PayPal as pp ON relpaypalusn.idPaypal = pp.idPaypal where boleta = " + user.getBoleta() + ";");
                            res4.next();
                            int bd3 = res4.getInt("payp");
                            if(bd3 >0){
                            res = sta.executeQuery("select pp.correoPP as payp from relpaypalusn inner join PayPal as pp ON relpaypalusn.idPaypal = pp.idPaypal where boleta = " + user.getBoleta() + ";");
                            while (res.next()) {
                                out.println("<option value='" + res.getString("payp") + "'>" + res.getString("payp") + "</option>");
                            }
                            }else{
                              bandera = 0;
                                 out.println("<script> alert('No tienes ningun Paypal registrado'); "
                                            + "window.location = 'registroPaypal.jsp';</script>");   
                            }

                        %>

                    </select><br>
                    <input type="hidden" name="MetodoPago" value="pay"/>
                    <input type="password" name="contrapp" id="contrapp" placeholder="Ingrese la contraseña de su Paypal"/> 
                    <br><br><input type="submit" name="finalizar" value="Finalizar"  id="crear"/><br><br>
                </div>
            </form>
        </div>
        <%                            } else {
                    if (request.getParameter("MetodoPago").equals("pay")) {
                        iPaypalDao ppd = new impPaypalDao();
                        String correo = ESAPI.encoder().encodeForHTML(request.getParameter("Metodopag"));
                        System.out.println(correo);
                        CifrarSHA cf = new CifrarSHA();
                        String pswd = ESAPI.encoder().encodeForHTML(request.getParameter("contrapp"));
                        String contraCifrada = new String(Base64.encodeBase64(cf.cifra(pswd)));
                        int ver = ppd.verificaContra(contraCifrada, correo);
                        if (ver != -1) {
                            bandera = 1;
                            System.out.println("chido");
                        } else {
                            bandera = 0;
                            out.println("<script> alert('Contraseña incorrecta'); "
                                    + "window.location = 'registraDonaciones.jsp';</script>");
                        }
                    } else {
                        bandera = 1;

                    }

                }
            }

        } else {
            System.out.println("no ha enviado");
        %>
        <section class="quinto">
            <div class="posicion">
                <h1 class="letratitulo"><span class="title"><b>REALIZA DONACION</b></span></h1>
            </div>
        </section> 
        <div id="encaps2">
            <form method="get" action="registraDonaciones.jsp" class="formuC">
                <div class="contenint">
                    <input type="hidden" name="idProyecto" value="<%=idpp%>"/>
                    <label>MONTO A DONAR</label><input type="number" name="monto" id="monto" placeholder="Ingresa el monto que deseas donar..."/>

                    <!-- <label>Método de pago</label>
                     
                     <select name="metodopp" id="metodopp">
                    <%
                        /* ConexionBase cnx = new ConexionBase();
                Connection con;
                ResultSet res,res2;
                con = cnx.coectarbd();
                Statement sta = con.createStatement();
                res = sta.executeQuery("select pp.correoPP as payp from relpaypalusn inner join PayPal as pp ON relpaypalusn.idPaypal = pp.idPaypal where boleta = "+user.getBoleta()+";");
                while(res.next()){
                    out.println("<option> Paypal: "+res.getString("payp")+"</option>");
                }*/

                    %>
               
                
                
                    <% /*
                res2 = sta.executeQuery("select tag.numTrajeta as Tag from reltarjetausn inner join Tarjeta as tag ON reltarjetausn.idTarjeta = tag.idTarjeta where boleta = "+user.getBoleta()+";");
                while(res2.next()){
                    out.println("<option> Tarjeta: "+res2.getString("Tag")+"</option>");
                }
                         */

                    %>
                
                </select>
                <br>-->
                    <div class="input-field col s12">

                        <select name="MetodoPago" id="MetodoPago">
                            <option id="pp" value="PAYPAL">PAYPAL</option>
                            <option id="tag" value="TARJETADEBITO/CREDITO">TARJETA DEBITO/CREDITO</option>
                        </select>
                        <label>METODO DE PAGO</label>
                    </div>
                    <input type="submit" name="donar" value="Donar" id="crear"/>
                </div>
            </form>
        </div>
        <%                     }
            String btn2 = request.getParameter("finalizar") == null ? "" : request.getParameter("finalizar");

            if (btn2.equals("Finalizar")) {
                if (bandera == 1) {
                    int verifica;
                    iDonacionDao don = new impDonacionDao();
                    Donacion d = new Donacion(0,idpp, boleta, monto);
                    verifica = don.realizaDonacion(d);
                    if (verifica > 0) {
                        System.out.println("se agrego");
                        out.println("<script> alert('Donación realizada con exito'); "
                                + "window.location = 'proyecto.jsp';</script>");

                    } else {
                        System.out.println("no se agrego");
                        out.println("<script> alert('Error al realizar tu donación'); </script>");
                    }
                } else {
                    System.out.println("no pasa");
                }
            } else {
                System.out.println("no finalizo");
            }
        %>
    </body>
</html>
