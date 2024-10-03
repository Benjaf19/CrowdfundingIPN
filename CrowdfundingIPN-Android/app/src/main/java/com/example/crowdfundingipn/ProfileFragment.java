package com.example.crowdfundingipn;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.TextView;

import java.util.Date;

import modelo.UsuarioN;

public class ProfileFragment extends Fragment  implements View.OnClickListener {
    private ImageButton btnmodifica;
    Intent activi = null;
    Context contexto;
    Button edita;
    Date fecha = new Date();
    TextView nombre,ape,edad,boleta,correo,contra,escu;
    int valor = 0;

    public ProfileFragment(){

    }
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View vista =inflater.inflate(R.layout.fragment_profile, container, false);

        SharedPreferences sesion = PreferenceManager.getDefaultSharedPreferences(contexto);
        valor= sesion.getInt("Usuario",0);

        edita = vista.findViewById(R.id.edita_datos);
        nombre = vista.findViewById(R.id.nombrep);
        ape = vista.findViewById(R.id.apellidop);
        edad = vista.findViewById(R.id.edadp);
        boleta = vista.findViewById(R.id.boletap);
        correo = vista.findViewById(R.id.correop);
        contra = vista.findViewById(R.id.contrap);
        escu = vista.findViewById(R.id.escuelap);

        conexionWS con = new conexionWS("consultaUsuario");
        try {
            String ver = con.execute(Integer.toString(valor)).get();
            String[] us = ver.split(",");
            UsuarioN u = new UsuarioN(Integer.parseInt(us[0]), us[1], us[2], us[3], Integer.parseInt(us[4]), us[5], us[6], fecha);
            nombre.setText(u.getNombre());
            ape.setText(u.getApellidos());
            edad.setText(Integer.toString(u.getEdad()));
            boleta.setText(Integer.toString(u.getBoleta()));
            correo.setText(u.getCorreo());
            contra.setText(u.getContraseña());
            escu.setText(u.getEscuela());
        }catch (Exception e){
            System.out.println(e.toString());
        }


        edita.setOnClickListener(this);

        return vista;

    }
    @Override
    public void onAttach (Activity activity) {
        super.onAttach(activity);

        contexto = getActivity();

        activi = new Intent(contexto,informacionUsuario.class);
        System.out.println("Si jala el attach");
    }

    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.edita_datos){
            startActivity(activi);
        }
    }
}
