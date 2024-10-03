/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package verifica;

import dao.iColaboradorDao;
import impDao.impColaboradorDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
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
import javax.servlet.http.HttpSession;
import modelo.UsuarioN;
import org.owasp.esapi.ESAPI;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
@WebServlet(name = "aceptaCorreos", urlPatterns = {"/aceptaCorreos"})
public class aceptaCorreos extends HttpServlet {
private String Emisor  = "novasoftdevelopers@gmail.com";
private String ContraEmis = "nadialomino17";
private String mensaje = "";
private String To = "";
private String Subject = "CROWDFUNDING IPN Correo de contacto con colaborador";
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
            out.println("<head>");
            out.println("<title>Conectando...</title>");            
            out.println("</head>");
            out.println("<body>");
             
        HttpSession sesion = request.getSession();
        Date fecha = new Date();
        String saludo = "";
        String primerNav = "";
        String segundoNav = "";
        UsuarioN user = new UsuarioN(0, "", "", "", 0, "", "",fecha) ;
        if (sesion.getAttribute("usuario") != null) {
            primerNav = "Mi cuenta";
            segundoNav = "Cerrar Sesión";
            user = (UsuarioN) sesion.getAttribute("usuario");
            saludo = "Bienvenido " + user.getNombre();
        }else {
            
            System.out.println("ke pasa");
           out.println("<script>window.location = 'inicioSesion.jsp';</script>");  
        }

    
             iColaboradorDao col = new impColaboradorDao();
                        ArrayList<String> lista = new ArrayList<String>();
            String envia = request.getParameter("envia")==null?"":request.getParameter("envia");
    if(envia.equals("Aceptar")){
        int idSol = Integer.parseInt(request.getParameter("idSol"));
       String ver= col.aceptaSolicitud(idSol);
       if(!(ver.equals(""))){
           To=ESAPI.encoder().decodeForHTML(user.getCorreo());
            System.out.println(To+" " + ver);
           mensaje = "Este el correo de contacto de tu nuevo colaborador: "+ESAPI.encoder().decodeForHTML(ver)+"";
           SendMail();
           To=ESAPI.encoder().decodeForHTML(ver);
           System.out.println(To+" " + ver);
           mensaje = "Este el correo de contacto de tu nuevo colaborador: "+ESAPI.encoder().decodeForHTML(user.getCorreo())+"";
           SendMail();
                         System.out.println("se acepto la solicitud");
                out.println("<script> alert('Solicitud aceptada, en breve te llegara un correo de contacto'); "
                        + "window.location = 'Solicitudes.jsp';</script>");
                    }else{
                         System.out.println("nel no acepto soli");
                out.println("<script> alert('Ha ocurrido un error'); "
                        + "window.location = 'Solicitudes.jsp';</script>");
                    }
    }else{
       if( envia.equals("Eliminarla")){
           int idSol = Integer.parseInt(request.getParameter("idSol"));
           int ver= col.eliminaSolicitud(idSol);
           if(ver != -1){
                         System.out.println("se elimino la solicitud");
                out.println("<script> alert('Solicitud eliminada'); "
                        + "window.location = 'Solicitudes.jsp';</script>");
                    }else{
                         System.out.println("nel no elimino soli");
                out.println("<script> alert('Ha ocurrido un error'); "
                        + "window.location = 'Solicitudes.jsp';</script>");
                    }
       }else{
           System.out.println("no ha apretado boton");
       }
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
