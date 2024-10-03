package com.example.crowdfundingipn;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

public class addCard  extends AppCompatActivity implements View.OnClickListener  {
EditText numtag,dir,fecha,numseg;
Button b;
Spinner tipo;
String []tipos ={"Visa","American Express","Discover","Mastercard"};
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_addcard);

        numtag = findViewById(R.id.addNumtag);
        dir = findViewById(R.id.adddir);
        fecha = findViewById(R.id.addfecha);
        numseg = findViewById(R.id.addcodeseg);
        b = findViewById(R.id.addTarjeta);
        tipo = (Spinner) findViewById(R.id.addtipo);
        tipo.setAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, tipos));

        b.setOnClickListener(this);
    }
    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.addTarjeta){
            SharedPreferences sesion = PreferenceManager.getDefaultSharedPreferences(this);
            int valor= sesion.getInt("Usuario",0);
            String boleta = Integer.toString(valor);
            String num = numtag.getText().toString();
            String direc = dir.getText().toString();
            String date = fecha.getText().toString();
            String code = numseg.getText().toString();
            String type = tipo.getSelectedItem().toString();
            conexionWS con = new conexionWS("registraTarjeta");

            try{
                String ver = con.execute(num,code,date,direc,type,boleta).get();
                int veri = Integer.parseInt(ver);
                if(veri != -1){
                    Toast.makeText(this,"Tarjeta registrada con exito",Toast.LENGTH_SHORT).show();
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
