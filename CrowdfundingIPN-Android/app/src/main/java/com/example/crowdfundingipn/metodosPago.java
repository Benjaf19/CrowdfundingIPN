package com.example.crowdfundingipn;

public class metodosPago {
    private int logo;
    private String texto;

    public metodosPago(int logo, String texto) {
        this.logo = logo;
        this.texto = texto;
    }

    public int getLogo() {
        return logo;
    }

    public void setLogo(int logo) {
        this.logo = logo;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }
}
