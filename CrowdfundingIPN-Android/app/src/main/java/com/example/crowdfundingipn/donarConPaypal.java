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

import org.json.JSONArray;
import org.json.JSONObject;

public class donarConPaypal extends AppCompatActivity implements View.OnClickListener  {
int idProyecto = 0;
Project pro;
double monto = 0;

    Button donard,cancela;
    SharedPreferences sesion;
    int valor= 0 ;
    String[] paypals;
    String[] contras;
    Spinner pays;
    EditText contra;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_validate_paypal);

        donard = findViewById(R.id.donar_dos);
        pays = (Spinner)findViewById(R.id.paypals);
        contra = findViewById(R.id.contra_pay);
        cancela = findViewById(R.id.cancela_donar_dos);

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
        conexionWS con = new conexionWS("consultaPayPal");
        try{
            String ver =  con.execute(Integer.toString(valor)).get();
            jsonArray = new JSONArray(ver);
            int contar = jsonArray.length();
            paypals=new String[contar];
            contras = new String[contar];
            if(contar!=0){
                for(int i = 0;i<contar;i++){

                    JSONObject ob = jsonArray.getJSONObject(i);
                    paypals[i]=ob.getString("correoPP");
                    contras[i]=ob.getString("contraPP");

                }
                pays.setAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, paypals));
            }else{
                Toast.makeText(this,"No tienes cuentas PayPal registradas, porfavor registra alguna",Toast.LENGTH_LONG).show();
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
        if(v.getId()==R.id.donar_dos){
            if(!contra.getText().toString().isEmpty()){

                String contracorres = "";
                String correocorres = "";
                for(int i = 0;i<paypals.length;i++) {
                    if (paypals[i].equals(pays.getSelectedItem().toString())) {
                            contracorres = contras[i];
                            correocorres = paypals[i];
                            break;
                    } else {

                    }
                }
int ve = 0;
conexionWS con3 = new conexionWS("verificaPaypal");
                try{
                    String ver = con3.execute(pays.getSelectedItem().toString(),contra.getText().toString()).get();
                    ve = Integer.parseInt(ver);
                }catch (Exception e){
                    System.out.println(e.toString());
                }
                if(ve!=-1){
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
                    Toast.makeText(this,"Contraseña incorrecta",Toast.LENGTH_LONG).show();
                }
            }else{
                Toast.makeText(this,"Coloca la contraseña de tu cuneta PayPal",Toast.LENGTH_LONG).show();
            }
        }else{
            if(v.getId()==R.id.cancela_donar_dos){
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
