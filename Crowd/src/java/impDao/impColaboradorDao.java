/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package impDao;

import BD.ConexionBase;
import dao.iColaboradorDao;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.Colaborador;
/**
 *
 * @author Ricardo Palomino Bravo y Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class impColaboradorDao implements iColaboradorDao{
    private CallableStatement sta;
    private final String REGITRACOLABORADOR = "{call spGuardaColaborador(0,?,?,?,?)}";
    private final String CONSULTAUNCOLABORADOR = "select idColaborador from relcolabusn where boleta = ?;";
    private final String CONSULTACARRERAS = "select carrera from carreras where CECYT = ?;";
    private final String EDITACOLABORADOR = "{call spGuardaColaborador(?,?,?,?,?)}";
    private final String CONSULTATODOSCOLAB="select us.boleta,us.nombre,us.apellidos,us.edad,us.escuela, col.carrera,col.foto,col.infoExtra,col.idColaborador from relcolabusn as co inner join usuarion as us on us.boleta= co.boleta inner join colaborador as col on col.idColaborador = co.idColaborador where ((co.idColaborador not in(select idColaborador from relcolabusn where boleta=?))and(co.idColaborador not in(select idColaborador from solicitudcolaborador where boleta=?))and((infoExtra like ?) or (Carrera like ?))); ";
    private final String REALIZASOLICITUD = "{call spRealizaSolicitud(0,?,?,?)}";
    private final String SOLICITUDRECIBIDA="select us.nombre,us.apellidos,us.escuela,sol.idSolicitud, pro.nombre as pronom,us.correo from solicitudcolaborador as sol inner join usuarion as us on us.boleta= sol.boleta inner join proyectos as pro on sol.idProyecto = pro.idProyecto where idColaborador=? and validar=false; ";
    private final String ACEPTASOLICITUD = "{call spRealizaSolicitud(1,0,0,?)}";
    private final String ELIMINASOLICITUD = "{call spRealizaSolicitud(2,0,0,?)}";
    private final String CORREOREMITENTE="select us.correo from solicitudcolaborador as sol inner join relcolabusn as rel on rel.idColaborador = sol.idColaborador  inner join usuarion as us on us.boleta= sol.boleta where sol.idSolicitud=?;";
    
    @Override
    public int agregaColaborador(Colaborador u, int boleta) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(REGITRACOLABORADOR);
            sta.setString(1, u.getCarrera());
            sta.setString(2, u.getInfoExtra());
            sta.setBlob(3, u.getFoto());
            sta.setInt(4, boleta);
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
    public int editaColaborador(Colaborador u) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(EDITACOLABORADOR);
            sta.setInt(1, u.getIdColaborador());
            sta.setString(2, u.getCarrera());
            sta.setBlob(4, u.getFoto());
            sta.setInt(5, 0);
            sta.setString(3, u.getInfoExtra());
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("id");
            if(verifica != -1){
                System.out.println("actualizado");
            }else{
                 System.out.println("ups");
            }
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            verifica = -1;  
            
        }finally{
            
            
        }
        return verifica;
    }

    @Override
    public ArrayList<Colaborador> consultaColaborador(String palabra,int boleta) {
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
         ArrayList<Colaborador> aux = new ArrayList<>();
         Colaborador co = null;
        try{
        sta = cnx.prepareCall(CONSULTATODOSCOLAB);
        sta.setInt(1, boleta);
        sta.setInt(2, boleta);
        sta.setString(3, "%"+palabra+"%");
        sta.setString(4, "%"+palabra+"%");
       res = sta.executeQuery();
       while(res.next()){
           co= new Colaborador(res.getInt("idColaborador"), res.getString("carrera"), res.getString("infoExtra"), res.getBlob("foto").getBinaryStream());
       aux.add(co);
       
       }
      
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return aux;
    }

    @Override
    public Colaborador consultaColabBoleta(int boleta) {
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
         Colaborador aux = null;
        try{
        sta = cnx.prepareCall(CONSULTAUNCOLABORADOR);
        sta.setInt(1, boleta);
       res = sta.executeQuery();
       res.next();
       int id = res.getInt("idColaborador");
       res =sta.executeQuery("select * from Colaborador where idColaborador = "+id+";");
       res.next();
       
       aux = new Colaborador(res.getInt("idColaborador"), res.getString("carrera"), res.getString("infoextra"),res.getBlob("foto").getBinaryStream());
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return aux;
    }

    @Override
    public ArrayList<String> carreras(String escuela) {
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
         ArrayList<String> aux = new ArrayList<>();
        try{
        sta = cnx.prepareCall(CONSULTACARRERAS);
        sta.setString(1, escuela);
       res = sta.executeQuery();
       while(res.next()){
       aux.add(res.getString("carrera"));
       
       }
      
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return aux;
    }

    @Override
    public int realizaSolicitud(int idColaborador, int idProyecto, int boleta) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(REALIZASOLICITUD);
            sta.setInt(1,idColaborador);
            sta.setInt(2,idProyecto);
            sta.setInt(3,boleta);
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("id");
            if(verifica != -1){
                System.out.println("Solicitud enviada");
            }else{
                 System.out.println("errorrr");
            }
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            verifica = -1;  
            
        }finally{
            
            
        }
        return verifica;
    }

    @Override
    public ArrayList<String> consultaSolicitudRecibida(int idColab) {
       ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
         ArrayList<String> aux = new ArrayList<>();
        try{
        sta = cnx.prepareCall(SOLICITUDRECIBIDA);
        sta.setInt(1, idColab);
       res = sta.executeQuery();
       String solicitud = "";
       while(res.next()){
           solicitud = "<p style='font-size:20px;color:black; font-family:Oswald;'>Has recibido una solicitud de "+res.getString("nombre")+" "+res.getString("apellidos")+" para participar como colaborador en el proyecto </p>"
                   + "<form action='proyecto.jsp' method='post'><input type='hidden'  name='criterio' value='"+res.getString("pronom")+"'/> "
                   + "<input type='hidden' name='Buscar' value='Buscar'/><input type='submit' class='Don2' name='Proyecto' value='"+res.getString("pronom")+"'/>"
                   + "</form> <p style='font-size:20px;color:black;font-family:Oswald;'>Si deseas participar pulsa </p><form action='aceptaCorreos' method='post'><input type='hidden' name='idSol' value='"+res.getString("idSolicitud")+"'/> <input type='submit' class='Don2' name='envia' value='Aceptar'/></form><p style='font-size:20px;color:black;'> o de lo contrario puedes </p><form  method='post' action='aceptaCorreos'><input type='hidden' name='idSol' value='"+res.getString("idSolicitud")+"'/> <input type='submit' class='Don2' name='envia' value='Eliminarla'/>"
                   + "</form> "
                   + "<p style='font-size:20px;color:black;font-family: Oswald;'>o solo ignorala.</p>";
       aux.add(solicitud);
       
       }
      
        }catch(Exception e){
            System.out.println(e.toString());
        }
        return aux;
    }

    @Override
    public int eliminaSolicitud(int idSolicitud) {
       int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(ELIMINASOLICITUD);
            sta.setInt(1, idSolicitud);
            
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("id");
            if(verifica != -1){
                System.out.println("Eliminado");
            }else{
                 System.out.println("Error elimanr");
            }
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            verifica = -1;  
            
        }finally{
            
            
        }
        return verifica;
    }

    @Override
    public String aceptaSolicitud(int idSolicitud) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res,res2;
         String correo = "";
        try{
            sta = cnx.prepareCall(ACEPTASOLICITUD);
            sta.setInt(1, idSolicitud);
            
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("id");
            if(verifica != -1){
                System.out.println("Aceptada");
                sta = cnx.prepareCall(CORREOREMITENTE);
                sta.setInt(1, idSolicitud);
                res2 = sta.executeQuery();
                res2.next();
              correo =res2.getString("correo");
            }else{
                 System.out.println("Error aceptar");
            }
            
            
        }catch(Exception e){
            System.out.println(e.toString());
            verifica = -1;  
            
        }finally{
            
            
        }
        return correo;
    }

    
    
}
