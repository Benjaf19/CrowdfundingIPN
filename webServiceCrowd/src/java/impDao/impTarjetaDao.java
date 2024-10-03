/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package impDao;

import BD.ConexionBase;
import dao.iTarjetaDao;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import modelo.Tarjeta;
/**
 *
 * @author Ricardo Palomino Bravo
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class impTarjetaDao implements iTarjetaDao{
    
    private CallableStatement sta;
    private final String REGISTRATARJETA = "{call spGuardaTarjeta(0,?,?,?,?,?,?)}";
    private final String MOSTRARMISTAGS = "select tag.idTarjeta, tag.NumTrajeta, tag.CodigoSeg, tag.fechaVence, tag.Direccion, tag.TipoTag from Tarjeta as tag inner join reltarjetausn as rel on rel.idTarjeta = tag.idTarjeta where rel.boleta = ?;";
    
    @Override
    public int agregaTarjeta(Tarjeta t, int boleta) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(REGISTRATARJETA);
            sta.setString(1, t.getNumTarjeta());
            sta.setInt(2, t.getCodigoSeg());
            sta.setString(3, t.getFechaVence());
            sta.setString(4, t.getDireccion());
            sta.setString(5, t.getTipoTag());
            sta.setInt(6, boleta);
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
    public int editaTarjeta(Tarjeta t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArrayList<Tarjeta> consultaTarjeta(int boleta) {
         ArrayList<Tarjeta> lista = new ArrayList();
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        
        ResultSet res;
        
        try{
        sta = cnx.prepareCall(MOSTRARMISTAGS);
        sta.setInt(1, boleta);
        res = sta.executeQuery();
        while(res.next()){
           Tarjeta aux = new Tarjeta(res.getInt("idTarjeta"), res.getString("NumTrajeta"), res.getInt("CodigoSeg"), res.getString("fechaVence"),res.getString("Direccion"), res.getString("TipoTag"));
            lista.add(aux);
        }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return lista;
    }

    @Override
    public ArrayList<Tarjeta> consultaTarjetaSinBuscar() {
        return null;

    }
    
}
