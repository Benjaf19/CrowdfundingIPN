/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package impDao;

import BD.ConexionBase;
import dao.iDonacionDao;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import modelo.Donacion;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class impDonacionDao implements iDonacionDao{
    private CallableStatement sta;
    private final String REALIZADONACION = "{call spRealizaDonacion(?,?,?)}";
    @Override
    public int realizaDonacion(Donacion d) {
        int verifica = 0;
         ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(REALIZADONACION);
            sta.setInt(1, d.getIdProyecto());
            sta.setInt(2, d.getBoleta());
            sta.setDouble(3,d.getDineroDonado());
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("id");
            if(verifica > 0){
                System.out.println("agregado");
            }else{
                 System.out.println("ya existe");
            }
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            verifica = 0;  
            
        }finally{
            
            
        }
        return verifica;
    }
    
}
