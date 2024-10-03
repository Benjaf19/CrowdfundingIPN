/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package registroConImagenes;

import dao.iColaboradorDao;
import impDao.impColaboradorDao;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.Colaborador;
import org.owasp.esapi.ESAPI;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
@MultipartConfig( maxFileSize = 999999)
@WebServlet(name = "editaColaborador", urlPatterns = {"/editaColaborador"})
public class editaColaborador extends HttpServlet {

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
            int idC = Integer.parseInt(ESAPI.encoder().encodeForHTML(request.getParameter("idC")));
             String carrera = ESAPI.encoder().encodeForHTML(request.getParameter("carrera"));
            String infoextra = ESAPI.encoder().encodeForHTML(request.getParameter("infoextra"));
            Part p = request.getPart("foto");
            InputStream is = p.getInputStream();
            int verifica;
            
                iColaboradorDao colabo = new impColaboradorDao();
                Colaborador u = new Colaborador(idC, carrera, infoextra,is);
                verifica = colabo.editaColaborador(u);
                if(verifica != -1){
                    System.out.println("se creo el colaborador");
                out.println("<script> alert('Colaborador actualizado con exito'); "
                        + "window.location = 'registraColaborador.jsp';</script>");
                
                }else{
                    System.out.println("no se creo");
                out.println("<script> alert('Error colaborador no actualizado'); </script>");
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
