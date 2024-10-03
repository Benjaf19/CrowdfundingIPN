/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import modelo.Tarjeta;
/**
 *
 * @author Ricardo Palomino Bravo
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public interface iTarjetaDao {
    int agregaTarjeta(Tarjeta t,int boleta);
    
    int editaTarjeta(Tarjeta t);
    
    ArrayList<Tarjeta> consultaTarjeta(int palabra);
    public ArrayList<Tarjeta> consultaTarjetaSinBuscar();
}
