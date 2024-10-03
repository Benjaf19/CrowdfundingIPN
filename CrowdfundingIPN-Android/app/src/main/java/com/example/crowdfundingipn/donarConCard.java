package com.example.crowdfundingipn;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONObject;

public class donarConCard extends AppCompatActivity implements View.OnClickListener  {
int idProyecto = 0;
double monto = 0;
Project pro;
Button donard,cancela;
    SharedPreferences sesion;
    int valor= 0 ;
    String[] tarjetass;
Spinner tags;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_validate_card);

        donard = findViewById(R.id.donardos);
        tags = (Spinner)findViewById(R.id.tarjetas);
        cancela = findViewById(R.id.cancela_donar);


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

        monto = Double.parseDouble(intent.getExtras().getString("monto"));
        pro = new Project(name,Description,Financing,Time,Rewards,Category,0,idProyecto,suma,edita,"");

        JSONArray jsonArray = null;
        sesion = PreferenceManager.getDefaultSharedPreferences(this);
        valor= sesion.getInt("Usuario",0);
        conexionWS con = new conexionWS("consultaTarjetas");
        try{
           String ver =  con.execute(Integer.toString(valor)).get();
            jsonArray = new JSONArray(ver);
            int contar = jsonArray.length();
            tarjetass=new String[contar];
            if(contar!=0){
                for(int i = 0;i<contar;i++){

                    JSONObject ob = jsonArray.getJSONObject(i);
                    tarjetass[i]="**** **** **** "+ob.getString("numeroTAG").substring(12);

                }
                tags.setAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, tarjetass));
            }else{
                Toast.makeText(this,"No tienes tarjetas registradas, porfavor registra alguna",Toast.LENGTH_LONG).show();
                Intent act = new Intent(this,homepage.class);
                startActivity(act);
            }
        }catch (Exception e){
            System.out.println(e.toString());
        }

        donard.setOnClickListener(this);
        cancela.setOnClickListener(this);

    }
    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.donardos){
            conexionWS con2 = new conexionWS("realizaDonacion");
            try{
                String veri = con2.execute(Integer.toString(idProyecto),Integer.toString(valor),Double.toString(monto)).get();
                int ba = Integer.parseInt(veri);
                if(ba >0 ){
                    Toast.makeText(this,"Donación realizada con exito, ¡Gracias por apoyar el proyecto!",Toast.LENGTH_LONG).show();
                    Intent ac = new Intent(this,Project_Activity.class);
                    ac.putExtra("idProyecto",idProyecto);

                    ac.putExtra("Nombre",pro.getNombre());
                    ac.putExtra("Descripcion",pro.getDescripcion());
                    ac.putExtra("Categoria",pro.getCategoria());
                    ac.putExtra("Financiamiento",pro.getFinanciacion());
                    ac.putExtra("Plazo",pro.getPlazo());
                    ac.putExtra("Recompensas",pro.getRecompensas());
                    ac.putExtra("suma",pro.getSuma()+monto);
                    ac.putExtra("edita",pro.getEdit());
                    startActivity(ac);
                }else{
                    Toast.makeText(this,"Ha ocurrido un error",Toast.LENGTH_SHORT).show();
                }
            }catch (Exception e){
                System.out.println(e.toString());
            }
        }else{
            if(v.getId()==R.id.cancela_donar){
                Intent ac = new Intent(this,donar.class);
                ac.putExtra("idProyecto",idProyecto);
                ac.putExtra("monto",monto);
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
