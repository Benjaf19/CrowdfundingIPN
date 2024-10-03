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
public class Tarjeta {


    private int idTarjeta;
    private String numTarjeta;
    private int codigoSeg;
    private String fechaVence;
    private String Direccion;
    private String tipoTag;

    public Tarjeta(int idTarjeta, String numTarjeta, int codigoSeg, String fechaVence, String Direccion, String tipoTag) {
        this.idTarjeta = idTarjeta;
        this.numTarjeta = numTarjeta;
        this.codigoSeg = codigoSeg;
        this.fechaVence = fechaVence;
        this.Direccion = Direccion;
        this.tipoTag = tipoTag;
    }

    public int getIdTarjeta() {
        return idTarjeta;
    }

    public void setIdTarjeta(int idTarjeta) {
        this.idTarjeta = idTarjeta;
    }

    public String getNumTarjeta() {
        return numTarjeta;
    }

    public void setNumTarjeta(String numTarjeta) {
        this.numTarjeta = numTarjeta;
    }

    public int getCodigoSeg() {
        return codigoSeg;
    }

    public void setCodigoSeg(int codigoSeg) {
        this.codigoSeg = codigoSeg;
    }

    public String getFechaVence() {
        return fechaVence;
    }

    public void setFechaVence(String fechaVence) {
        this.fechaVence = fechaVence;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public String getTipoTag() {
        return tipoTag;
    }

    public void setTipoTag(String tipoTag) {
        this.tipoTag = tipoTag;
    }

    @Override
    public String toString() {
        return "Tarjeta{" + "idTarjeta=" + idTarjeta + ", numTarjeta=" + numTarjeta + ", codigoSeg=" + codigoSeg + ", fechaVence=" + fechaVence + ", Direccion=" + Direccion + ", tipoTag=" + tipoTag + '}';
    }
    
    
}
