/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BD;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 * 
 */
public class ConexionBase {
    private Connection con;
    private Statement sta;
    private String url = "jdbc:mysql://localhost/crowdfunding?useSSL=false";
    private String user = "root";
    private String pswd= "n0m3l0";
    
    public Connection coectarbd(){
        try{
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(url,user,pswd);
        sta = (Statement)con.createStatement();
            System.out.println("Si conecta a la base");
        }catch(Exception e){
            System.out.println("No conecto a la base" + e.toString());
        }
        return con;
    }
}
