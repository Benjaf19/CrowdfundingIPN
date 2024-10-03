/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package webServices;

import BD.ConexionBase;
import cifrado.CifrarSHA;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.UsuarioN;
import org.apache.commons.codec.binary.Base64;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */

public class iniciarSesion {
    
    public int iniciarSesion(String pswd, int bol){
        
        int bandera = 0;
         ConexionBase con = new ConexionBase();
            
            Connection cnx = con.coectarbd();
            CifrarSHA cf = new CifrarSHA();
            
            try{
            String contraCifrada = new String(Base64.encodeBase64(cf.cifra(pswd)));
            Statement sta = cnx.createStatement();
            ResultSet res;
            res = sta.executeQuery("select * from UsuarioN where boleta = "+bol+";");
                System.out.println(bol);
            while(res.next()){
                System.out.println(contraCifrada);
               // System.out.println(cf.descifra(Base64.decodeBase64(res.getString("paswd"))));
                    System.out.println(res.getString("escuela"));
                    
                if(res.getString("paswd").equals(contraCifrada)){
                    //Sesion
           // UsuarioN user = new UsuarioN(bol, res.getString("nombre"), res.getString("apellidos"), res.getString("escuela"), res.getInt("edad"), res.getString("correo"), pswd, res.getDate("fRegistro"));
           
                    System.out.println("Todo correcto ");    
                         bandera = 1;
                        
                         
                    break;
                }else{
                    
                    System.out.println("Contraseña incorrecta");
                    bandera = 2; 
                }
            }
            }catch(Exception e){
                System.out.println(e.toString());
            }

        return bandera;
    }
}
   
