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
public class ticketsSoporte {
    private int folio;
    private int remitente;
    private String receptor;
    private String problema;
    private String estado = "Pendiente";
    private Date fecha;
    private String asunto;
    private String tipoProblema;
    private String avance = "Pendiente";

    public ticketsSoporte(int folio, int remitente, String receptor, String problema, Date fecha, String asunto, String tipoProblema) {
        this.folio = folio;
        this.remitente = remitente;
        this.receptor = receptor;
        this.problema = problema;
        this.fecha = fecha;
        this.asunto = asunto;
        this.tipoProblema = tipoProblema;
    }

    public String getAvance() {
        return avance;
    }

    public void setAvance(String avance) {
        this.avance = avance;
    }

    public int getFolio() {
        return folio;
    }

    public void setFolio(int folio) {
        this.folio = folio;
    }

    public int getRemitente() {
        return remitente;
    }

    public void setRemitente(int remitente) {
        this.remitente = remitente;
    }

    public String getReceptor() {
        return receptor;
    }

    public void setReceptor(String receptor) {
        this.receptor = receptor;
    }

    public String getProblema() {
        return problema;
    }

    public void setProblema(String problema) {
        this.problema = problema;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getAsunto() {
        return asunto;
    }

    public void setAsunto(String asunto) {
        this.asunto = asunto;
    }

    public String getTipoProblema() {
        return tipoProblema;
    }

    public void setTipoProblema(String tipoProblema) {
        this.tipoProblema = tipoProblema;
    }

    @Override
    public String toString() {
        return "ticketsSoporte{" + "folio=" + folio + ", remitente=" + remitente + ", receptor=" + receptor + ", problema=" + problema + ", estado=" + estado + ", fecha=" + fecha + ", asunto=" + asunto + ", tipoProblema=" + tipoProblema + ", avance=" + avance + '}';
    }

    
    
    
    
}
