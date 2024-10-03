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
public class Persona {

    private int _numero;
    private String _correo;
    private boolean _valido = false;
    private String _nombre;
    private String _msj;
    private String _cuando;

    public Persona() {

    }
    
    public void darValores(String usuario){
        if(usuario.equals("")){
            _msj="deben estar llenos los campos";
            return;
        }
        _numero=1;
        _correo="nadia@hotmail.com"; 
        _nombre="nadia";
        _cuando="";
       
    }
    
    

    public int NUMERO() {
        return _numero;
    }

    public String CORREO() {
        return _correo;
    }

    public String NOMBRE() {
        return _nombre;
    }

    public String DIRECCION() {
        return null;
    //return _direccion;
    }

    public String PRIMARIA() {
        return null;
    }

    public String SECU() {
        return null;
    }

    public String PREPA() {
        return null;
    }

    public boolean VALIDO() {
        return _valido;
    }

    public void validaDatoscontacto(String numero, String correo) {
        if (numero.equals("") || correo.equals("")) {
            _msj = "deben estar llenos los campos";
            return;
        }
        try {
            _numero = Integer.parseInt(numero);
        } catch (Exception exc) {
            _msj = "no es valido";
            return;
        }

        _correo = correo;
        ///reemplazar por bd;

        try {
            String[] correito = correo.split("@");
            if (correito.length > 1) {
                if (correito[1].contains(".")) {
                    _valido = true;
                    _msj = "ya estas";
                }
            }
        } catch (Exception exc) {
            _msj = "no es valido";
        }

    }

    public void validarDatosPer(String nombre, String direccion) {
        if (nombre.equals("") || direccion.equals("")) {
            _msj = "deben estar llenos los campos";
            return;
        }

        if (nombre.matches("[a-zA-Z]+")) {
            _msj = "esta bien el nombre";
        } else {
            _msj = "debe ser un nomnre valido";
        }
    }

}