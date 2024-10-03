/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Blob;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public class Colaborador {
/* idColaborador INT PRIMARY KEY NOT NULL,
  Carrera NVARCHAR(100) NOT NULL,
  infoExtra NVARCHAR(600) )*/

    private int idColaborador ;
    private String carrera;
    private String infoExtra;
    private InputStream foto;

    public Colaborador(int idColaborador, String carrera, String infoExtra, InputStream foto) {
        this.idColaborador = idColaborador;
        this.carrera = carrera;
        this.infoExtra = infoExtra;
        this.foto = foto;
    }

    public int getIdColaborador() {
        return idColaborador;
    }

    public void setIdColaborador(int idColaborador) {
        this.idColaborador = idColaborador;
    }

    public String getCarrera() {
        return carrera;
    }

    public void setCarrera(String carrera) {
        this.carrera = carrera;
    }

    public String getInfoExtra() {
        return infoExtra;
    }

    public void setInfoExtra(String infoExtra) {
        this.infoExtra = infoExtra;
    }

    public InputStream getFoto() {
        return foto;
    }

    public void setFoto(InputStream foto) {
        this.foto = foto;
    }

    @Override
    public String toString() {
        return "Colaborador{" + "idColaborador=" + idColaborador + ", carrera=" + carrera + ", infoExtra=" + infoExtra + ", foto=" + foto + '}';
    }

    

    
    
    
}
