/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package impDao;

import BD.ConexionBase;
import dao.iProyectoDao;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import modelo.Proyecto;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class impProyectoDao implements iProyectoDao {
    private CallableStatement sta;
    private final String REGISTRAPROYECTO = "{call spGuardaProyectos(0,?,?,?,?,?,?,?,?)}";
    private final String CONSULTASINBUSCAR = "select pp.* from relusnproyect as rel inner join proyectos as pp on pp.idProyecto = rel.idProyecto where not boleta = ?;";
    private final String CONSULTABUSCANDO = "select pp.* from relusnproyect as rel inner join proyectos as pp on pp.idProyecto = rel.idProyecto where not boleta = ? and (pp.nombre like ? or pp.descripcion like ? or pp.categoria like ?);";
    private final String MISPROYECTOS = "select pp.idProyecto, pp.nombre, pp.descripcion, pp.imagen, pp.financiacion, pp.plazotiempo, pp.recompensas, pp.categoria from proyectos as pp inner join relusnproyect as rel on rel.idProyecto = pp.idProyecto where boleta = ?;";
    private final String EDITAPROYECTO = "{call spGuardaProyectos(1,?,?,?,?,?,?,?,?)}";
    private final String SUMARECAUDADA = "select sum(dineroDonado) as suma from donacion where idProyecto = ?;";
    private final String SUMADONADA = "select sum(dineroDonado) as suma from donacion where idProyecto = ? and boleta = ?;";
    private final String ELIMINAPROYECTO = "{call spEliminaProyecto(?)}";
    private final String PROYECTOAPOYADO = "select DISTINCT pp.* from donacion as don inner join proyectos as pp on pp.idProyecto = don.idProyecto where boleta = ?;";
    private final String CONSULTAUNO= "select * from proyectos where nombre= ?;";
    private final String CONSULTAPOPUS = "select distinct pp.* from donacion as don inner join proyectos as pp on don.idProyecto=pp.idProyecto where (don.idProyecto not in(select idProyecto from relusnproyect where boleta=?)) order by don.dineroDonado DESC ;";
    @Override
    public int agregaProyecto(Proyecto u, int boleta) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(REGISTRAPROYECTO);
            sta.setString(1, u.getNombre());
            sta.setString(2, u.getDescripcion());
            sta.setBlob(3, u.getImagen());
            sta.setFloat(4, u.getFinanciacion());
            sta.setInt(5, u.getPlazotiempo());
            sta.setString(6, u.getRecompensas());
            sta.setString(7, u.getCategoria());
            sta.setInt(8, boleta);
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("num");
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
    public int editaProyecto(Proyecto u) {
        int verifica = 0;
         ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(EDITAPROYECTO);
            sta.setString(1, u.getNombre());
            sta.setString(2, u.getDescripcion());
            sta.setBlob(3, u.getImagen());
            sta.setFloat(4, u.getFinanciacion());
            sta.setInt(5, u.getPlazotiempo());
            sta.setString(6, u.getRecompensas());
            sta.setString(7, u.getCategoria());
            sta.setInt(8, verifica);
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("num");
            if(verifica != -1){
                System.out.println("actualizado");
            }else{
                 System.out.println("no se actualizo");
            }
            
            
        }catch(Exception e){
            verifica = -1;
            System.out.println(e.toString());
            
        }finally{
            
        }
        return verifica;
    }
    
     @Override
    public ArrayList<Proyecto> consultaProyectosSinBuscar(int boleta) {
        ArrayList<Proyecto> lista = new ArrayList();
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        
        ResultSet res;
        
        try{
        sta = cnx.prepareCall(CONSULTASINBUSCAR);
        sta.setInt(1, boleta);
        res = sta.executeQuery();
        
        while(res.next()){
           Proyecto aux = new Proyecto(res.getInt("idProyecto"), res.getString("nombre"),  res.getString("descripcion"),  res.getBlob("imagen").getBinaryStream(), res.getFloat("financiacion"), res.getInt("plazotiempo"), res.getString("recompensas"), res.getString("categoria"));
            lista.add(aux);
        }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return lista;
    }

    @Override
    public ArrayList<Proyecto> consultaProyectos(String palabra,int boleta) {
         ArrayList<Proyecto> lista = new ArrayList();
         ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
          sta = cnx.prepareCall(CONSULTABUSCANDO);  
          sta.setInt(1, boleta);
          sta.setString(2, "%"+palabra+"%");
          sta.setString(3, "%"+palabra+"%");
          sta.setString(4, "%"+palabra+"%");
          res = sta.executeQuery();
          while(res.next()){
           Proyecto aux = new Proyecto(res.getInt("idProyecto"), res.getString("nombre"),  res.getString("descripcion"),  res.getBlob("imagen").getBinaryStream(), res.getFloat("financiacion"), res.getInt("plazotiempo"), res.getString("recompensas"), res.getString("categoria"));
            lista.add(aux);
        }
            System.out.println("Consulta realizada");
          
        }catch(Exception e){
            System.out.println(e.toString());
             
            
        }finally{
            
        }
        return lista;
    }

    @Override
    public ArrayList<Proyecto> consultaMisProyectos(int boleta) {
       ArrayList<Proyecto> misPro = new ArrayList<>();
       ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(MISPROYECTOS);
            sta.setInt(1, boleta);
            res =sta.executeQuery();
            Proyecto p ;
            while(res.next()){
                p = new Proyecto(res.getInt("idProyecto"), res.getString("nombre"),  res.getString("descripcion"),  res.getBlob("imagen").getBinaryStream(), res.getFloat("financiacion"), res.getInt("plazotiempo"), res.getString("recompensas"), res.getString("categoria"));
                misPro.add(p);
            }
            
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            
            
        }finally{
            
        }
       
       return misPro;
    }

    @Override
    public double cantidadRecaudada(int idProyecto) {
        double suma = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(SUMARECAUDADA);
            sta.setInt(1, idProyecto);
            res = sta.executeQuery();
            res.next();
            suma = res.getDouble("suma");
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return suma;
    }

    @Override
    public int eliminaProyecto(int idProyect) {
       int verifica = 0;
       ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
        sta = cnx.prepareCall(ELIMINAPROYECTO);
        sta.setInt(1, idProyect);
        res = sta.executeQuery();
        res.next();
        verifica = res.getInt("id");
        }catch(Exception e){
            System.out.println(e.toString());
            verifica = 0;
        }finally{
            
        }
       return verifica;
    }

    @Override
    public ArrayList<Proyecto> consultaProyectosApoyados(int boleta) {
         ArrayList<Proyecto> lista = new ArrayList();
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
       
        ResultSet res;
        
        try{
        sta = cnx.prepareCall(PROYECTOAPOYADO);
        sta.setInt(1, boleta);
        res = sta.executeQuery();
        
        while(res.next()){
            
           Proyecto aux = new Proyecto(res.getInt("idProyecto"), res.getString("nombre"),  res.getString("descripcion"),  res.getBlob("imagen").getBinaryStream(), res.getFloat("financiacion"), res.getInt("plazotiempo"), res.getString("recompensas"), res.getString("categoria"));
            lista.add(aux);
            
        }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return lista;
    }

    @Override
    public Proyecto buscaonlyone(String nombre) {
       ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
       
        ResultSet res;
         Proyecto aux = null;
        
        try{
        sta = cnx.prepareCall(CONSULTAUNO);
        sta.setString(1, nombre);
        res = sta.executeQuery();
        
        while(res.next()){
            
          aux = new Proyecto(res.getInt("idProyecto"), res.getString("nombre"),  res.getString("descripcion"),  res.getBlob("imagen").getBinaryStream(), res.getFloat("financiacion"), res.getInt("plazotiempo"), res.getString("recompensas"), res.getString("categoria"));
          
            
        }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return aux;
    }

    @Override
    public double cantidadDonada(int idProyecto,int boleta) {
       double suma = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(SUMADONADA);
            sta.setInt(1, idProyecto);
            sta.setInt(2, boleta);
            res = sta.executeQuery();
            res.next();
            suma = res.getDouble("suma");
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return suma;
    }

    @Override
    public ArrayList<Proyecto> consultaPopulares(int boleta) {
        ArrayList<Proyecto> lista = new ArrayList();
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
       
        ResultSet res;
        
        try{
        sta = cnx.prepareCall(CONSULTAPOPUS);
        sta.setInt(1, boleta);
        res = sta.executeQuery();
        
        while(res.next()){
            
           Proyecto aux = new Proyecto(res.getInt("idProyecto"), res.getString("nombre"),  res.getString("descripcion"),  res.getBlob("imagen").getBinaryStream(), res.getFloat("financiacion"), res.getInt("plazotiempo"), res.getString("recompensas"), res.getString("categoria"));
            lista.add(aux);
            
        }
        }catch(Exception e){
            System.out.println(e.toString());
        }
        
        return lista;
    }
    
    
}
