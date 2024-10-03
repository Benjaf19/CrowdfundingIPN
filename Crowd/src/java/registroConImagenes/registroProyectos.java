/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package registroConImagenes;

import dao.iProyectoDao;
import impDao.impProyectoDao;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import modelo.Proyecto;
import modelo.UsuarioN;
import org.owasp.esapi.ESAPI;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
@MultipartConfig( maxFileSize = 999999)
@WebServlet(name = "registroProyectos", urlPatterns = {"/registroProyectos"})
public class registroProyectos extends HttpServlet {

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
            UsuarioN user=(UsuarioN) sesion.getAttribute("usuario");
            String nombre = ESAPI.encoder().encodeForHTML(request.getParameter("nombre"));
            String descripcion = ESAPI.encoder().encodeForHTML(request.getParameter("descripcion"));
            Part img = request.getPart("img");
            float financiacion = Float.parseFloat(ESAPI.encoder().encodeForHTML(request.getParameter("finan")));
            int tiempo = Integer.parseInt(ESAPI.encoder().encodeForHTML(request.getParameter("plazo")));
            String recompensa = ESAPI.encoder().encodeForHTML(request.getParameter("recompensas"));
            String categoria = ESAPI.encoder().encodeForHTML(request.getParameter("categoria"));
            
            
            int verifica;
            
            
                InputStream is = img.getInputStream();
                iProyectoDao pro = new impProyectoDao();
                Proyecto u = new Proyecto(0, nombre, descripcion, is, financiacion, tiempo, recompensa, categoria);
                verifica =pro.agregaProyecto(u,user.getBoleta());
                
                if(verifica != -1){
                    System.out.println("se creo el proeycto");
                out.println("<script> alert('Proyecto registrado con exito'); "
                        + "window.location = 'informacionUsuario.jsp';</script>");
                
                }else{
                    System.out.println("no se creo");
                out.println("<script> alert('Error proyecto no registrado'); "
                        + "window.location = 'registraProyecto.jsp';</script>");
                }
            out.println("</body>");
            out.println("</html>");
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
