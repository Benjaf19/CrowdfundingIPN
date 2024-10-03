/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package impDao;

import BD.ConexionBase;
import dao.iTicketsDao;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.ticketsSoporte;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class impTicketsDao implements iTicketsDao{
    private CallableStatement sta;
    private final String REGISTRATICKET= "{call spGuardaTicket(0,?,?,?,?,?,?,?)}";
    private final String CONSULTAUSUARIO = "select folio from tickets where remitente =? and folio like ?;";
    private final String CONSULTATODOS = "select * from tickets where folio like ? or estado like ?;";
    private final String CONSULTATICKET = "select * from tickets where folio = ?;";
    private final String EDITATICKET = "{call spGuardaTicket(1,?,?,?,?,?,?,?)}";
    

    @Override
    public int realizaTicket(ticketsSoporte t) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(REGISTRATICKET);
            sta.setString(1, t.getReceptor());
            sta.setInt(2, t.getRemitente());
            sta.setString(3, t.getProblema());
            sta.setString(4, t.getEstado());
            sta.setString(5, t.getAsunto());
            sta.setString(6, t.getTipoProblema());
            sta.setString(7, t.getAvance());
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("err");
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
    public int cambiaEstado(ticketsSoporte t) {
       int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(EDITATICKET);
            sta.setString(1, t.getReceptor());
            sta.setInt(2, t.getRemitente());
            sta.setString(3, t.getProblema());
            sta.setString(4, t.getEstado());
            sta.setString(5, t.getAsunto());
            sta.setString(6, t.getTipoProblema());
            sta.setString(7, t.getAvance());
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("err");
            if(verifica != -1){
                System.out.println("editado");
            }else{
                 System.out.println("error al editar");
            }
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            verifica = -1;  
            
        }
        return verifica;
    }

    @Override
    public ticketsSoporte consultaTicket(int folio) {
         ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
       ticketsSoporte t = null;
        try{
            sta = cnx.prepareCall(CONSULTATICKET);
            sta.setInt(1, folio);
            
            
            res =sta.executeQuery();
            
            res.next();
                t = new ticketsSoporte(folio, res.getInt("remitente"), res.getString("receptor"), res.getString("problema"), res.getDate("fecha"), res.getString("asunto"), res.getString("tipoProblema"));
                t.setEstado(res.getString("estado"));
                t.setAvance(res.getString("avances"));
            
    }catch(Exception e){
            System.out.println("error"+ e.toString());
    }
        return t;
    }

    @Override
    public ArrayList<String> consultaUsuario(int remitente,String folio) {
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
       ArrayList<String> folios = new ArrayList<>();
        try{
            sta = cnx.prepareCall(CONSULTAUSUARIO);
            sta.setInt(1, remitente);
            sta.setString(2, "%"+folio+"%");
            
            res =sta.executeQuery();
            String fol = "";
            while(res.next()){
                fol = res.getString("folio");
                folios.add(fol);
            }
            
            
            
            
        }catch(Exception e){
            System.out.println(e.toString());
           
            
        }
       
       return folios;
    }

    @Override
    public ArrayList<ticketsSoporte> consultaTodos(String folio) {
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
       ArrayList<ticketsSoporte> folios = new ArrayList<>();
        try{
            sta = cnx.prepareCall(CONSULTATODOS);
            
            sta.setString(1, "%"+folio+"%");
            sta.setString(2, "%"+folio+"%");
            
            res =sta.executeQuery();
            
            while(res.next()){
                ticketsSoporte aux = new ticketsSoporte(res.getInt("folio"), res.getInt("remitente"), res.getString("receptor"), res.getString("problema"), res.getDate("fecha"), res.getString("asunto"), res.getString("tipoProblema"));
                aux.setAvance(res.getString("avances"));
                aux.setEstado("estado");
                folios.add(aux);
            }
            
            
            
            
        }catch(Exception e){
            System.out.println(e.toString());
           
            
        }
       
       return folios;
    }
    
}
