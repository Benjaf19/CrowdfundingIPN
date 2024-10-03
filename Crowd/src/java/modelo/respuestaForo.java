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
public class respuestaForo {
    private int idRespuesta;
    private int idForo;
    private String respuesta;
    private String usuario;

    public respuestaForo(int idRespuesta, int idForo, String respuesta, String usuario) {
        this.idRespuesta = idRespuesta;
        this.idForo = idForo;
        this.respuesta = respuesta;
        this.usuario = usuario;
    }

    public int getIdRespuesta() {
        return idRespuesta;
    }

    public void setIdRespuesta(int idRespuesta) {
        this.idRespuesta = idRespuesta;
    }

    public int getIdForo() {
        return idForo;
    }

    public void setIdForo(int idForo) {
        this.idForo = idForo;
    }

    public String getRespuesta() {
        return respuesta;
    }

    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    @Override
    public String toString() {
        return "respuestaForo{" + "idRespuesta=" + idRespuesta + ", idForo=" + idForo + ", respuesta=" + respuesta + ", usuario=" + usuario + '}';
    }
    
    
    
}
