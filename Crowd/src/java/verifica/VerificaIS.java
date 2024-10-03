/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package verifica;

import BD.ConexionBase;
import cifrado.CifrarSHA;
import dao.iUsuarioNDao;
import impDao.impUsuarioNDao;

//import impWebServices.WsInicioSesion_Service;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.WebServiceRef;
import modelo.UsuarioN;
import org.apache.commons.codec.binary.Base64;
import org.owasp.esapi.ESAPI;
import pkg.WsInicioSesion_Service;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
@WebServlet(name = "VerificaIS", urlPatterns = {"/VerificaIS"})
public class VerificaIS extends HttpServlet {

    @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/localhost_8080/webServiceCrowd/wsInicioSesion.wsdl")
    private WsInicioSesion_Service service_1;

    @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/192.168.20.192_8080/webServiceCrowd/wsInicioSesion.wsdl")
    private WsInicioSesion_Service service;

   // @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/192.168.0.15_8080/webServiceCrowd/wsInicioSesion.wsdl")
   // private WsInicioSesion_Service service;

    /*@WebServiceRef(wsdlLocation = "WEB-INF/wsdl/192.168.0.15_8080/webServiceCrowd/wsInicioSesion.wsdl")
    private verifica.WsInicioSesion_Service service_1;*/

    

   /* @WebServiceRef(wsdlLocation = "WEB-INF/wsdl/localhost_8080/webServiceCrowd/wsInicioSesion.wsdl")
    private WsInicioSesion_Service service;*/

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
            out.println("<title>Verificando...</title>");            
            out.println("</head>");
            
            //verifica si es correcto
            //verifica si es correcto
           
            //CifrarSHA cf = new CifrarSHA();
            
           
            int boleta = Integer.parseInt(ESAPI.encoder().encodeForHTML(request.getParameter("boleta")));
            String paswd = ESAPI.encoder().encodeForHTML(request.getParameter("contra"));
            int bandera = 0;
            //bandera = iniciaSesion_1(boleta, paswd);
            HttpSession sesion2 = request.getSession();
            iUsuarioNDao us = new impUsuarioNDao();
            UsuarioN user = us.consultaUsuario(boleta);
            bandera = iniciaSesion(boleta, paswd);
            //String contraCifrada = new String(Base64.encodeBase64(cf.cifra(paswd)));
               // System.out.println(contraCifrada);
          
            if(bandera == 0){
            out.println("<script> alert('No existe un usuario con esa boleta'); "
                            + "window.location = 'AltaUsuarioN.jsp';</script>");
            
            }else{
                if(bandera==1){
                     if(sesion2.getAttribute("usuario")== null){
                        sesion2.setAttribute("usuario", user);
            }else{
               
                        sesion2.invalidate();
                        sesion2.setAttribute("usuario", user);
            }
                    out.println("<script> alert('Bienvenido "+user.getNombre()+"'); "
                         + "window.location = 'index.jsp';</script>");
                }else{
                    out.println("<script> alert('Contraseña incorrecta'); "
                            + "window.location = 'inicioSesion.jsp';</script>");
                }
            }
            
            
            
            
           
           
            
            
            out.println("<body>");
            
            out.println("<h1>Servlet VerificaIS at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
        }

    //private int iniciaSesion(int boleta, java.lang.String contraseña) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        //impServicio.WsInicioSesion port = service.getWsInicioSesionPort();
       // return port.iniciaSesion(boleta, contraseña);
  //  }
    

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

   

    
  /*//verifica si es correcto
            ConexionBase con = new ConexionBase();
            
            Connection cnx = con.coectarbd();
            CifrarSHA cf = new CifrarSHA();
            
            try{
            int boleta = Integer.parseInt(ESAPI.encoder().encodeForHTML(request.getParameter("boleta")));
            String paswd = ESAPI.encoder().encodeForHTML(request.getParameter("contra"));
            int bandera = 0;
            //bandera = iniciaSesion_1(boleta, paswd);
            HttpSession sesion2 = request.getSession();
            iUsuarioNDao us = new impUsuarioNDao();
            UsuarioN user = us.consultaUsuario(boleta);
            String contraCifrada = new String(Base64.encodeBase64(cf.cifra(paswd)));
            Statement sta = cnx.createStatement();
            ResultSet res;
            res = sta.executeQuery("select * from UsuarioN where boleta = "+boleta+";");
            //int bandera = 0;
            while(res.next()){
                if(res.getString("paswd").equals(contraCifrada)){
                    //Sesion
            //HttpSession sesion2 = request.getSession();
            //UsuarioN user = new UsuarioN(boleta, res.getString("nombre"), res.getString("apellidos"), res.getString("escuela"), res.getInt("edad"), res.getString("correo"), paswd, res.getDate("fRegistro"));
            if(sesion2.getAttribute("usuario")== null){
                        sesion2.setAttribute("usuario", user);
            
            }else{
               
                        //sesion2.invalidate();
                        sesion2.setAttribute("usuario", user);
            }
                 out.println("<script> alert('Bienvenido "+res.getString("nombre")+"'); "
                         + "window.location = 'index.jsp';</script>");
                         bandera = 1;
                    break;
                }else{
                    bandera = 2;
                    out.println("<script> alert('Contraseña incorrecta'); "
                            + "window.location = 'inicioSesion.jsp';</script>");
                    
                }
            }
            if(bandera == 0){
            out.println("<script> alert('No existe un usuario con esa boleta'); "
                            + "window.location = 'AltaUsuarioN.jsp';</script>");
            
            }else{
                if(bandera==1){
                     if(sesion2.getAttribute("usuario")== null){
                        sesion2.setAttribute("usuario", user);
            }else{
               
                       // sesion2.invalidate();
                        sesion2.setAttribute("usuario", user);
            }
                    out.println("<script> alert('Bienvenido "+user.getNombre()+"'); "
                         + "window.location = 'index.jsp';</script>");
                }else{
                    out.println("<script> alert('Contraseña incorrecta'); "
                            + "window.location = 'inicioSesion.jsp';</script>");
                }
            }
            
            
            
            
            }catch(Exception e){
                System.out.println(e.toString());
                out.println("<script> alert('Ha ocurrido un error'); "
                            + "window.location = 'inicioSesion.jsp';</script>");
            }*/

   /* private int iniciaSesion_1(int boleta, java.lang.String contraseña) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        verifica.WsInicioSesion port = service_1.getWsInicioSesionPort();
        return port.iniciaSesion(boleta, contraseña);
    }
     int boleta = Integer.parseInt(ESAPI.encoder().encodeForHTML(request.getParameter("boleta")));
            String paswd = ESAPI.encoder().encodeForHTML(request.getParameter("contra"));
            int bandera = 0;
            bandera = iniciaSesion_1(boleta, paswd);
            HttpSession sesion2 = request.getSession();
            iUsuarioNDao us = new impUsuarioNDao();
            UsuarioN user = us.consultaUsuario(boleta);
    */

    /*private int iniciaSesion(int boleta, java.lang.String contraseña) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        impServicio.WsInicioSesion port = service.getWsInicioSesionPort();
        return port.iniciaSesion(boleta, contraseña);
    }*/

    private int iniciaSesion(int boleta, java.lang.String contraseña) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        pkg.WsInicioSesion port = service_1.getWsInicioSesionPort();
        return port.iniciaSesion(boleta, contraseña);
        
    }

   
}
