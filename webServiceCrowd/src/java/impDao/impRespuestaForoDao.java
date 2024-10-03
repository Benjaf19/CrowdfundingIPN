/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package impDao;

import BD.ConexionBase;
import dao.iRespuestaForoDao;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.respuestaForo;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class impRespuestaForoDao implements iRespuestaForoDao{
private CallableStatement sta;
    private final String REGISTRARESPUESTA= "{call spRespondeForo(0,?,?,?)}";
    private final String RESPUESTAPORFORO = "select * from respuestaForo where idForo= ?;";
    @Override
    public int resspondeForo(respuestaForo rf) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(REGISTRARESPUESTA);
            sta.setString(1, rf.getRespuesta());
            sta.setString(2, rf.getUsuario());
            sta.setInt(3, rf.getIdForo());
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("id");
            if(verifica != -1){
                System.out.println("respondido");
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
    public ArrayList<respuestaForo> consultaRespuestas(int idForo) {
        ArrayList<respuestaForo> lista = new ArrayList();
         ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
          sta = cnx.prepareCall(RESPUESTAPORFORO);  
          
          sta.setInt(1, idForo);
         
          res = sta.executeQuery();
          while(res.next()){
           respuestaForo aux = new respuestaForo(res.getInt("idRespuesta"), idForo, res.getString("respuesta"), res.getString("usuario"));
            lista.add(aux);
        }
            System.out.println("Consulta realizada respuestasS");
          
        }catch(Exception e){
            System.out.println(e.toString());
             
            
        }finally{
            
        }
        return lista;
    }
    
}
