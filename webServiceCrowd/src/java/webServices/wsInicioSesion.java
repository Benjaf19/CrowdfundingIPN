/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package webServices;

import BD.ConexionBase;
import cifrado.CifrarSHA;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import dao.iDonacionDao;
import dao.iPaypalDao;
import dao.iUsuarioNDao;
import dao.iProyectoDao;
import dao.iTarjetaDao;
import impDao.impDonacionDao;
import impDao.impPaypalDao;
import impDao.impProyectoDao;
import impDao.impTarjetaDao;
import impDao.impUsuarioNDao;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import modelo.Donacion;
import modelo.Paypal;
import modelo.Proyecto;
import modelo.Tarjeta;
import modelo.UsuarioN;
import org.apache.commons.io.IOUtils;

import org.owasp.esapi.ESAPI;
import org.owasp.esapi.codecs.Base64;
import servlets.IS;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
@WebService(serviceName = "wsInicioSesion")
public class wsInicioSesion {

    /**
     * This is a sample web service operation
     */
    
    @WebMethod(operationName = "iniciaSesion")
    public int iniciaSesion(@WebParam(name = "boleta") int bol,@WebParam(name = "contraseña") String pswd ){
        iniciarSesion ses = new iniciarSesion();
        int verifica =ses.iniciarSesion(pswd, bol);
        if(verifica==1){
            
        }
        return verifica;
    }
    @WebMethod(operationName = "registroUsuario")
    public int registroUsuario(@WebParam(name = "boleta") int bol,@WebParam(name = "nombre") String nombre,@WebParam(name = "apellidos") String apellidos,@WebParam(name = "escuela") String escuela,@WebParam(name = "edad") int edad,@WebParam(name = "correo") String correo,@WebParam(name = "contraseña") String contra ){
        Date fecha = new Date();
        iUsuarioNDao us = new impUsuarioNDao();
        CifrarSHA cf = new CifrarSHA();
        String contracifrada="";
        try{
        contracifrada = new String(org.apache.commons.codec.binary.Base64.encodeBase64(cf.cifra(contra)));
        }catch(Exception e){
            System.out.println(e.toString());
        }
        UsuarioN u = new UsuarioN(bol, nombre, apellidos, escuela, edad, ESAPI.encoder().encodeForHTML(correo), contracifrada, fecha);
        int verifica=us.agregaUsuario(u);
        return verifica;
    }
    @WebMethod(operationName = "consultaUsuario")
    public String consultaUsuario(@WebParam(name = "boleta") int bol){
        
        iUsuarioNDao us = new impUsuarioNDao();
        UsuarioN u = us.consultaUsuario(bol);
        String user = u.getBoleta()+","+u.getNombre()+","+u.getApellidos()+","+u.getEscuela()+","+u.getEdad()+","+ESAPI.encoder().decodeForHTML(u.getCorreo())+","+u.getContraseña();
        return user;
    }
    @WebMethod(operationName = "editaUsuario")
    public int editaUsuario(@WebParam(name = "boleta") int bol,@WebParam(name = "nombre") String nombre,@WebParam(name = "apellidos") String apellidos,@WebParam(name = "escuela") String escuela,@WebParam(name = "edad") int edad,@WebParam(name = "correo") String correo,@WebParam(name = "contraseña") String contra ){
        Date fecha = new Date();
        iUsuarioNDao us = new impUsuarioNDao();
        CifrarSHA cf = new CifrarSHA();
        String contracifrada="";
        try{
        contracifrada = new String(org.apache.commons.codec.binary.Base64.encodeBase64(cf.cifra(contra)));
        }catch(Exception e){
            System.out.println(e.toString());
        }
        UsuarioN u = new UsuarioN(bol, nombre, apellidos, escuela, edad, ESAPI.encoder().encodeForHTML(correo), contracifrada, fecha);
        int verifica=us.editaUsuario(u);
        return verifica;
    }
    
