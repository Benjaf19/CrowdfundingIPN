package com.example.crowdfundingipn;

import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import java.util.Date;

import modelo.UsuarioN;

public class informacionUsuario extends AppCompatActivity implements View.OnClickListener {
    Date fecha = new Date();
    Button edita,guarda,cancelar;
    EditText boleta,nombre,apellidos,edad,correo,contraseña,confcontra;
    Spinner escuela;
    String[] escuelas = {"CECyT 1","CECyT 2","CECyT 3","CECyT 4","CECyT 5","CECyT 6","CECyT 7","CECyT 8","CECyT 9","CECyT 10","CECyT 11","CECyT 12","CECyT 13","CECyT 14","CECyT 15","CECyT 16","CET 1"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_informacion_usuario);
        boleta = findViewById(R.id.boletaed);
        nombre = findViewById(R.id.nombreed);
        apellidos = findViewById(R.id.apellidosed);
        edad = findViewById(R.id.edaded);
        correo = findViewById(R.id.correoed);
        contraseña = findViewById(R.id.passed);
        confcontra = findViewById(R.id.confpassed);
       // edita = findViewById(R.id.edita_user);
        guarda = findViewById(R.id.guarda_cambios);
        cancelar=findViewById(R.id.cancela_cambios);

        escuela = (Spinner) findViewById(R.id.escuelaed);
        escuela.setAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, escuelas));

        boleta.setEnabled(false);
        nombre.setEnabled(true);
        apellidos.setEnabled(true);
        edad.setEnabled(true);
        correo.setEnabled(false);
        contraseña.setEnabled(true);
        confcontra.setEnabled(true);
        escuela.setEnabled(true);
        cancelar.setEnabled(true);
        guarda.setEnabled(true);



        guarda.setOnClickListener(this);
       // edita.setOnClickListener(this);
        cancelar.setOnClickListener(this);

        SharedPreferences sesion = PreferenceManager.getDefaultSharedPreferences(this);
        int valor = sesion.getInt("Usuario",0);
        conexionWS con = new conexionWS("consultaUsuario");
        try {
            String ver = con.execute(Integer.toString(valor)).get();
            String[] us=ver.split(",");
            UsuarioN u = new UsuarioN(Integer.parseInt(us[0]),us[1],us[2],us[3],Integer.parseInt(us[4]),us[5],us[6],fecha);
            boleta.setText(Integer.toString(u.getBoleta()));
            nombre.setText(u.getNombre());
            apellidos.setText(u.getApellidos());
            edad.setText(Integer.toString(u.getEdad()));
            correo.setText(u.getCorreo());
            contraseña.setText(u.getContraseña());
            confcontra.setText(u.getContraseña());

            for(int i = 0;i<escuelas.length;i++){
                if(u.getEscuela().equals(escuelas[i])){
                    escuela.setSelection(i);
                }
            }
        }catch (Exception e){

        }


    }

    @Override
    public void onClick(View v) {

            if(v.getId()==R.id.guarda_cambios){


                conexionWS cnx = new conexionWS("editaUsuario");
                String bol = boleta.getText().toString();
                String nom = nombre.getText().toString();
                String ape = apellidos.getText().toString();
                String escu = escuela.getSelectedItem().toString();
                String eda = edad.getText().toString();
                String mail = correo.getText().toString();
                String pswd = contraseña.getText().toString();
                String confpaswd = confcontra.getText().toString();
                try {
                    if(pswd.equals(confpaswd)) {
                        String ver = cnx.execute(bol, nom, ape, escu, eda, mail, pswd).get();
                        int veri = Integer.parseInt(ver);
                        /*boleta.setEnabled(false);
                        nombre.setEnabled(false);
                        apellidos.setEnabled(false);
                        edad.setEnabled(false);
                        correo.setEnabled(false);
                        contraseña.setEnabled(false);
                        confcontra.setEnabled(false);
                        escuela.setEnabled(false);
                        cancelar.setEnabled(false);
                        guarda.setEnabled(false);
                        edita.setEnabled(true);

                        cancelar.setBackgroundColor(Color.GRAY);
                        guarda.setBackgroundColor(Color.GRAY);
                        edita.setBackgroundColor(Color.rgb(128,0,64));*/
                        if(veri!=-1){
                            Toast.makeText(getApplicationContext(),"Datos actualizados con exito",Toast.LENGTH_SHORT).show();
                        }else{
                            Toast.makeText(getApplicationContext(),"Ha ocurrido un error",Toast.LENGTH_SHORT).show();
                        }
                        Intent ac = new Intent(this,homepage.class);
                        startActivity(ac);
                    }else{
                        Toast.makeText(getApplicationContext(),"Las contraseñas no coinciden",Toast.LENGTH_SHORT).show();
                    }
                }catch (Exception e){
                    System.out.println(e.toString());
                }
            }else{
                if(v.getId()==R.id.cancela_cambios){
                    Intent ac = new Intent(this,homepage.class);
                    startActivity(ac);



                }else{

                }
            }

    }
}
