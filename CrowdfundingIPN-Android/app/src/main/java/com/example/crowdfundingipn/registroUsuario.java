package com.example.crowdfundingipn;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

public class registroUsuario extends AppCompatActivity implements View.OnClickListener {
Button registrar,iniciaS;
EditText boleta,nombre,apellidos,edad,correo,contraseña,confcontra;
Spinner escuela;
String[] escuelas = {"CECyT 1","CECyT 2","CECyT 3","CECyT 4","CECyT 5","CECyT 6","CECyT 7","CECyT 8","CECyT 9","CECyT 10","CECyT 11","CECyT 12","CECyT 13","CECyT 14","CECyT 15","CECyT 16","CET 1"};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_registro_usuario);
boleta = findViewById(R.id.boletar);
nombre = findViewById(R.id.nombrep);
apellidos = findViewById(R.id.apellidos);
edad = findViewById(R.id.edad);
correo = findViewById(R.id.correo);
contraseña = findViewById(R.id.pass);
confcontra = findViewById(R.id.confpass);
        escuela = (Spinner) findViewById(R.id.escuela);
        escuela.setAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, escuelas));
        iniciaS = findViewById(R.id.iniciaS);

registrar = findViewById(R.id.registrar);
registrar.setOnClickListener(this);
iniciaS.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.registrar){
            conexionWS con = new conexionWS("registroUsuario");
            try {
                String bol = boleta.getText().toString();
                String nom = nombre.getText().toString();
                String ape = apellidos.getText().toString();
                String escu = escuela.getSelectedItem().toString();
                String eda = edad.getText().toString();
                String mail = correo.getText().toString();
                String pswd = contraseña.getText().toString();
                String confpaswd = confcontra.getText().toString();
                if (pswd.equals(confpaswd)){
                    String ver = con.execute(bol, nom, ape, escu, eda, mail, pswd).get();
                int verifica = Integer.parseInt(ver);
                if (verifica != -1) {
                    Toast.makeText(getApplicationContext(), "Registro exitoso", Toast.LENGTH_SHORT).show();
                    Intent a = new Intent(this, MainActivity.class);
                    startActivity(a);
                } else {
                    Toast.makeText(getApplicationContext(), "Ya exixte esa cuenta", Toast.LENGTH_SHORT).show();
                }
            }else{
                    Toast.makeText(getApplicationContext(), "Las contraseñas no coinciden", Toast.LENGTH_SHORT).show();
                }
            }catch(Exception e){
                System.out.println(e.toString());
            }
        }else{
            if(v.getId()==R.id.iniciaS){
                Intent act = new Intent(this, MainActivity.class);
                startActivity(act);
            }
        }
    }
}
