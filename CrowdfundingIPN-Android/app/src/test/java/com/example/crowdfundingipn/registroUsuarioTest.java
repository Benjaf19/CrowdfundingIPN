package com.example.crowdfundingipn;

import org.junit.Test;

import static org.junit.Assert.*;

public class registroUsuarioTest {
    @Test
    public void pruebaAltaUsr(){


        String bol = "2017091122";
        String nom = "Prueba";
        String ape = "Pruebaa";
        String escu = "CECyT 9";
        String eda = "18";
        String mail = "prueba@correo.prueba.com";
        String pswd = "12345";
        int verifica = 0;
        int expResult = 2017091122;
        String ver = "";
        try {
            conexionWS con = new conexionWS("registroUsuario");

            ver = con.execute(bol, nom, ape, escu, eda, mail, pswd).get();
            verifica= Integer.parseInt(ver);
            System.out.println(ver);
        }catch (Exception e){
            System.out.println("El error es: "+e.toString());
        }
        System.out.println(verifica);
        assertEquals("Resultado fue: ",expResult,verifica);

    }
}