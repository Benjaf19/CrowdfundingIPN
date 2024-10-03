/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.util.ArrayList;
import modelo.ticketsSoporte;

/**
 *
 * @author  Benjamin Jesus Campos Flores
 * Derechos reservados por Novasoft S.A. de C.V.
 */
public interface iTicketsDao {
    int realizaTicket(ticketsSoporte t);
    int cambiaEstado(ticketsSoporte t);
    ticketsSoporte consultaTicket(int folio);
    ArrayList<String> consultaUsuario(int user,String folio);
    ArrayList<ticketsSoporte> consultaTodos(String folio);
}
