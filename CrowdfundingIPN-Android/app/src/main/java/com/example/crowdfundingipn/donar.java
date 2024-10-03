package com.example.crowdfundingipn;

import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.webkit.WebView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;

public class donar extends AppCompatActivity implements View.OnClickListener {
Button dona,cancela;

Project pro;
EditText monto;
Spinner metodo;
    int idProyecto = 0;
String [] metodos ={"PayPal","Tarjeta de Credito/Debito"};
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_donate);

        dona = findViewById(R.id.donar_uno);
        monto = findViewById(R.id.monto_donar);
        metodo = (Spinner)findViewById(R.id.metodo);
        metodo.setAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, metodos));
        cancela = findViewById(R.id.cancela_donacion);

        dona.setOnClickListener(this);
        cancela.setOnClickListener(this);
        Intent intent=getIntent();
        String name= intent.getExtras().getString("Nombre");
        String Description=intent.getExtras().getString("Descripcion");
        String Category = intent.getExtras().getString("Categoria");
        String Rewards =intent.getExtras().getString("Recompensas");
        float Financing = intent.getExtras().getFloat("Financiamiento");
        int Time = intent.getExtras().getInt("Plazo");
        idProyecto = intent.getExtras().getInt("idProyecto");
        double suma = intent.getExtras().getDouble("suma");
        boolean edita = intent.getExtras().getBoolean("edita");
        pro = new Project(name,Description,Financing,Time,Rewards,Category,0,idProyecto,suma,edita,"");

    }


    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.donar_uno){
            if(metodo.getSelectedItem().toString().equals("PayPal")){
                Intent ac = new Intent(this,donarConPaypal.class);
                ac.putExtra("idProyecto",idProyecto);
                ac.putExtra("monto",monto.getText().toString());
                ac.putExtra("Nombre",pro.getNombre());
                ac.putExtra("Descripcion",pro.getDescripcion());
                ac.putExtra("Categoria",pro.getCategoria());
                ac.putExtra("Financiamiento",pro.getFinanciacion());
                ac.putExtra("Plazo",pro.getPlazo());
                ac.putExtra("Recompensas",pro.getRecompensas());
                ac.putExtra("suma",pro.getSuma());
                ac.putExtra("edita",pro.getEdit());
                startActivity(ac);

            }else{
                Intent ac = new Intent(this,donarConCard.class);
                ac.putExtra("idProyecto",idProyecto);
                ac.putExtra("monto",monto.getText().toString());
                ac.putExtra("Nombre",pro.getNombre());
                ac.putExtra("Descripcion",pro.getDescripcion());
                ac.putExtra("Categoria",pro.getCategoria());
                ac.putExtra("Financiamiento",pro.getFinanciacion());
                ac.putExtra("Plazo",pro.getPlazo());
                ac.putExtra("Recompensas",pro.getRecompensas());
                ac.putExtra("suma",pro.getSuma());
                ac.putExtra("edita",pro.getEdit());
                startActivity(ac);
            }
        }else{
            if(v.getId()==R.id.cancela_donacion){
                Intent ac = new Intent(this,Project_Activity.class);
                ac.putExtra("idProyecto",idProyecto);

                ac.putExtra("Nombre",pro.getNombre());
                ac.putExtra("Descripcion",pro.getDescripcion());
                ac.putExtra("Categoria",pro.getCategoria());
                ac.putExtra("Financiamiento",pro.getFinanciacion());
                ac.putExtra("Plazo",pro.getPlazo());
                ac.putExtra("Recompensas",pro.getRecompensas());
                ac.putExtra("suma",pro.getSuma());
                ac.putExtra("edita",pro.getEdit());
                startActivity(ac);
            }
        }
    }
}
