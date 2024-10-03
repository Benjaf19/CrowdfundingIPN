/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import modelo.faqs;

/**
 *
 * @author Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public interface ifaqDao {
    int agregaFAQ(faqs f);
    int editafaq(faqs p);
    ArrayList<faqs> consultaAdmin();
    ArrayList<faqs> consultaUser();
    
}
