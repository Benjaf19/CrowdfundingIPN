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
public class faqs {
    private int idfaq;
    private String pregunta;
    private String respuesta;
    private boolean validar = false;

    public boolean getValidar() {
        return validar;
    }

    public void setValidar(boolean validar) {
        this.validar = validar;
    }

    public int getIdfaq() {
        return idfaq;
    }

    public void setIdfaq(int idfaq) {
        this.idfaq = idfaq;
    }

    public String getPregunta() {
        return pregunta;
    }

    public void setPregunta(String pregunta) {
        this.pregunta = pregunta;
    }

    public String getRespuesta() {
        return respuesta;
    }

    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }

    public faqs(int idfaq, String pregunta, String respuesta) {
        this.idfaq = idfaq;
        this.pregunta = pregunta;
        this.respuesta = respuesta;
        
    }

    @Override
    public String toString() {
        return "faqs{" + "idfaq=" + idfaq + ", pregunta=" + pregunta + ", respuesta=" + respuesta + ", validar=" + validar + '}';
    }

  
    
    
    
}
