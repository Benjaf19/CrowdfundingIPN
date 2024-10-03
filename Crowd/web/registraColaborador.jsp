<%-- 
    Document   : registraColaborador
    Created on : 6/11/2018, 09:25:00 PM
    Author     : Ricardo Palomino
--%>
 
<%@page import="impDao.impUsuarioNDao"%>
<%@page import="dao.iUsuarioNDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Base64"%>
<%@page import="javax.servlet.annotation.MultipartConfig"%>

<%@page import="java.io.InputStream"%>
<%@page import="modelo.Colaborador"%>
<%@page import="impDao.impColaboradorDao"%>
<%@page import="dao.iColaboradorDao"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="java.io.File"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="BD.ConexionBase"%>
<%@page import="modelo.Proyecto"%>
<%@page import="impDao.impProyectoDao"%>
<%@page import="dao.iProyectoDao"%>
<%@page import="org.owasp.esapi.ESAPI"%>
<%@page import="modelo.UsuarioN"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>.:Registrar colaborador:.</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="CSS/css2.css">
        <link rel="stylesheet" type="text/css" href="CSS/css1.css">
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
             //MultipartConfig config1= new MultipartConfig(maxFileSize = 16177215);
            iColaboradorDao colabo = new impColaboradorDao();
            ConexionBase cnx = new ConexionBase();
            Connection con;
            ResultSet res;
            con = cnx.coectarbd();
            Statement sta = con.createStatement();
            res = sta.executeQuery("select count(*) as Ver from relcolabusn where boleta = " + user.getBoleta() + ";");
            res.next();
            if(res.getInt("Ver")==0){
        String btn = request.getParameter("crear") == null ? "":request.getParameter("crear");
        if(btn.equals("Crear")){
            
            /*tring carrera = ESAPI.encoder().encodeForHTML(request.getParameter("carrera"));
            String infoextra = ESAPI.encoder().encodeForHTML(request.getParameter("infoextra"));
            String pathname = request.getParameter("foto");
            File file = new File("C:/Users/benja/Pictures/Camera Roll/" + pathname);
            FileInputStream fis = new FileInputStream(file);
            Blob bl = (Blob)fis;
             
             
             
            
          
            
            
           
            int verifica;
            
                iColaboradorDao colabo = new impColaboradorDao();
                Colaborador u = new Colaborador(0, carrera, infoextra,bl);
                verifica = colabo.agregaColaborador(u,user.getBoleta());
                if(verifica != -1){
                    System.out.println("se creo el colaborador");
                out.println("<script> alert('Colaborador registrado con exito'); "
                        + "window.location = 'informacionUsuario.jsp';</script>");
                
                }else{
                    System.out.println("no se creo");
                out.println("<script> alert('Error colaborador no registrado'); </script>");
                } */
                
            
        }else{
            System.out.println("no ha enviado");
        }
        
        %>
        
      <section class="quinto">
            <div class="posicion">
                <h1 class="letratitulo"><span class="title"><b>REGISTRATE COMO COLABORADOR</b></span></h1>
            </div>
            </section> 
        
        <div id="encaps3">   
            <form method="post" class="formuC" enctype="multipart/form-data" action="registroColaborador">
                
                <div class="contenint">
                    <br>
                <div class="input-field col s12">
                        <div class="file-field input-field">
                            <div class="btn">
                                <span>Foto</span>
                                <input type="file" id="foto" name="foto">
                            </div>
                            <div class="file-path-wrapper">
                                <input class="file-path validate" type="text" >
                            </div><br>
                        </div>
                        <!--<label>Imagen</label><input type="file" placeholder="Escoge una imagen..." name="img" id="img"/>-->
                    </div>
                    
            <div class="input-field col s12">
            
            <!--<input type="text" id="carrera" name="carrera">-->
            <select name="carrera">
                <option selected disabled>Selecciona tu carrera</option>
                <%
                    ArrayList<String> lista = new ArrayList<String>();
                lista = colabo.carreras(user.getEscuela());
                for(int i = 0; i<lista.size();i++){
                    System.out.println(lista.get(i));
                    out.println("<option id='opc"+i+"'>"+lista.get(i)+"</option>");
                    
                    
                }
                
                %>
            </select>
            <label>Carrera</label>
            </div><br>
            <div class="input-field col s12">
                        <textarea name="infoextra" id="recompensas" class="materialize-textarea" data-length="150" maxlength="150"></textarea>
                        <label for="recompensas">Describe informacion extra sobre ti</label>
                    </div>
                    <BR>
            
            <input type="submit" value="Crear" name="crear" id="crear" />
                </div>
            </form>
        </div>
            <%
            }else{
                System.out.println("Ya eres un colaborador ;v");
                
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
                <div id="banner">
            <img src="IMG/cecyt13.jpg" alt="">
            <div class="banderita">
                <h2>Perfil de Colaborador</h2>
                

            </div>
        </div>
                <div class="info-des2">
                     <div class="col s12 m7">
    
    <div class="card horizontal" id="cardColaborador">
      <div class="card-image" id='cardCol'>
         <img src="data:image/jpg;base64,<%=ruta%>">
      </div>
      <div class="card-stacked">
        <div class="card-content">
         <p style="color:black; text-align: right">Carrera: <%=colabor.getCarrera()%></p>
                <p style="color:black; text-align: right">Habilidades extra: <%=colabor.getInfoExtra()%></p>
                
        </div>
        <div class="card-action">
         <form action="editarColaborador.jsp" method="post">
                    
             <input type="submit" name="Modifica" id="Modifica" value="Modifica" style="background: #6e1217;color: white;font-size: 20px;cursor: pointer;"/>
                </form>
        </div>
      </div>
    </div>
  </div>
                </div>
                <!--<img src="data:image/jpg;base64,<%=ruta%>">
                <h1 style="color:white;">Carrera: <%=colabor.getCarrera()%></h1>
                <p style="color:white;">Habilidades extra: <%=colabor.getInfoExtra()%></p>
                <form action="editarColaborador.jsp" method="post">
                    
                    <input type="submit" name="Modifica" id="Modifica" value="Modifica"/>
                </form>-->
                
                <%

                }
            %>
    </body>
</html>
