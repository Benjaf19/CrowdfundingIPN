/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import modelo.Paypal;
/**
 *
 * @author Ricardo Palomino Bravo
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public interface iPaypalDao {
    int agregaPaypal(Paypal p,int boleta);
    
    int editaPaypal(Paypal p);
    
    int verificaContra(String pswd, String correo);
    
    ArrayList<Paypal> consultaPaypal(int palabra);
     public ArrayList<Paypal> consultaPaypalSinBuscar();
}
