package com.example.crowdfundingipn;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.provider.MediaStore;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;


import android.util.Base64;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

import com.squareup.picasso.Picasso;

import org.apache.commons.io.IOUtils;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

public class registraProyecto extends AppCompatActivity implements View.OnClickListener {
ImageView imgProyecto;
Button regImg;
Bitmap bitmap;
    CifrarSHA cf = new CifrarSHA();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_registra_proyecto);
        imgProyecto= findViewById(R.id.imagePro);
        regImg = findViewById(R.id.agregaImg);

        regImg.setOnClickListener(this);

    }

    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.agregaImg){
            cargaImg();
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
            System.out.println("Path = "+path.getPath());
            try {
               InputStream stream = getContentResolver().openInputStream(data.getData());
                bitmap=MediaStore.Images.Media.getBitmap(this.getContentResolver(),path);
                conexionWS conexionWSv;
                conexionWSv= new conexionWS("consultaProyecto");
                String ver1 =conexionWSv.execute("Thanos3").get();
                //String [] proyecto = ver1.split("<->");
                CifrarSHA cf = new CifrarSHA();

                 byte[] code=Base64.decode(ver1,Base64.DEFAULT);
                 //InputStream st = new ByteArrayInputStream(code);
                 Bitmap bb = BitmapFactory.decodeByteArray(code,0,code.length);
                 //ByteArrayOutputStream ay = new ByteArrayOutputStream();
                 //bb.compress(Bitmap.CompressFormat.JPEG,100,ay);
                 //= org.owasp.esapi.codecs.Base64.decode(ver1);
               // System.out.println("Parametro 3----------------------------||||"+proyecto[3]+"||||----------------------------");
                String imagenCon = new String(code);
                System.out.println("Esta es la imagen de los asperger"+imagenCon);
                /*Picasso.with(this)

                        .load("data:image/jpg;base64,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")
                        .error(R.mipmap.ic_launcher)
                        .fit()
                        .centerInside()
                        .into(imgProyecto);*/
                imgProyecto.setImageBitmap(bb);
               String texto = IOUtils.toString(stream);
               InputStream stream2 = new ByteArrayInputStream(texto.getBytes());
                String texto2 = IOUtils.toString(stream2);
               // System.out.println("El stream es: " +texto);
                //System.out.println("Stream 2 "+texto2);
                if(texto.equals(texto2)){
                    System.out.println("SOn identicos");
                }else{
                    System.out.println("No son identicos");
                }
String imgcf = Base64.encodeToString(texto.getBytes(),Base64.DEFAULT); //new String(Base64.encodeBase64(cf.cifra(texto)));


               // System.out.println("cifradoo:  "+imgcf);
               conexionWSv = new conexionWS("registraProyecto");
                String ver = conexionWSv.execute("EXAM","sindromedown2890",imgcf,"50","30","recompenasss","categ","2017090841").get();
                int veri = Integer.parseInt(ver);
                if(veri!=-1){
                    Toast.makeText(getApplicationContext(),"Proyecto Agregado",Toast.LENGTH_SHORT).show();
                }else{
                    Toast.makeText(getApplicationContext(),"Error",Toast.LENGTH_SHORT).show();
                }

            }catch (Exception e){
                System.out.println(e.toString());
            }

            //System.out.println(path.toString());
            //imgProyecto.setImageURI(path);

        }
    }
    public String convertBitmaptostring(Bitmap b){
        ByteArrayOutputStream array = new ByteArrayOutputStream();
        b.compress(Bitmap.CompressFormat.JPEG,100,array);
        byte[] bytes = array.toByteArray();

        String val =android.util.Base64.encodeToString(bytes,android.util.Base64.DEFAULT);

        System.out.println(val);
        return val;
    }

    private Bitmap get_imagen(String url) {
        Bitmap bm = null;
        try {
            URL _url = new URL(url);
            URLConnection con = _url.openConnection();
            con.connect();
            InputStream is = con.getInputStream();
            BufferedInputStream bis = new BufferedInputStream(is);
            bm = BitmapFactory.decodeStream(bis);
            bis.close();
            is.close();
        } catch (IOException e) {
            System.out.println(e.toString());
        }
        return bm;
    }
}
