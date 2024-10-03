<%-- 
    Document   : editarColaborador
    Created on : 11/03/2019, 07:13:47 PM
    Author     : benja
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="modelo.Colaborador"%>
<%@page import="impDao.impColaboradorDao"%>
<%@page import="dao.iColaboradorDao"%>
<%@page import="modelo.UsuarioN"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edita Colaborador</title>
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
        <script>
            $(document).ready(function () {
                $('input#input_text, textarea#textarea2').characterCounter();
            });
        </script>
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
        <%
            iColaboradorDao colabo = new impColaboradorDao();
        Colaborador colabor = colabo.consultaColabBoleta(user.getBoleta());
ByteArrayOutputStream os = new ByteArrayOutputStream();
                        byte barray[] = new byte[1024];
                        int n = 0;
                        InputStream is = colabor.getFoto();
                        while ((n = is.read(barray)) >= 0) {
                            os.write(barray, 0, n);
                        }
                        is.close();
                        byte[] bys = os.toByteArray();
                        byte[] encodedBytes = Base64.getEncoder().encode(bys);
                        String ruta = new String(encodedBytes, "UTF-8");
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
            <img src="IMG/cecyt13.jpg" alt="">
            <div class="banderita">
                <h2>Modificar Colaborador</h2>
                

            </div>
        </div>
        <div id="encaps2">   
            <form method="post" class="formuC" enctype="multipart/form-data" action="editaColaborador">
                <input type="hidden" name="idC" value="<%=colabor.getIdColaborador()%>"/>
                <div class="contenint">
                    <br><br>
                <div class="input-field col s12">
                        <div class="file-field input-field">
                            <div class="btn">
                                <span>Foto</span>
                                <input type="file" id="foto" name="foto" accept="image/*" value="<%=colabor.getFoto()%>">
                            </div>
                            <div class="file-path-wrapper">
                                <input class="file-path validate" type="text" >
                            </div>
                        </div>
                        <!--<label>Imagen</label><input type="file" placeholder="Escoge una imagen..." name="img" id="img"/>-->
                    </div>
                    
            <div class="input-field col s12">
            
            <!--<input type="text" id="carrera" name="carrera">-->
            <br><br><select name="carrera">
                
                <%
                    
                    ArrayList<String> lista = new ArrayList<String>();
                lista = colabo.carreras(user.getEscuela());
                String carreraEscogida = colabor.getCarrera();
                for(int i = 0; i<lista.size();i++){
                    System.out.println(lista.get(i));
                    if(lista.get(i).equals(carreraEscogida)){
                    out.println("<option selected id='opc"+i+"'>"+lista.get(i)+"</option>");
                    }else{
                        out.println("<option id='opc"+i+"'>"+lista.get(i)+"</option>");
                    }
                    
                }
                
                %>
            </select>
            <label>Carrera</label>
            </div>
            <br><br><div class="input-field col s12">
                <textarea name="infoextra" id="recompensas" class="materialize-textarea" data-length="150" maxlength="150"><%=colabor.getInfoExtra()%></textarea>
                        <label for="recompensas">Describe informacion extra sobre ti</label>
                    </div>
                    <BR>
            
            <br><br><input type="submit" value="Editar" name="Editar" id="crear" />
                </div>
            </form>
        </div>
    </body>
</html>
