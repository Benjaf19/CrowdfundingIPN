/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package impDao;

import BD.ConexionBase;
import dao.iPaypalDao;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import modelo.Paypal;
/**
 *
 * @author Ricardo Palomino Bravo
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class impPaypalDao implements iPaypalDao{
    
    private CallableStatement sta;
    private final String REGISTRAPAYPAL = "{call spGuardaPaypal(0,?,?,?)}";
    //private final String CONSULTASINBUSCAR = "SELECT * FROM PROYECTOS LIMIT 10;";
    private final String VERIFICAPASSWORD = "SELECT CONTRASEÑA FROM PAYPAL WHERE CORREOPP = ?;";
    private final String MOSTRARMISPAYPALS = "select pp.idPaypal,pp.CorreoPP, pp.contraseña from paypal as pp inner join relpaypalusn as rel on rel.idPaypal = pp.idPaypal where rel.boleta = ?;";

    @Override
    public int agregaPaypal(Paypal p,int boleta) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(REGISTRAPAYPAL);
            sta.setString(1, p.getCorreoPP());
            sta.setString(2, p.getContraseña());
            sta.setInt(3, boleta);
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("id");
            if(verifica != -1){
                System.out.println("agregado");
            }else{
                 System.out.println("ya existe");
            }
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            verifica = -1;  
            
        }finally{
            
        }
        return verifica;
    }

    @Override
    public int editaPaypal(Paypal p) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Paypal> consultaPaypal(int boleta) {
        ArrayList<Paypal> lista = new ArrayList();
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        
        ResultSet res;
        
        try{
        sta = cnx.prepareCall(MOSTRARMISPAYPALS);
        sta.setInt(1, boleta);
        res = sta.executeQuery();
        while(res.next()){
           Paypal aux = new Paypal(res.getInt("idPaypal"), res.getString("correoPP"), res.getString("contraseña"));
            lista.add(aux);
        }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return lista;
    }

    @Override
    public ArrayList<Paypal> consultaPaypalSinBuscar() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int verificaContra(String pswd, String correo) {
       int verifica = 0;
       ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        
        ResultSet res;
        
        try{
       
        sta = cnx.prepareCall(VERIFICAPASSWORD);
        sta.setString(1, correo);
        res = sta.executeQuery();
        res.next();
        if(res.getString("contraseña").equals(pswd)){
            verifica = 1;
        }else{
            verifica = -1;
        }
          
            
        
        }catch(Exception e){
            System.out.println(e.toString());
            verifica = -1;
        }
       
       return verifica;
    }
    
    
    
    
}
