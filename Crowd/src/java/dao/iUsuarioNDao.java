/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;


import java.util.List;
import modelo.UsuarioN;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public interface iUsuarioNDao {
    
    int agregaUsuario(UsuarioN u);
    
    void eliminaUsuario(int boleta);
    
    int editaUsuario(UsuarioN u);
    
    List<UsuarioN> consultaUsuarios(String nombre);
    
    UsuarioN consultaUsuario(int boleta);
    
    int recuperaContra(String correo, String nuevaContra);
    
    UsuarioN relColaborador(int idColab);
    
    
}