    @WebMethod(operationName = "validaCorreo")
    public String validaCorreo(@WebParam(name = "correo") String correo){
        String valor = "";
        recuperarPass rec = new recuperarPass();
        valor =rec.validaCorreo(correo);
        
        return valor;
    }
     @WebMethod(operationName = "registraProyecto")
    public int registraProyecto(@WebParam(name = "nombreProyecto") String nombre,@WebParam(name = "descripcion") String descripcion,@WebParam(name = "imagen")String img,@WebParam(name = "financiacion") String fin,@WebParam(name = "plazoTiempo") int plazo,@WebParam(name = "recompensas") String recom,@WebParam(name = "categoria") String cat,@WebParam(name = "boleta") int bol ){
        Float finan = Float.parseFloat(fin);
        String imgdes="";
        
        /*try{
        StandardCharsets.UTF_8
        CifrarSHA cf = new CifrarSHA();
        imgdes = cf.descifra(Base64.decodeBase64(img));
            System.out.println(imgdes);
        }catch(Exception e){
            
        }*/
       imgdes= new String();
        byte[] bii =  Base64.decode(img);
         InputStream is = new ByteArrayInputStream(bii);
        Proyecto us = new Proyecto(0, nombre, descripcion, is, finan, plazo, recom, cat);
        iProyectoDao po = new impProyectoDao();
        int verifica=po.agregaProyecto(us, bol);
         System.out.println("REalizo el alta");
        return verifica;
    }
    
@WebMethod(operationName = "consultaProyecto")
    public String consultaProyecto(@WebParam(name = "nombreProyecto") String nombre ){
        
        String fotocf = "";
       
         iProyectoDao po = new impProyectoDao();
         String ruta = "";
        Proyecto pro = po.buscaonlyone(nombre);
        pro.getImagen();
        
        try {
             ByteArrayOutputStream os = new ByteArrayOutputStream();
                        byte barray[] = new byte[1024];
                        int n = 0;
                        InputStream is = pro.getImagen();
                        while ((n = is.read(barray)) >= 0) {
                            os.write(barray, 0, n);
                        }
                        is.close();
                        byte[] bys = os.toByteArray();
                        byte[] encodedBytes = java.util.Base64.getEncoder().encode(bys);
                         ruta= new String(encodedBytes, "UTF-8");
            String foto = IOUtils.toString(pro.getImagen());
            System.out.println("RUTA--"+ruta);
             fotocf= Base64.encodeBytes(foto.getBytes());
             System.out.println("FOTO--"+fotocf);
//java.util.Base64.getEncoder().encodeToString(foto.getBytes());
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
       
         System.out.println("REalizo consulta");
         System.out.println(fotocf);
        return ruta;//pro.getIdProyecto()+"<->"+pro.getNombre()+"<->"+pro.getDescripcion()+"<->"+fotocf+"<->"+pro.getFinanciacion()+"<->"+pro.getPlazotiempo()+"<->"+pro.getRecompensas()+"<->"+pro.getCategoria();
    }
    @WebMethod(operationName = "consultaProyectosBuscando")
    public String consultaProyectosBuscando(@WebParam(name = "nombreProyecto") String nombre,@WebParam(name = "boleta") int bol){
        iProyectoDao pro = new impProyectoDao();
        ArrayList<Proyecto> lista = new ArrayList<>();
        lista = pro.consultaProyectos(nombre, bol);
        JsonArray j = new JsonArray();
        String ruta = "";
      try{
        
        for (int i = 0; i < lista.size(); i++) {
             ByteArrayOutputStream os = new ByteArrayOutputStream();
                        byte barray[] = new byte[1024];
                        int n = 0;
                        InputStream is = lista.get(i).getImagen();
                        while ((n = is.read(barray)) >= 0) {
                            os.write(barray, 0, n);
                        }
                        is.close();
                        byte[] bys = os.toByteArray();
                        byte[] encodedBytes = java.util.Base64.getEncoder().encode(bys);
                         ruta= new String(encodedBytes, "UTF-8");
            Double suma = pro.cantidadRecaudada(lista.get(i).getIdProyecto());
            
            JsonObject ja = new JsonObject();
            ja.addProperty("idProyecto", lista.get(i).getIdProyecto());
            ja.addProperty("nombre", lista.get(i).getNombre());
            ja.addProperty("descripcion", lista.get(i).getDescripcion());
            ja.addProperty("imagen", ruta);
            ja.addProperty("financiacion", lista.get(i).getFinanciacion());
            ja.addProperty("plazo", lista.get(i).getPlazotiempo());
            ja.addProperty("recompensa", lista.get(i).getRecompensas());
            ja.addProperty("categoria", lista.get(i).getCategoria());
             ja.addProperty("suma", suma);
            j.add(ja);
            
        }
          System.out.println(j.toString());
      }catch(Exception e){
          System.out.println(e.toString());
      }
        
       
        return j.toString();
    }
     @WebMethod(operationName = "consultaMisProyectos")
    public String consultaMisProyectos(@WebParam(name = "boleta") int bol){
        iProyectoDao pro = new impProyectoDao();
        ArrayList<Proyecto> lista = new ArrayList<>();
        lista = pro.consultaMisProyectos(bol);
        JsonArray j = new JsonArray();
        String ruta = "";
      try{
        
        for (int i = 0; i < lista.size(); i++) {
             ByteArrayOutputStream os = new ByteArrayOutputStream();
                        byte barray[] = new byte[1024];
                        int n = 0;
                        InputStream is = lista.get(i).getImagen();
                        while ((n = is.read(barray)) >= 0) {
                            os.write(barray, 0, n);
                        }
                        is.close();
                        byte[] bys = os.toByteArray();
                        byte[] encodedBytes = java.util.Base64.getEncoder().encode(bys);
                         ruta= new String(encodedBytes, "UTF-8");
            Double suma = pro.cantidadRecaudada(lista.get(i).getIdProyecto());
            
            JsonObject ja = new JsonObject();
            ja.addProperty("idProyecto", lista.get(i).getIdProyecto());
            ja.addProperty("nombre", lista.get(i).getNombre());
            ja.addProperty("descripcion", lista.get(i).getDescripcion());
            ja.addProperty("imagen", ruta);
            ja.addProperty("financiacion", lista.get(i).getFinanciacion());
            ja.addProperty("plazo", lista.get(i).getPlazotiempo());
            ja.addProperty("recompensa", lista.get(i).getRecompensas());
            ja.addProperty("categoria", lista.get(i).getCategoria());
             ja.addProperty("suma", suma);
            j.add(ja);
            
        }
          System.out.println(j.toString());
      }catch(Exception e){
          System.out.println(e.toString());
      }
        
       
        return j.toString();
    }
     @WebMethod(operationName = "editaProyecto")
    public int editaProyecto(@WebParam(name = "nombreProyecto") String nombre,@WebParam(name = "descripcion") String descripcion,@WebParam(name = "imagen")String img,@WebParam(name = "financiacion") String fin,@WebParam(name = "plazoTiempo") int plazo,@WebParam(name = "recompensas") String recom,@WebParam(name = "categoria") String cat ){
        Float finan = Float.parseFloat(fin);
        
        
        
        byte[] bii =  Base64.decode(img);
         InputStream is = new ByteArrayInputStream(bii);
        Proyecto us = new Proyecto(0, nombre, descripcion, is, finan, plazo, recom, cat);
        iProyectoDao po = new impProyectoDao();
        int verifica=po.editaProyecto(us);
         System.out.println("Edito el proyecto");
        return verifica;
    }
     @WebMethod(operationName = "eliminaProyecto")
    public int eliminaProyecto(@WebParam(name = "idProyecto") int idP){
            
        
        
        
       
        iProyectoDao po = new impProyectoDao();
        int verifica=po.eliminaProyecto(idP);
         System.out.println("Elimino el proyecto");
        return verifica;
    }
    
     @WebMethod(operationName = "realizaDonacion")
    public int realizaDonacion(@WebParam(name = "idProyecto") int idP,@WebParam(name = "boleta") int bol,@WebParam(name = "monto") String monto){
            
        iDonacionDao don = new impDonacionDao();
                Donacion d = new Donacion(0, idP, bol, Double.parseDouble(monto));
        int verifica=don.realizaDonacion(d);
         System.out.println("agrego donacion");
        return verifica;
    }
     @WebMethod(operationName = "consultaTarjetas")
    public String consultaTarjetas(@WebParam(name = "boleta") int bol){
       String json = "";
       ArrayList<Tarjeta> lista = new ArrayList<>();
       iTarjetaDao tag = new impTarjetaDao();
       lista = tag.consultaTarjeta(bol);
       JsonArray j = new JsonArray();
       
         for (int i = 0; i < lista.size(); i++) {
             JsonObject ja = new JsonObject();
            ja.addProperty("numeroTAG", lista.get(i).getNumTarjeta());
            
            j.add(ja);
         }
       
       
       
       return j.toString();
    }
    @WebMethod(operationName = "consultaPayPal")
    public String consultaPayPal(@WebParam(name = "boleta") int bol){
       String json = "";
       ArrayList<Paypal> lista = new ArrayList<>();
       iPaypalDao p = new impPaypalDao();
       lista = p.consultaPaypal(bol);
       JsonArray j = new JsonArray();
       
         for (int i = 0; i < lista.size(); i++) {
             JsonObject ja = new JsonObject();
            ja.addProperty("correoPP", ESAPI.encoder().decodeForHTML(lista.get(i).getCorreoPP()));
            ja.addProperty("contraPP", lista.get(i).getContraseña());
            
            j.add(ja);
         }
       
       
       
       return j.toString();
    }
    @WebMethod(operationName = "verificaPaypal")
    public int verificaPaypal(@WebParam(name = "correoPP") String correo,@WebParam(name = "contraPP") String contra){
       int verifica = 0;
        CifrarSHA cf = new CifrarSHA();
        try {
            String contracf= new String(org.apache.commons.codec.binary.Base64.encodeBase64(cf.cifra(contra)));
            iPaypalDao p = new impPaypalDao();
            verifica = p.verificaContra(contracf, ESAPI.encoder().encodeForHTML(correo));
            
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
       
       
       
       return verifica;
    }
     @WebMethod(operationName = "registraPaypal")
    public int registraPaypal(@WebParam(name = "correoPP") String correo,@WebParam(name = "contraPP") String contra,@WebParam(name = "boleta")int boleta){
       int verifica = 0;
        CifrarSHA cf = new CifrarSHA();
        try {
            String contracf= new String(org.apache.commons.codec.binary.Base64.encodeBase64(cf.cifra(contra)));
            iPaypalDao p = new impPaypalDao();
            Paypal pp = new Paypal(0, ESAPI.encoder().encodeForHTML(correo), contracf);
            verifica = p.agregaPaypal(pp, boleta);
            
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
       
       
       
       return verifica;
    }
    @WebMethod(operationName = "registraTarjeta")
    public int registraTarjeta(@WebParam(name = "numTarjeta") String num,@WebParam(name = "codigo") int code,@WebParam(name = "fecha") String fecha,@WebParam(name = "direccion") String dir,@WebParam(name = "tipoTag") String tipo,@WebParam(name = "boleta")int boleta){
       int verifica = 0;
        
        try {
            
           iTarjetaDao ta = new impTarjetaDao();
           Tarjeta t = new Tarjeta(0, num, code, fecha, dir, tipo);
           verifica = ta.agregaTarjeta(t, boleta);
            
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }
       
       
       
       return verifica;
    }
    
}
