package com.example.crowdfundingipn;



import android.content.Intent;
import android.os.StrictMode;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class recuperaContrasena extends AppCompatActivity implements View.OnClickListener {
    private String Emisor  = "novasoftdevelopers@gmail.com";
    private String ContraEmis = "nadialomino17";
    private String mensaje = "";
    private String To = "";
    private String Subject = "CROWDFUNDING IPN Recupera la contraseña de tu cuenta";

    EditText correo;
    Button recu;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recupera_contrasena);

        correo = findViewById(R.id.correo_recup);
        recu = findViewById(R.id.recuperar);

        recu.setOnClickListener(this);





    }
    public void SendMail() {
        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(Emisor, ContraEmis);
                    }
                });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Emisor));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(To));
            message.setSubject(Subject);
            message.setText(mensaje);

            Transport.send(message);
            System.out.println("Envio el correo");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.recuperar){
            conexionWS con = new conexionWS("validaCorreo");
            try {
                String mail=correo.getText().toString();
                String ver = con.execute(mail).get();
                if(!ver.equals("0")){
                    mensaje = "Haga clic en el siguiente enlace para cambiar la contraseña de su cuenta de Crowdfunding IPN, si usted no solicito un cambio de contraseña, por favor ignore este correo electronico."
                            + " http://192.168.0.18:8080/Crowd/recuperaContrase%C3%B1a.jsp?nfrp=sntwfp&atx="+ver+"";
                    To=mail;
                    SendMail();
                    Toast.makeText(getApplicationContext(),"Se te ha enviado un correo de recuperación de contraseña, revisalo y sigue con el proceso",Toast.LENGTH_LONG).show();
                    //Snackbar.make(v, "Se te ha enviado un correo de recuperación de contraseña, checalo y sigue con el proceso", Snackbar.LENGTH_LONG)
                      //      .setAction("Action", null).show();
                    Intent ac = new Intent(this,MainActivity.class);
                    startActivity(ac);

                }else{
                    Toast.makeText(getApplicationContext(),"El correo no esta registrado",Toast.LENGTH_SHORT).show();
                }
            }catch (Exception e){
                System.out.println(e.toString());
            }
        }
    }
}
