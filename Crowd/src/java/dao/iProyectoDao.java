/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import modelo.Proyecto;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public interface iProyectoDao {
    int agregaProyecto(Proyecto u, int boleta);
    
    int editaProyecto(Proyecto u);
    Proyecto buscaonlyone(String nombre);
    ArrayList<Proyecto> consultaProyectos(String palabra, int boleta);
    ArrayList<Proyecto> consultaMisProyectos(int boleta);
    ArrayList<Proyecto> consultaProyectosApoyados(int boleta);
    public ArrayList<Proyecto> consultaProyectosSinBuscar(int boleta);
    public double cantidadRecaudada(int idProyecto);
    public double cantidadDonada(int idProyecto,int boleta);
    public int eliminaProyecto(int idProyect);
    ArrayList<Proyecto> consultaPopulares(int boleta);
    
}
