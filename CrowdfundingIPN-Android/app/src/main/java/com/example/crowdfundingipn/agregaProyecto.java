package com.example.crowdfundingipn;

import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.provider.MediaStore;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.Toast;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

public class agregaProyecto  extends AppCompatActivity implements View.OnClickListener  {
ImageView imgPro;
Button crearProyecto,agregaFoto;
EditText nombrePro,descripcion,plazo,financiacion,recompensas;
Spinner categoria;
Bitmap bitmap;
String[] categs = {"ARTE","CIENCIA","SALUD","EDUCACION","TECNOLOGIA"};
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_addproject);

imgPro = findViewById(R.id.imgProyecto);
crearProyecto = findViewById(R.id.addProject);
agregaFoto = findViewById(R.id.addImg);
nombrePro = findViewById(R.id.nombreProadd);
descripcion= findViewById(R.id.addDescripcion);
plazo = findViewById(R.id.addPlazo);
financiacion = findViewById(R.id.addFinanciaminrto);
recompensas = findViewById(R.id.addRecompensas);
categoria = (Spinner) findViewById(R.id.addcategoria);
categoria.setAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, categs));


crearProyecto.setOnClickListener(this);
agregaFoto.setOnClickListener(this);


    }
    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.addImg){
            cargaImg();
        }else{
            if(v.getId()==R.id.addProject){
                conexionWS con = new conexionWS("registraProyecto");
                String nombre = nombrePro.getText().toString();
                String desc = descripcion.getText().toString();
                String img = convertBitmaptostring(bitmap);
                String finan = financiacion.getText().toString();
                String plaz = plazo.getText().toString();
                String rec = recompensas.getText().toString();
                String catt = categoria.getSelectedItem().toString();
                SharedPreferences sesion = PreferenceManager.getDefaultSharedPreferences(this);
                int valor= sesion.getInt("Usuario",0);
                String boleta = Integer.toString(valor);
                try {
                    String ver = con.execute(nombre, desc, img, finan, plaz, rec, catt, boleta).get();
                    int veri = Integer.parseInt(ver);
                    if (veri != -1) {
                        Toast.makeText(getApplicationContext(), "Proyecto Agregado", Toast.LENGTH_SHORT).show();

                        Intent ac = new Intent(this,homepage.class);
                        startActivity(ac);

                    } else {
                        Toast.makeText(getApplicationContext(), "Error, probablemente exista un proyecto con el mismo nombre", Toast.LENGTH_LONG).show();
                    }
                }catch (Exception e){
                    System.out.println(e.toString());
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
