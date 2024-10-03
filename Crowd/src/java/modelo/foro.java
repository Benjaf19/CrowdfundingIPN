/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.InputStream;
import java.util.Date;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class foro {
    private int idForo;
   private String pregunta;
   private String creador;
   private Date fecha;
   private String asunto;
    private String categoria;
   private InputStream foto;

    public foro(int idForo, String pregunta, String creador, Date fecha, String asunto, String categoria, InputStream foto) {
        this.idForo = idForo;
        this.pregunta = pregunta;
        this.creador = creador;
        this.fecha = fecha;
        this.asunto = asunto;
        this.categoria = categoria;
        this.foto = foto;
    }

    public int getIdForo() {
        return idForo;
    }

    public void setIdForo(int idForo) {
        this.idForo = idForo;
    }

    public String getPregunta() {
        return pregunta;
    }

    public void setPregunta(String pregunta) {
        this.pregunta = pregunta;
    }

    public String getCreador() {
        return creador;
    }

    public void setCreador(String creador) {
        this.creador = creador;
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

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public InputStream getFoto() {
        return foto;
    }

    public void setFoto(InputStream foto) {
        this.foto = foto;
    }

    @Override
    public String toString() {
        return "foro{" + "idForo=" + idForo + ", pregunta=" + pregunta + ", creador=" + creador + ", fecha=" + fecha + ", asunto=" + asunto + ", categoria=" + categoria + ", foto=" + foto + '}';
    }
    
    
    
    
    
}
