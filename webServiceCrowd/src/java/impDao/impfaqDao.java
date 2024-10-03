/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package impDao;

import BD.ConexionBase;
import dao.ifaqDao;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.faqs;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class impfaqDao implements ifaqDao{
private final String REGISTRAFAQ = "{call spFAQ(1,?,?,?)}";
private final String CAMBIAFAQ = "{call spFAQ(2,?,?,?)}";
private final String CONSULTAADMIN="SELECT * FROM FAQ WHERE VALIDAR = FALSE;";
private final String CONSULTAUSER="SELECT * FROM FAQ WHERE VALIDAR = TRUE;";
    CallableStatement sta;
    @Override
    public int agregaFAQ(faqs f) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(REGISTRAFAQ);
            sta.setString(1, f.getPregunta());
            sta.setString(2, f.getRespuesta());
            sta.setBoolean(3, f.getValidar());
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("id");
            if(verifica != -1){
                System.out.println("agregado");
            }else{
                 System.out.println("UPS");
            }
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            verifica = -1;  
            
        }finally{
            
        }
        return verifica;
    }

    @Override
    public int editafaq(faqs p) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(CAMBIAFAQ);
            sta.setString(1, p.getPregunta());
            sta.setString(2, p.getRespuesta());
            sta.setBoolean(3, true);
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("id");
            if(verifica != -1){
                System.out.println("actualizado");
            }else{
                 System.out.println("UPS");
            }
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            verifica = -1;  
            
        }finally{
            
        }
        return verifica;
    }

    @Override
    public ArrayList<faqs> consultaAdmin() {
       ArrayList<faqs> lista = new ArrayList<>();
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(CONSULTAADMIN);
            res =sta.executeQuery();
            while(res.next()){
                faqs e = new faqs(res.getInt("idfaq"), res.getString("pregunta"), res.getString("respuesta"));
                lista.add(e);
            }
            
            /*verifica=res.getInt("id");
            if(verifica != -1){
                System.out.println("agregado");
            }else{
                 System.out.println("UPS");
            }*/
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            //verifica = -1;  
            
        }finally{
            
        }
        return lista;
    }

    @Override
    public ArrayList<faqs> consultaUser() {
         ArrayList<faqs> lista = new ArrayList<>();
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(CONSULTAUSER);
            res =sta.executeQuery();
            while(res.next()){
                faqs e = new faqs(res.getInt("idfaq"), res.getString("pregunta"), res.getString("respuesta"));
                lista.add(e);
            }
            
            /*verifica=res.getInt("id");
            if(verifica != -1){
                System.out.println("agregado");
            }else{
                 System.out.println("UPS");
            }*/
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            //verifica = -1;  
            
        }finally{
            
        }
        return lista;
    }
    

   
    
}
