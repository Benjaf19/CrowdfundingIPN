package com.example.crowdfundingipn;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class addPaypal  extends AppCompatActivity implements View.OnClickListener  {
EditText correo,contra;
Button b;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_addpaypal);

        correo = findViewById(R.id.addcorreoPP);
        contra = findViewById(R.id.addContraPP);
        b= findViewById(R.id.addPP);

        b.setOnClickListener(this);


    }
    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.addPP){
            SharedPreferences sesion = PreferenceManager.getDefaultSharedPreferences(this);
            int valor= sesion.getInt("Usuario",0);
            String boleta = Integer.toString(valor);
            String mail = correo.getText().toString();
            String pass = contra.getText().toString();
            conexionWS con = new conexionWS("registraPaypal");
            try{
                String ver = con.execute(mail,pass,boleta).get();
                int veri = Integer.parseInt(ver);
                if(veri != -1){
                    Toast.makeText(this,"Paypal registrado con exito",Toast.LENGTH_SHORT).show();
                    Intent ac = new Intent(this,homepage.class);
                    startActivity(ac);
                }else{
                    Toast.makeText(this,"Ha ocurrido un error",Toast.LENGTH_SHORT).show();
                }
            }catch (Exception e){
                System.out.println(e.toString());
            }
        }

    }
}
