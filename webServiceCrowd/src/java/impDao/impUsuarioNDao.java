/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package impDao;

import BD.ConexionBase;
import cifrado.CifrarSHA;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.List;
import modelo.UsuarioN;
import dao.iUsuarioNDao;
import org.apache.commons.codec.binary.Base64;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class impUsuarioNDao implements iUsuarioNDao{
private CallableStatement sta;
private final String REGISTRAUSUARIO = "{call spGuardaUsuarioN(0,?,?,?,?,?,?,?)}";
private final String MODIFICAUSUARIO = "{call spGuardaUsuarioN(1,?,?,?,?,?,?,?)}";
private final String RECUPERACONTRASEÑA = "{call spRecuperaContra(?,?)}";
private final String CONSULTAUSER="SELECT * FROM USUARION WHERE BOLETA = ?";
private final String CONSULTACOLUSN = "select us.* from relcolabusn as co inner join usuarion as us on us.boleta= co.boleta inner join colaborador as col on col.idColaborador = co.idColaborador where co.idColaborador=?;";
    @Override
    public int agregaUsuario(UsuarioN u) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(REGISTRAUSUARIO);
            sta.setInt(1, u.getBoleta());
            sta.setString(2, u.getNombre());
            sta.setString(3, u.getApellidos());
            sta.setString(4, u.getEscuela());
            sta.setInt(5, u.getEdad());
            sta.setString(6, u.getCorreo());
            sta.setString(7, u.getContraseña());
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("err");
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
    public void eliminaUsuario(int idUsuario) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int editaUsuario(UsuarioN u) {
        int verifica = 0;
         ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        
        try{
            sta = cnx.prepareCall(MODIFICAUSUARIO);
            sta.setInt(1, u.getBoleta());
            sta.setString(2, u.getNombre());
            sta.setString(3, u.getApellidos());
            sta.setString(4, u.getEscuela());
            sta.setInt(5, u.getEdad());
            sta.setString(6, u.getCorreo());
            sta.setString(7, u.getContraseña());
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("err");
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
    public List<UsuarioN> consultaUsuarios(String nombre) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public UsuarioN consultaUsuario(int idUsuario) {
       UsuarioN user = null;
       ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        CifrarSHA cf = new CifrarSHA();
        try{
        sta = cnx.prepareCall(CONSULTAUSER);
        sta.setInt(1, idUsuario);
        res = sta.executeQuery();
        res.next();
        user = new UsuarioN(idUsuario, res.getString("nombre"), res.getString("apellidos"), res.getString("escuela"), res.getInt("edad"), res.getString("correo"),cf.descifra(Base64.decodeBase64(res.getString("paswd"))), res.getDate("fRegistro"));
        }catch(Exception e){
            System.out.println(e.toString());
        }finally{
            
        }
       return user;
    }

    @Override
    public int recuperaContra(String correo, String nuevaContra) {
        int verifica = 0;
        ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        try{
            sta = cnx.prepareCall(RECUPERACONTRASEÑA);
            sta.setString(1, correo);
            sta.setString(2, nuevaContra);
            res =sta.executeQuery();
            res.next();
            verifica=res.getInt("id");
            if(verifica != 0){
                System.out.println("actualizado");
            }else{
                 System.out.println("no se actualizo");
            }
            
            
        }catch(Exception e){
            verifica = 0;
            System.out.println(e.toString());
            
        }finally{
            
        }
        return verifica;
    }

    @Override
    public UsuarioN relColaborador(int idColab) {
        UsuarioN user = null;
       ConexionBase con = new ConexionBase();
        Connection cnx = con.coectarbd();
        ResultSet res;
        CifrarSHA cf = new CifrarSHA();
        try{
        sta = cnx.prepareCall(CONSULTACOLUSN);
        sta.setInt(1, idColab);
        res = sta.executeQuery();
        res.next();
        user = new UsuarioN(res.getInt("boleta"), res.getString("nombre"), res.getString("apellidos"), res.getString("escuela"), res.getInt("edad"), res.getString("correo"),cf.descifra(Base64.decodeBase64(res.getString("paswd"))), res.getDate("fRegistro"));
        }catch(Exception e){
            System.out.println(e.toString());
        }finally{
            
        }
       return user;
    }
    
}
