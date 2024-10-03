package com.example.crowdfundingipn;

import android.os.AsyncTask;
import android.os.StrictMode;
import android.util.Log;
import android.widget.Toast;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapPrimitive;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.Blob;

import modelo.UsuarioN;

public class conexionWS extends AsyncTask<String,String,String> {

    static final String NAMESPACE = "http://webServices/";
    static  String METODO = "";
    static final String URL = "http://192.168.3.12:8080/webServiceCrowd/wsInicioSesion?wsdl";
    static final String ACCION = NAMESPACE + METODO;
    conexionWS(String metodo){
        this.METODO = metodo;
    }

    @Override
    protected String doInBackground(String... params) {
        SoapObject request = new SoapObject(NAMESPACE,METODO);
        if(METODO.equals("consultaUsuario")||METODO.equals("consultaMisProyectos")|| METODO.equals("consultaTarjetas")|| METODO.equals("consultaPayPal")){
            request.addProperty("boleta",Integer.parseInt(params[0]));
        }else {
            if(METODO.equals("iniciaSesion")){
            request.addProperty("boleta", Integer.parseInt(params[0]));
            request.addProperty("contraseña", params[1]);
        }else{
                if(METODO.equals("registroUsuario")|| METODO.equals("editaUsuario")){
                    request.addProperty("boleta", Integer.parseInt(params[0]));
                    request.addProperty("nombre", params[1]);
                    request.addProperty("apellidos", params[2]);
                    request.addProperty("escuela", params[3]);
                    request.addProperty("edad", Integer.parseInt(params[4]));
                    request.addProperty("correo", params[5]);
                    request.addProperty("contraseña", params[6]);
                }else{
                    if(METODO.equals("validaCorreo")){
                        request.addProperty("correo",params[0]);
                    }else{
                        if(METODO.equals("registraProyecto")){

                            request.addProperty("nombreProyecto", params[0]);
                            request.addProperty("descripcion", params[1]);
                            request.addProperty("imagen", params[2]);
                            request.addProperty("financiacion", params[3]);
                            request.addProperty("plazoTiempo", Integer.parseInt(params[4]));
                            request.addProperty("recompensas", params[5]);
                            request.addProperty("categoria", params[6]);
                            request.addProperty("boleta", Integer.parseInt(params[7]));
                        }else{
                            if(METODO.equals("consultaProyecto")){
                                request.addProperty("nombreProyecto", params[0]);
                            }else{
                                if(METODO.equals("consultaProyectosBuscando")){
                                    request.addProperty("nombreProyecto", params[0]);
                                    request.addProperty("boleta", Integer.parseInt(params[1]));
                                }else{
                                    if(METODO.equals("editaProyecto")){
                                        request.addProperty("nombreProyecto", params[0]);
                                        request.addProperty("descripcion", params[1]);
                                        request.addProperty("imagen", params[2]);
                                        request.addProperty("financiacion", params[3]);
                                        request.addProperty("plazoTiempo", Integer.parseInt(params[4]));
                                        request.addProperty("recompensas", params[5]);
                                        request.addProperty("categoria", params[6]);
                                    }else{
                                        if(METODO.equals("eliminaProyecto")){
                                            request.addProperty("idProyecto", Integer.parseInt(params[0]));
                                        }else{
                                            if(METODO.equals("realizaDonacion")){
                                                request.addProperty("idProyecto", Integer.parseInt(params[0]));
                                                request.addProperty("boleta", Integer.parseInt(params[1]));
                                                request.addProperty("monto", params[2]);
                                            }else{
                                                if(METODO.equals("verificaPaypal")){
                                                    request.addProperty("correoPP", params[0]);
                                                    request.addProperty("contraPP", params[1]);
                                                }else{
                                                    if(METODO.equals("registraPaypal")){
                                                        request.addProperty("correoPP", params[0]);
                                                        request.addProperty("contraPP", params[1]);
                                                        request.addProperty("boleta", Integer.parseInt(params[2]));
                                                    }else{
                                                        if(METODO.equals("registraTarjeta")){
                                                            request.addProperty("numTarjeta", params[0]);
                                                            request.addProperty("codigo", Integer.parseInt(params[1]));
                                                            request.addProperty("fecha", params[2]);
                                                            request.addProperty("direccion", params[3]);
                                                            request.addProperty("tipoTag", params[4]);
                                                            request.addProperty("boleta", Integer.parseInt(params[5]));
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
        envelope.dotNet=false;
        envelope.setOutputSoapObject(request);
        HttpTransportSE transporte = new HttpTransportSE(URL);
        //SoapPrimitive response = null;
        Object response=null;
        //Log.d("transporte",request.toString());
        try{
            transporte.call(ACCION,envelope);
            System.out.println("si pasa de aqui");
            response = (Object) envelope.getResponse();
            System.out.println("si pasa de aqui x2");
            //Log.d("reps",response.toString());
            System.out.println(response.toString());
            // Vector<?> vector = (Vector<?>) response.getProperty(0);
            //int count = vector.size();
            //Log.d("vector",String.valueOf(count));

        }catch(Exception e){
           // Log.d("eXXX",e.getMessage());
            System.out.println("hola: "+e.toString());



        }
        return response.toString();
    }
    /*public UsuarioN consultaUser(int boleta){

        SoapObject request = new SoapObject(NAMESPACE,METODO);
        if(METODO.equals("consultaUsuario")){
            request.addProperty("boleta",boleta);
        }else {

        }
        SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
        envelope.dotNet=false;
        envelope.setOutputSoapObject(request);
        HttpTransportSE transporte = new HttpTransportSE(URL);
        SoapPrimitive response = null;
        UsuarioN u = null;
        //Log.d("transporte",request.toString());
        try{
            transporte.call(ACCION,envelope);
            response = (SoapPrimitive) envelope.getResponse();
            //Log.d("reps",response.toString());
            System.out.println(response.toString());
            u= (UsuarioN) envelope.getResponse();
            System.out.println(u);
            // Vector<?> vector = (Vector<?>) response.getProperty(0);
            //int count = vector.size();
            //Log.d("vector",String.valueOf(count));

        }catch(Exception e){
            // Log.d("eXXX",e.getMessage());
            System.out.println(e.toString());
        }
        return u;
    }*/
}
