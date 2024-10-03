/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package seguridad;

/**
 *
 * @author Alumno SS
 */
public class Acceso {
    private int _idPer = 0;
    private boolean _valido = false;
    
    public Acceso(int idPer){
        _idPer = idPer;
        
        
        
        //////cambiar pro la base de datos
        if(_idPer>0){
            _valido = true;
        }
    }
    
    
    public boolean VALIDO(){
        return _valido;
    }
    
}
