/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ldn;

/**
 *
 * @author Alumno SS
 */
public class Usuario {
    private String _usr;
    private String _contra;
    private boolean _valido = false;
    private String _msj;
    private int _idPer = 0;
    private String _nombreCompleto;
    
    public Usuario(){
        
    }
    public Usuario(int idPer){
        _idPer = idPer;
        
        //////reemplazo por bd
        
        if(_idPer == 1){
            
            _valido = true;
            _msj = "usr valido";
            _idPer = 1;
            _nombreCompleto = "@Nadia Salinas";
            
        }
        
    }
    
    public boolean VALIDO(){
        return _valido;
    }
    
    public void validaPersona(String usr, String pswd){
        _usr = usr;
        _contra = pswd;
        
        ///reemplazar por bd;       
        
        if(_usr.equals("nadia") && _contra.equals("@nadia")){
            _valido = true;
            _msj = "usr valido";
            _idPer = 1;
            _nombreCompleto = "@Nadia Salinas";
        }
        else{
            _msj = "usr y/o contra mal";
        }
        
        
    }
    
    public String MSJ(){
        return _msj;
    }
    public String NOMBRECOMPLETO(){
        return _nombreCompleto;
    }
    
    public int IDPER(){
        return _idPer;
    }
    
}