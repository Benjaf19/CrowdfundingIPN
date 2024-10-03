<%-- 
    Document   : registraProyecto
    Created on : 4/11/2018, 01:03:46 AM
    Author     : Benjamin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.io.OutputStream"%>
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
        <title>JSP Page</title>
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
             
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </head>
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
            
            
            
            
        /* ConexionBase cb = new ConexionBase();
            Connection con = cb.coectarbd();
            Statement sta = con.createStatement();
            try{
            ResultSet res = sta.executeQuery("select imagen from proyectos where nombre = 'croed';");
            res.next();
            Blob ima = res.getBlob("imagen");
            byte[] array = ima.getBytes(1, (int)ima.length());
            response.setContentType("image/png");
            OutputStream os = response.getOutputStream();
            os.write(array);
            os.flush();
            os.close();}catch(Exception e){
                System.out.println(e.toString());
            }
            */
           /* try{
            BufferedImage img1 = null;

  try{
  img1 = ImageIO.read(new ByteArrayInputStream(ima.getBytes(1, (int) ima.length())));
  }
  catch(Exception ex){
  System.out.println(ex.getMessage());
  }

 ImageIcon icono = new ImageIcon(img1);
 JOptionPane.showMessageDialog(null, "Imagenes", "Imagen", JOptionPane.INFORMATION_MESSAGE, icono);
ImageIO.write(img1, "jpg", new File("final.jpg"));
  }catch(Exception ex){
   //No hay imagen
  }
               */ 
        ConexionBase con = new ConexionBase();
        con.coectarbd();
        String nom = ESAPI.encoder().encodeForHTML(request.getParameter("nombre"));
         iProyectoDao p = new impProyectoDao();
         
         
         Proyecto pp = p.buscaonlyone(nom);
         
         String btn = request.getParameter("crear") == null ? "":request.getParameter("crear");
        if(btn.equals("Editar")){
            
            
            
        }else{
            System.out.println("no ha enviado");
        }
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
    
                                    
         
               <div id="banner">
                    <img src="IMG/upiita.jpg" alt="">
                        <div class="banderita">
                            <h2>Modificar Proyecto</h2>
                            <p>En este modulo podras modificar tus proyectos y realizar diferentes acciones</p>

                        </div>
                    </div>                    
                                    
         
             <div id="encaps2">                            
            <form method="post" name="formu" class="formuC" action="editarProyectos" enctype="multipart/form-data">
                <div class="contenint">
                    <br>
                    <div class="input-field col s12">
                        <label>Nombre</label><input type="text" placeholder="Escribe el nombre de tu proyecto..." name="nombre" id="nombre" value="<%=pp.getNombre()%>" autofocus="" />
                        <input type="hidden" name="nombreant" value="<%=pp.getNombre()%>"/>
                    </div>
                    <div class="input-field col s12">
                        <textarea name="descripcion" id="descripcion" class="materialize-textarea" > <%=pp.getDescripcion()%> </textarea>
                        <label for="descripcion">Descripcion del Proyecto</label>
                    </div>
                    <div class="input-field col s12">
                        <div class="file-field input-field">
                            <div class="btn">
                                <span>Imagen</span>
                                <input type="file" name="img" id="img" accept="image/*"  value="<%=pp.getImagen()%>" >
                            </div>
                            <div class="file-path-wrapper">
                                <input class="file-path validate" type="text" >
                            </div>
                        </div>
                        <!--<label>Imagen</label><input type="file" placeholder="Escoge una imagen..." name="img" id="img"/>-->
                    </div>
                    <div class="input-field col s12">
                        <label>Financiación</label><input type="number" placeholder="Escribe la cantidad que necesitas recaudar..." name="finan" id="finan"  value="<%=pp.getFinanciacion()%>" />
                    </div>
                    <div class="input-field col s12">
                        <label>Plazo para recaudarla:</label><input type="number" placeholder="(Dias)" name="plazo" id="plazo"  value="<%=pp.getPlazotiempo()%>" />
                    </div>
                    <div class="input-field col s12">
                        <textarea name="recompensas" id="recompensas" class="materialize-textarea" data-length="150" maxlength="150"> <%=pp.getRecompensas()%> </textarea>
                        <label for="recompensas">Descripcion de Recompensas para donadores</label>
                    </div>
                    <div class="input-field col s12">
                        <!--<label>Categoria</label><input type="text" placeholder="Escribe la categoria de tu proyecto..." name="categoria" id="categoria"/>-->

                        <select name="categoria" id="categoria">
                <%
                    String []cat = {"ARTE","SALUD","EDUCACIÓN","TECNOLOGIA","CIENCIA"};
                   
                for (int i = 0; i < 5; i++) {
                     if(cat[i].equals(pp.getCategoria())){
                       out.println("<option id='op"+i+"' selected='selected' >"+cat[i]+"</option>");
                           
                     }else{
                         out.println("<option id='op"+i+"' >"+cat[i]+"</option>");
                     }
                        
                }
                
                %>
                        </select>
                        <label>Categoria</label>
                    </div>
                        <br><br><br><br>
                     <input type="submit" value="Editar" name="crear" id="crear" />
                </div>
            </form>
        </div>
            <!--<label>Categoria</label><input type="text" placeholder="Escribe la categoria de tu proyecto..." name="categoria" id="categoria"/>-->
             
            
                
                
                
                
                
                
                <!-- <option id="OP1">ARTE</option>
                 <option id="OP2">SALUD</option>
                 <option id="OP3">EDUCACIÓN</option>
                 <option id="OP4">TECNOLOGIA</option>
                 <option id="OP5">CIENCIA</option>-->
                 
            
            <br>
            
           
            
        
    </body>
</html>
