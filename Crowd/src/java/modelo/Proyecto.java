/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.InputStream;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class Proyecto {
    
    private int idProyecto ;
    private String nombre ;
    private String descripcion ;
    private InputStream imagen;
    private float financiacion ;
    private int plazotiempo ;
    private String recompensas ;
    private String categoria ;

    public Proyecto(int idProyecto, String nombre, String descripcion,InputStream imagen, float financiacion, int plazotiempo, String recompensas, String categoria) {
        this.idProyecto = idProyecto;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.financiacion = financiacion;
        this.plazotiempo = plazotiempo;
        this.recompensas = recompensas;
        this.categoria = categoria;
    }

    public int getIdProyecto() {
        return idProyecto;
    }

    public void setIdProyecto(int idProyecto) {
        this.idProyecto = idProyecto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public InputStream getImagen() {
        return imagen;
    }

    public void setImagen(InputStream imagen) {
        this.imagen = imagen;
    }

    public float getFinanciacion() {
        return financiacion;
    }

    public void setFinanciacion(float financiacion) {
        this.financiacion = financiacion;
    }

    public int getPlazotiempo() {
        return plazotiempo;
    }

    public void setPlazotiempo(int plazotiempo) {
        this.plazotiempo = plazotiempo;
    }

    public String getRecompensas() {
        return recompensas;
    }

    public void setRecompensas(String recompensas) {
        this.recompensas = recompensas;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    @Override
    public String toString() {
        return "Proyecto{" + "idProyecto=" + idProyecto + ", nombre=" + nombre + ", descripcion=" + descripcion + ", imagen=" + imagen + ", financiacion=" + financiacion + ", plazotiempo=" + plazotiempo + ", recompensas=" + recompensas + ", categoria=" + categoria + '}';
    }
    
    
    
    
}
