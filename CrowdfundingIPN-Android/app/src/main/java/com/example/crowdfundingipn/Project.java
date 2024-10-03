package com.example.crowdfundingipn;

public class Project {

    private String Nombre;
    private String Descripcion;
    private float Financiacion;
    private int Plazo;
    private String Recompensas;
    private String Categoria;
    private int Thumbnail;
    private  int idProyecto;
    private double suma;
    private boolean edit;
    private String imagen;


    public Project(String nombre, String descripcion, float financiacion, int plazo, String recompensas, String categoria, int thumbnail,int idProyecto,double sum,boolean edita,String ima) {
        Nombre = nombre;
        Descripcion = descripcion;
        Financiacion = financiacion;
        Plazo = plazo;
        Recompensas = recompensas;
        Categoria = categoria;
        Thumbnail = thumbnail;
        this.idProyecto = idProyecto;
        this.suma = sum;
        this.edit=edita;
        this.imagen=ima;


    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public boolean getEdit() {
        return edit;
    }

    public void setEdit(boolean edit) {
        this.edit = edit;
    }

    public double getSuma() {
        return suma;
    }

    public void setSuma(double suma) {
        this.suma = suma;
    }

    public int getIdProyecto() {
        return idProyecto;
    }

    public void setIdProyecto(int idProyecto) {
        this.idProyecto = idProyecto;
    }

    public String getNombre() {
        return Nombre;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public float getFinanciacion() {
        return Financiacion;
    }

    public int getPlazo() {
        return Plazo;
    }

    public String getRecompensas() {
        return Recompensas;
    }

    public String getCategoria() {
        return Categoria;
    }

    public int getThumbnail() {
        return Thumbnail;
    }

    public void setNombre(String nombre) {
        Nombre = nombre;
    }

    public void setDescripcion(String descripcion) {
        Descripcion = descripcion;
    }

    public void setFinanciacion(float financiacion) {
        Financiacion = financiacion;
    }

    public void setPlazo(int plazo) {
        Plazo = plazo;
    }

    public void setRecompensas(String recompensas) {
        Recompensas = recompensas;
    }

    public void setCategoria(String categoria) {
        Categoria = categoria;
    }

    public void setThumbnail(int thumbnail) {
        Thumbnail = thumbnail;
    }
}
