/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.util.Date;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class UsuarioN {
    private int boleta;
    private String nombre;
    private String apellidos;
    private String escuela;
    private int edad;
    private String correo;
    private String contraseña;
    private Date fechaRegistro;

    public UsuarioN(int boleta, String nombre, String apellidos, String escuela, int edad, String correo, String contraseña, Date fechaRegistro) {
        this.boleta = boleta;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.escuela = escuela;
        this.edad = edad;
        this.correo = correo;
        this.contraseña = contraseña;
        this.fechaRegistro = fechaRegistro;
    }

    public int getBoleta() {
        return boleta;
    }

    public void setBoleta(int boleta) {
        this.boleta = boleta;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getEscuela() {
        return escuela;
    }

    public void setEscuela(String escuela) {
        this.escuela = escuela;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContraseña() {
        return contraseña;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    @Override
    public String toString() {
        return "UsuarioN{" + "boleta=" + boleta + ", nombre=" + nombre + ", apellidos=" + apellidos + ", escuela=" + escuela + ", edad=" + edad + ", correo=" + correo + ", contrase\u00f1a=" + contraseña + ", fechaRegistro=" + fechaRegistro + '}';
    }
    
    
    

   
    

    

    
    
    

    
    
}
