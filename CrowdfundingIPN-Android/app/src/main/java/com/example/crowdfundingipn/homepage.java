package com.example.crowdfundingipn;

import android.content.Intent;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.support.annotation.NonNull;
import android.support.design.widget.NavigationView;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.widget.Toast;

import java.util.Date;

import modelo.UsuarioN;

public class homepage extends AppCompatActivity  implements View.OnClickListener,NavigationView.OnNavigationItemSelectedListener {
    private DrawerLayout drawer;
TextView nombren,correon ;
Button altaP;
    SharedPreferences sesion;
    int valor= 0 ;
Date fecha = new Date();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_homepage);


        sesion = PreferenceManager.getDefaultSharedPreferences(this);
         valor= sesion.getInt("Usuario",0);



        Toolbar toolbar=findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        drawer = findViewById(R.id.drawer_layout);
        NavigationView navigationView = findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);

        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(this,drawer,toolbar,
                R.string.navigation_drawer_open,R.string.navigation_drawer_close);
        drawer.addDrawerListener(toggle);
        toggle.syncState();

        if (savedInstanceState == null) {

            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, new ProfileFragment()).commit();
            navigationView.setCheckedItem(R.id.myprofile);
        }

       /* txt = findViewById(R.id.texto);
altaP= findViewById(R.id.altaProy);
altaP.setOnClickListener(this);

        SharedPreferences sesion = PreferenceManager.getDefaultSharedPreferences(this);
        int valor = sesion.getInt("Usuario",0);
        // esto es para cerrr la sesion    sesion.edit().remove("Usuario").commit();
        txt.setText(Integer.toString(valor));
        System.out.println(valor);*/
    }
    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        nombren = findViewById(R.id.nombrenav);
        correon = findViewById(R.id.correonav);
        conexionWS con = new conexionWS("consultaUsuario");
        try {
            String ver = con.execute("2020600236").get();
            String[] us = ver.split(",");
            UsuarioN u = new UsuarioN(Integer.parseInt(us[0]), us[1], us[2], us[3], Integer.parseInt(us[4]), us[5], us[6], fecha);

            nombren.setText(Integer.toString(u.getBoleta()));
            correon.setText(u.getNombre()+" "+u.getApellidos());
        }catch (Exception e){
            System.out.println(e.toString());
        }
        switch (item.getItemId()){

            case R.id.myprofile:
                getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,new ProfileFragment()).commit();
                break;
            case R.id.my_projects:
                getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,new MyProjectsFragment()).commit();
                break;
            case R.id.metodospayment:
                getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,new MethodsPaymentFragment()).commit();
                break;
            case R.id.projects:
                getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,new ProjectsFragment()).commit();
                break;
            case R.id.collaborator_profile:
                getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,new ProfileCollaboratorFragment()).commit();
                break;
            case R.id.request:
                getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container,new RequestsFragment() ).commit();
                break;
            case R.id.log_out:
                sesion.edit().remove("Usuario").commit();
                Intent ac = new Intent(this,MainActivity.class);
                startActivity(ac);
                Toast.makeText(this,"Sesión Cerrada",Toast.LENGTH_SHORT).show();
                break;
        }

        drawer.closeDrawer(GravityCompat.START);

        return true;
    }

    @Override
    public void onBackPressed() {

        if (drawer.isDrawerOpen(GravityCompat.START)){

            drawer.closeDrawer(GravityCompat.START);
        }else {

            super.onBackPressed();
        }
    }

    @Override
    public void onClick(View v) {
       /* if(v.getId()==R.id.altaProy){
            Intent ac = new Intent(this,informacionUsuario.class);
            startActivity(ac);
        }*/
    }
}
