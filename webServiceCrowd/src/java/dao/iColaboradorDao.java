/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import modelo.Colaborador;
import modelo.UsuarioN;

/**
 *
 * @author Ricardo Palomino Bravo
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public interface iColaboradorDao {
    int agregaColaborador(Colaborador u,int boleta);
    
    int editaColaborador(Colaborador u);
    
    ArrayList<String> carreras(String escuela);
    
    ArrayList<Colaborador> consultaColaborador(String palabra,int boleta);
    
    Colaborador consultaColabBoleta(int boleta);
    int realizaSolicitud(int idColaborador,int idProyecto,int boleta);
    
    ArrayList<String> consultaSolicitudRecibida(int idColab);
    int eliminaSolicitud(int idSolicitud);
    String aceptaSolicitud(int idSolicitud);
    
    
}
