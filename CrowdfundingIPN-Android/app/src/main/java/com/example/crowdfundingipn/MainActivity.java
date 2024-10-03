package com.example.crowdfundingipn;

import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;
import android.os.AsyncTask;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapPrimitive;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

import java.sql.Blob;
import java.util.Date;

import modelo.UsuarioN;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {
private Button inicia,crear,recupera;
private EditText bol,pass;
Date fecha = new Date();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        inicia = findViewById(R.id.logear);
        bol = findViewById(R.id.boleta);
        pass =  findViewById(R.id.contraseña);
        recupera = findViewById(R.id.recupera_contra);

crear = findViewById(R.id.crear_cuenta);

        recupera.setOnClickListener(this);
        inicia.setOnClickListener(this);
        crear.setOnClickListener(this);

    }

    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.logear){
            String ver = "";
            conexionWS con = new conexionWS("iniciaSesion");
            try {


                ver=con.execute(bol.getText().toString(), pass.getText().toString()).get();
                System.out.println("Returno: " +ver);
                int verifica = Integer.parseInt(ver);
                if(verifica==1){

                    conexionWS con2 = new conexionWS("consultaUsuario");
                    //UsuarioN u = con2.consultaUser(Integer.parseInt(bol.getText().toString()));
                    String user = con2.execute(bol.getText().toString()).get();
                    String[] us=user.split(",");
                    UsuarioN u = new UsuarioN(Integer.parseInt(us[0]),us[1],us[2],us[3],Integer.parseInt(us[4]),us[5],us[6],fecha);
                    SharedPreferences sesion = PreferenceManager.getDefaultSharedPreferences(this);
                    sesion.edit().putInt("Usuario",u.getBoleta()).commit();

                    Toast.makeText(getApplicationContext(),"Bienvenid@ "+u.getNombre()+"",Toast.LENGTH_SHORT).show();
                    Intent a = new Intent(this, homepage.class);
                    startActivity(a);
                }else{
                    if(verifica==2){
                        Toast.makeText(getApplicationContext(),"Contraseña Incorrecta",Toast.LENGTH_SHORT).show();
                    }else{
                        Toast.makeText(getApplicationContext(),"Usuario inexistente",Toast.LENGTH_SHORT).show();
                        Intent ac = new Intent(this, registroUsuario.class);
                        startActivity(ac);
                    }
                }
            }catch (Exception e){
                System.out.println(e.toString());
            }


            // new operationSoap().execute(bol.getText().toString(),pass.getText().toString());

        }else{
            if(v.getId()==R.id.crear_cuenta){
                Intent act = new Intent(this, registroUsuario.class);
                startActivity(act);
            }else{
                if(v.getId()==R.id.recupera_contra){
                    Intent acti = new Intent(this,recuperaContrasena.class);
                    startActivity(acti);
                }
            }
        }
    }

   /* private class operationSoap extends AsyncTask<String,String,String> {
        static final String NAMESPACE = "http://webServices/";
        static final String METODO = "iniciaSesion";
        static final String URL = "http://192.168.0.18:8080/webServiceCrowd/wsInicioSesion?wsdl";
        static final String ACCION = NAMESPACE+METODO;

        @Override
        protected String doInBackground(String... params) {
            SoapObject request = new SoapObject(NAMESPACE,METODO);
            request.addProperty("boleta",Integer.parseInt(params[0]));
            request.addProperty("contraseña",params[1]);
            SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
            envelope.dotNet=false;
            envelope.setOutputSoapObject(request);
            HttpTransportSE transporte = new HttpTransportSE(URL);
            SoapPrimitive response = null;
            //Log.d("transporte",request.toString());
            try{
                transporte.call(ACCION,envelope);
                response = (SoapPrimitive) envelope.getResponse();
                Log.d("reps",response.toString());
                int ress = Integer.parseInt(response.toString());
                if(ress == 0){
                    runOnUiThread(new Runnable() {
                        public void run() {
                            final Toast toast =  Toast.makeText(getApplicationContext(),"No usuario ", Toast.LENGTH_SHORT);
                            toast.show();
                        }
                    });
                    //Intent ac = new Intent(this, registroUsuario.class);
                    //startActivity(ac);

                }else{
                    if(ress==1){
                        runOnUiThread(new Runnable() {
                            public void run() {
                                final Toast toast =  Toast.makeText(getApplicationContext(),"Bienvenido", Toast.LENGTH_SHORT);
                                toast.show();
                            }
                        });
                    }else{
                        runOnUiThread(new Runnable() {
                            public void run() {
                                final Toast toast =  Toast.makeText(getApplicationContext(),"Contra equivocada", Toast.LENGTH_SHORT);
                                toast.show();
                            }
                        });
                    }
                }
                // Vector<?> vector = (Vector<?>) response.getProperty(0);
                //int count = vector.size();
                //Log.d("vector",String.valueOf(count));

            }catch(Exception e){
                Log.d("eXXX",e.getMessage());
                System.out.println(e.toString());
            }
            return response.toString();
        }
    }*/
}
