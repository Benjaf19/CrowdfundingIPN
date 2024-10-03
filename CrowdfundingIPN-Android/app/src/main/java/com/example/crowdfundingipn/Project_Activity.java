package com.example.crowdfundingipn;

import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Base64;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

public class Project_Activity extends AppCompatActivity implements View.OnClickListener {

    private TextView proname,prodescription,prorewards,procategory,profinancing,protime,sumaa;
    private ImageView prothumb;
    private Button donaoedita,eliminar;
    Bitmap bitmap;
    Project pro ;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_project_);

        proname = (TextView)findViewById(R.id.pro_name);
        prodescription = (TextView)findViewById(R.id.pro_descrip);
        prorewards = (TextView)findViewById(R.id.pro_rewards);
        procategory = (TextView)findViewById(R.id.pro_category);
        profinancing = (TextView)findViewById(R.id.pro_money);
        protime = (TextView)findViewById(R.id.pro_days);
        prothumb = (ImageView)findViewById(R.id.project_img_view);
        sumaa = findViewById(R.id.pro_suma);
        donaoedita = findViewById(R.id.donaedita);
        eliminar = findViewById(R.id.borra_proyecto);

        //Recive data del Adapter
        Intent intent=getIntent();
        String name= intent.getExtras().getString("Nombre");
        String Description=intent.getExtras().getString("Descripcion");
        String Category = intent.getExtras().getString("Categoria");
        String Rewards =intent.getExtras().getString("Recompensas");
        float Financing = intent.getExtras().getFloat("Financiamiento");
        int Time = intent.getExtras().getInt("Plazo");
      //  String image = intent.getExtras().getString("imagen");
        String image = "";
        conexionWS con = new conexionWS("consultaProyecto");
        try{
            image = con.execute(name).get();
        }catch (Exception e){

        }
        int idProyecto = intent.getExtras().getInt("idProyecto");
        double suma = intent.getExtras().getDouble("suma");
        boolean edita = intent.getExtras().getBoolean("edita");
pro = new Project(name,Description,Financing,Time,Rewards,Category,0,idProyecto,suma,edita,image);

        if(edita==true){
            donaoedita.setText("Editar");
            if(suma==0) {
                eliminar.setVisibility(View.VISIBLE);
            }else{
                eliminar.setVisibility(View.INVISIBLE);
            }
        }else{
            donaoedita.setText("Donar");
            eliminar.setVisibility(View.INVISIBLE);
        }
        //Se asignan valores
        proname.setText(name);
        prodescription.setText(Description);
        prorewards.setText(Rewards);
        procategory.setText(Category);
        profinancing.setText(Float.toString(Financing)+" ");
        protime.setText(Integer.toString(Time));

        byte[] code= Base64.decode(image,Base64.DEFAULT);

        bitmap = BitmapFactory.decodeByteArray(code,0,code.length);
        prothumb.setImageBitmap(bitmap);
        sumaa.setText(Double.toString(suma)+" MXN");


        donaoedita.setOnClickListener(this);
        eliminar.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.donaedita){
            String accion =donaoedita.getText().toString();
            if(accion.equalsIgnoreCase("Editar")){
                    Intent ac = new Intent(this,editaProyecto.class);
                ac.putExtra("Nombre",pro.getNombre());
                ac.putExtra("Descripcion",pro.getDescripcion());
                ac.putExtra("Categoria",pro.getCategoria());
                ac.putExtra("Financiamiento",pro.getFinanciacion());
                ac.putExtra("Plazo",pro.getPlazo());
                ac.putExtra("Recompensas",pro.getRecompensas());
                //ac.putExtra("imagen",pro.getImagen());
                ac.putExtra("idProyecto",pro.getIdProyecto());
                ac.putExtra("suma",pro.getSuma());
                ac.putExtra("edita",pro.getEdit());
                    startActivity(ac);
            }else{
                Intent ac = new Intent(this,donar.class);
                ac.putExtra("idProyecto",pro.getIdProyecto());
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
        }else {
            if(v.getId()==R.id.borra_proyecto){
                AlertDialog.Builder msj = new AlertDialog.Builder(this);
                msj.setMessage("¿Deseas eliminar el proyecto "+pro.getNombre()+" de forma permanente?");
                msj.setTitle("Eliminar");
                msj.setPositiveButton("Si", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                       conexionWS con = new conexionWS("eliminaProyecto");
                       try{
                           String ver = con.execute(Integer.toString(pro.getIdProyecto())).get();
                           int verifica = Integer.parseInt(ver);
                           if(verifica!=-1){

                               Toast.makeText(getApplicationContext(), "Se ha borrado el proyecto "+pro.getNombre(), Toast.LENGTH_LONG).show();
                               Intent acti = new Intent(getApplicationContext(),homepage.class);
                               startActivity(acti);
                           }else{
                               Toast.makeText(getApplicationContext(), "Ha ocurrido un error", Toast.LENGTH_LONG).show();
                           }
                       }catch (Exception e){
                           System.out.println(e.toString());
                       }
                        //Toast.makeText(getApplicationContext(), "Se ha borrado "+cantidad+" pelicula(s)", Toast.LENGTH_SHORT).show();
                    }
                });
                msj.setNegativeButton("No", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.cancel();

                    }
                });

                AlertDialog d = msj.create();
                d.show();
            }
        }
    }
}
