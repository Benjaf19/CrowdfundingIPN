/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package verifica;

import BD.ConexionBase;
import cifrado.CifrarSHA;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.codec.binary.Base64;
import org.owasp.esapi.ESAPI;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
@WebServlet(name = "recuperaContrasena", urlPatterns = {"/recuperaContrasena"})
public class recuperaContrasena extends HttpServlet {
private String Emisor  = "novasoftdevelopers@gmail.com";
private String ContraEmis = "nadialomino17";
private String mensaje = "";
private String To = "";
private String Subject = "CROWDFUNDING IPN Recupera la contraseña de tu cuenta";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>\n" +
"      <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n" +
"        <title>Conectando...</title>\n" +
"         <meta charset=\"UTF-8\">\n" +
"        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
"        <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css\" integrity=\"sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO\" crossorigin=\"anonymous\">\n" +
"        <link rel=\"stylesheet\" type=\"text/css\" href=\"CSS/css2.css\">\n" +
"        <!--<link rel=\"stylesheet\" type=\"text/css\" href=\"CSS/materialize.css\">-->\n" +
"        <link href=\"https://fonts.googleapis.com/icon?family=Material+Icons\" rel=\"stylesheet\">\n" +
"        <script type=\"text/javascript\" src=\"https://code.jquery.com/jquery-3.2.1.min.js\"></script>\n" +
"       <!-- <script type=\"text/javascript\" src=\"JAVASCRIPT/materialize.js\"></script>-->\n" +
"        <link href=\"//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css\" rel=\"stylesheet\" id=\"bootstrap-css\">\n" +
"        <script src=\"//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js\"></script>\n" +
"        <script src=\"//code.jquery.com/jquery-1.11.1.min.js\"></script>\n" +
"        <script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js\" integrity=\"sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49\" crossorigin=\"anonymous\"></script>\n" +
"        <script src=\"https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js\" integrity=\"sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy\" crossorigin=\"anonymous\"></script>\n" +
"    </head>");
            out.println("<body style=\"background-image: url(IMG/ipn3.jpg);background-attachment: fixed;\n" +
"\n" +
"          background-position: center;\n" +
"          background-repeat: no-repeat;\n" +
"          background-size: cover;\">");
            ConexionBase cnx = new ConexionBase();
            Connection con = cnx.coectarbd();
            String correo = ESAPI.encoder().encodeForHTML(request.getParameter("atx"));
            To=ESAPI.encoder().decodeForHTML(correo);
            try{
            CifrarSHA cifra = new CifrarSHA();
            byte[] correoBytes = Base64.encodeBase64(cifra.cifra(To));
            String correoCifrado = new String(correoBytes);
            
            mensaje = "Haga clic en el siguiente enlace para cambiar la contraseña de su cuenta de Crowdfunding IPN, si usted no solicito un cambio de contraseña, por favor ignore este correo electronico." 
                    + " http://localhost:8080/Crowd/recuperaContrase%C3%B1a.jsp?nfrp=sntwfp&atx="+correoCifrado+"";
            }catch(Exception e){
                System.out.println(e.toString());
            }
            try{
            Statement sta = con.createStatement();
            ResultSet res = sta.executeQuery("select count(*) as valido from UsuarioN where correo = '"+correo+"'; ");
            res.next();
            int valido = res.getInt("valido");
            if(valido == 1){
                
                SendMail();
                out.println("<div class=\"container\"><div class=\"row\">\n" +
"                <div class=\"col-md-4 col-md-offset-4\">\n" +
"                    <div class=\"account-box\"><form method='post' action='recuperaContrasena'><label>Hemos enviado un e-mail a tu correo electronico para proceder con la recuperación de tu contraseña</label>"
                        + "<br><label>Entra para continuar con el proceso.</label>"
                        + "<input type='hidden' name='atx' value='"+correo+"'/>"
                        + "<input type='submit' value='No me ha llegado el correo' style='width: 100%;\n" +
"    cursor: pointer;\n" +
"    background: #6e1217;\n" +
"    color: white;\n" +
"    border-radius: 10px;\n" +
"    height: 40px;' name='envia'></input><br><a href='inicioSesion.jsp'>He cambiado mi contraseña. Iniciar sesión</a></form></div></div></div></div>");
            }else{
                out.println("<script> alert('No esta registrado ningún usuario con este correo'); "
                         + "window.location = 'AltaUsuarioN.jsp';</script>");
            }
            }catch(Exception e){
                System.out.println(e.toString());
            }
            out.println("</body>");
            out.println("</html>");
        }
    }
    public void SendMail() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
 
        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(Emisor, ContraEmis);
                    }
                });
 
        try {
 
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Emisor));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(To));
            message.setSubject(Subject);
            message.setText(mensaje);
 
            Transport.send(message);
            System.out.println("Envio el correo");
 
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
