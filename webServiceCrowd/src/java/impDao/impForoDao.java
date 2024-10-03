/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package impDao;

import BD.ConexionBase;
import dao.iForoDao;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.foro;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class impForoDao implements iForoDao{
private CallableStatement sta;
    private final String REGISTRAFORO= "{call spGuardaForo(0,?,?,?,?,?)}";
    private final String CONSULTATODOS = "select * from foro where pregunta like ? or asunto like ? or categoria like ? or creador like ?;";
    private final String CONSULTAUNO = "select * from foro where idForo= ?;";
    @Override
    public int agregaForo(foro f) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(REGISTRAFORO);
           sta.setString(1, f.getPregunta());
           sta.setString(2, f.getCreador());
           sta.setString(3, f.getAsunto());
           sta.setString(4, f.getCategoria());
           sta.setBlob(5, f.getFoto());
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("id");
            if(verifica != -1){
                System.out.println("agregado");
            }else{
                 System.out.println("error");
            }
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            verifica = -1;  
            
        }
        return verifica;
        
    }

    @Override
    public ArrayList<foro> consultaForo(String busqueda) {
         ArrayList<foro> lista = new ArrayList();
         ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
          sta = cnx.prepareCall(CONSULTATODOS);  
          
          sta.setString(1, "%"+busqueda+"%");
          sta.setString(2, "%"+busqueda+"%");
          sta.setString(3, "%"+busqueda+"%");
          sta.setString(4, "%"+busqueda+"%");
          res = sta.executeQuery();
          while(res.next()){
           foro aux = new foro(res.getInt("idForo"), res.getString("pregunta"), res.getString("creador"), res.getDate("fecha"), res.getString("asunto"), res.getString("categoria"), res.getBlob("imagen").getBinaryStream());
            lista.add(aux);
        }
            System.out.println("Consulta realizada foros");
          
        }catch(Exception e){
            System.out.println(e.toString());
             
            
        }finally{
            
        }
        return lista;
    }

    @Override
    public foro consultaDeUno(int idForo) {
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        foro f = null;
        try{
          sta = cnx.prepareCall(CONSULTAUNO);  
          
          sta.setInt(1, idForo);
          
          res = sta.executeQuery();
          while(res.next()){
           f = new foro(res.getInt("idForo"), res.getString("pregunta"), res.getString("creador"), res.getDate("fecha"), res.getString("asunto"), res.getString("categoria"), res.getBlob("imagen").getBinaryStream());
            
        }
            System.out.println("Consulta realizada un foro");
          
        }catch(Exception e){
            System.out.println(e.toString());
             
            
        }finally{
            
        }
        return f;
    }
    
}
