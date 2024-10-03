/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package webServices;

import BD.ConexionBase;
import cifrado.CifrarSHA;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import org.apache.commons.codec.binary.Base64;
import org.owasp.esapi.ESAPI;

/**
 *
 * @author benja
 */
public class recuperarPass {
    
    public String validaCorreo(String correo){
        ConexionBase con = new ConexionBase();
                Connection cnx=con.coectarbd();
                Statement sta;
                ResultSet res = null;
                String ver = "";
                try{
                    sta = cnx.createStatement();
                    res= sta.executeQuery("select count(*) as valido from UsuarioN where correo = '"+ESAPI.encoder().encodeForHTML(correo)+"';");
                    res.next();
                    ver = Integer.toString(res.getInt("valido"));
                    if(ver.equals("1")){
                        CifrarSHA cf = new CifrarSHA();
                        ver = new String(Base64.encodeBase64(cf.cifra(correo)));
                    }else{
                        ver="0";
                    }
                }catch(Exception e){
                    System.out.println(e.toString());
                }
        return ver;
    }
    
}
