/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import modelo.foro;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public interface iForoDao {
    int agregaForo(foro f);
    ArrayList<foro> consultaForo(String busqueda);
    foro consultaDeUno(int idForo);
    
}
