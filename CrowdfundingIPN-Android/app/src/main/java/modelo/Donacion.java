/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class Donacion {
   
    private int idDonacion;
     private int idProyecto;
      private int boleta;
       private double dineroDonado;

    public Donacion(int idDonacion, int idProyecto, int boleta, double dineroDonado) {
        this.idDonacion = idDonacion;
        this.idProyecto = idProyecto;
        this.boleta = boleta;
        this.dineroDonado = dineroDonado;
    }

    public int getIdDonacion() {
        return idDonacion;
    }

    public void setIdDonacion(int idDonacion) {
        this.idDonacion = idDonacion;
    }

    public int getIdProyecto() {
        return idProyecto;
    }

    public void setIdProyecto(int idProyecto) {
        this.idProyecto = idProyecto;
    }

    public int getBoleta() {
        return boleta;
    }

    public void setBoleta(int boleta) {
        this.boleta = boleta;
    }

    public double getDineroDonado() {
        return dineroDonado;
    }

    public void setDineroDonado(double dineroDonado) {
        this.dineroDonado = dineroDonado;
    }

    @Override
    public String toString() {
        return "Donacion{" + "idDonacion=" + idDonacion + ", idProyecto=" + idProyecto + ", boleta=" + boleta + ", dineroDonado=" + dineroDonado + '}';
    }
       
       
    
}
