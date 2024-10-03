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
public class Paypal {
    /* idPaypal INT PRIMARY KEY NOT NULL,
  CorreoPP NVARCHAR(200) NOT NULL,
  contraseña NVARCHAR(120) NOT NULL*/
    private int idPaypal;
    private String correoPP;
    private String contraseña;

    public Paypal(int idPaypal, String correoPP, String contraseña) {
        this.idPaypal = idPaypal;
        this.correoPP = correoPP;
        this.contraseña = contraseña;
    }

    public int getIdPaypal() {
        return idPaypal;
    }

    public void setIdPaypal(int idPaypal) {
        this.idPaypal = idPaypal;
    }

    public String getCorreoPP() {
        return correoPP;
    }

    public void setCorreoPP(String correoPP) {
        this.correoPP = correoPP;
    }

    public String getContraseña() {
        return contraseña;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    @Override
    public String toString() {
        return "Paypal{" + "idPaypal=" + idPaypal + ", correoPP=" + correoPP + ", contrase\u00f1a=" + contraseña + '}';
    }
    
    
}
