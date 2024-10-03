package com.example.crowdfundingipn;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.provider.MediaStore;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Base64;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.Toast;

import java.io.ByteArrayOutputStream;

public class editaProyecto extends AppCompatActivity implements View.OnClickListener {
    ImageView imgPro;
    Button guaradar,agregaFoto,cancelar;
    EditText nombrePro,descripcion,plazo,financiacion,recompensas;
    Spinner categoria;
    Bitmap bitmap;
    Project pro;
    String[] categs = {"ARTE","CIENCIA","SALUD","EDUCACION","TECNOLOGIA"};
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edita_proyecto);

        Intent intent=getIntent();
        String name= intent.getExtras().getString("Nombre");
        String Description=intent.getExtras().getString("Descripcion");
        String Category = intent.getExtras().getString("Categoria");
        String Rewards =intent.getExtras().getString("Recompensas");
        float Financing = intent.getExtras().getFloat("Financiamiento");
        int Time = intent.getExtras().getInt("Plazo");
       // String image = intent.getExtras().getString("imagen");
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

        imgPro = findViewById(R.id.imgProyectoed);
        guaradar = findViewById(R.id.edita_proyecto);
        agregaFoto = findViewById(R.id.addImged);
        nombrePro = findViewById(R.id.nombreProadded);
        descripcion= findViewById(R.id.addDescripcioned);
        plazo = findViewById(R.id.addPlazoed);
        financiacion = findViewById(R.id.addFinanciaminrtoed);
        recompensas = findViewById(R.id.addRecompensased);
        categoria = (Spinner) findViewById(R.id.addcategoriaed);
        cancelar = findViewById(R.id.cancela_proyecto);
        categoria.setAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, categs));

        byte[] code= Base64.decode(image,Base64.DEFAULT);

        bitmap = BitmapFactory.decodeByteArray(code,0,code.length);

        imgPro.setImageBitmap(bitmap);
        nombrePro.setText(pro.getNombre());
        descripcion.setText(pro.getDescripcion());
        plazo.setText(Integer.toString(pro.getPlazo()));
        financiacion.setText(Float.toString(pro.getFinanciacion()));
        recompensas.setText(pro.getRecompensas());
        for(int i = 0;i<categs.length;i++){
            if(pro.getCategoria().equals(categs[i])){
                categoria.setSelection(i);
            }
        }
nombrePro.setEnabled(false);
       /* imgPro.buildDrawingCache();
        bitmap = imgPro.getDrawingCache(); */
       // BitmapDrawable drawable = (BitmapDrawable) imgPro.getDrawable();
       //  bitmap = drawable.getBitmap();

        guaradar.setOnClickListener(this);
        cancelar.setOnClickListener(this);
        agregaFoto.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.cancela_proyecto){
            Intent ac = new Intent(this,Project_Activity.class);
            ac.putExtra("Nombre",pro.getNombre());
            ac.putExtra("Descripcion",pro.getDescripcion());
            ac.putExtra("Categoria",pro.getCategoria());
            ac.putExtra("Financiamiento",pro.getFinanciacion());
            ac.putExtra("Plazo",pro.getPlazo());
            ac.putExtra("Recompensas",pro.getRecompensas());
           // ac.putExtra("imagen",pro.getImagen());
            ac.putExtra("idProyecto",pro.getIdProyecto());
            ac.putExtra("suma",pro.getSuma());
            ac.putExtra("edita",pro.getEdit());
            startActivity(ac);
        }else{
            if(v.getId()==R.id.edita_proyecto){
                String nombre = nombrePro.getText().toString();
                String desc = descripcion.getText().toString();
                String img = convertBitmaptostring(bitmap);
                String finan = financiacion.getText().toString();
                String plaz = plazo.getText().toString();
                String rec = recompensas.getText().toString();
                String catt = categoria.getSelectedItem().toString();

                try {
                    conexionWS con = new conexionWS("editaProyecto");
                    String ver = con.execute(nombre, desc, img, finan, plaz, rec, catt).get();
                    int veri = Integer.parseInt(ver);
                    if (veri != -1) {
                        Toast.makeText(getApplicationContext(), "Datos actualizados con exito", Toast.LENGTH_SHORT).show();

                        Intent ac = new Intent(this,homepage.class);
                        startActivity(ac);

                    } else {
                        Toast.makeText(getApplicationContext(), "Error, intentelo de nuevo más tarde", Toast.LENGTH_LONG).show();
                    }
                }catch (Exception e){
                    System.out.println(e.toString());
                }
            }else{
                if(v.getId()==R.id.addImged){
                    cargaImg();
                }
            }
        }
    }

    public void cargaImg(){
        Intent act = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
        act.setType("image/");
        startActivityForResult(act.createChooser(act,"Seleccione la aplicación"),10);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if(resultCode==RESULT_OK){
            Uri path = data.getData();
            try {
                bitmap=MediaStore.Images.Media.getBitmap(this.getContentResolver(),path);
                imgPro.setImageBitmap(bitmap);
            } catch (Exception e) {
                System.out.println(e.toString());
            }
        }else{

        }


    }

    public String convertBitmaptostring(Bitmap b){
        String val = "";
        ByteArrayOutputStream array = new ByteArrayOutputStream();
        try {
            b.compress(Bitmap.CompressFormat.JPEG, 100, array);
            byte[] bytes = array.toByteArray();

            val= android.util.Base64.encodeToString(bytes, android.util.Base64.DEFAULT);
        }catch (Exception e){
            System.out.println(e.toString());
        }
        // System.out.println(val);
        return val;
    }
}
