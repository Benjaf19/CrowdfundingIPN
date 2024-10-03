package com.example.crowdfundingipn;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import modelo.Proyecto;

public class ProjectsFragment extends Fragment {
    private List<Project> lstProject;
    Context contexto;
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View vista =inflater.inflate(R.layout.fragment_projects, container, false);

        lstProject = new ArrayList<>();

        conexionWS con = new conexionWS("consultaProyectosBuscando");
        SharedPreferences sesion = PreferenceManager.getDefaultSharedPreferences(contexto);
        int valor= sesion.getInt("Usuario",0);
        JSONArray jsonArray = null;
        String boleta = Integer.toString(valor);
        String ver = "";
        try {
            ver = con.execute("",boleta).get();
             jsonArray = new JSONArray(ver);
            for (int i = 0;i<jsonArray.length();i++){
                JSONObject ob = jsonArray.getJSONObject(i);
                lstProject.add(new Project(ob.getString("nombre"),ob.getString("descripcion"), Float.parseFloat(ob.getString("financiacion")),ob.getInt("plazo"),ob.getString("recompensa"),ob.getString("categoria"),R.drawable.proyecto1,ob.getInt("idProyecto"),ob.getDouble("suma"),false,ob.getString("imagen")));
            }
        }catch (Exception e){
            System.out.println(e.toString());
        }

        /*lstProject.add(new Project("Greendy","Es un invernadero",1500,60,"Una sudadera","Tecnologia",R.drawable.proyecto1,1));
        lstProject.add(new Project("DigitalFuture","Es una computadora",1600,70,"Una sudadera","Salud",R.drawable.proyecto2));
        lstProject.add(new Project("Donkerry","Es un robot",1700,80,"Una sudadera","Ciencias",R.drawable.proyecto3));
        lstProject.add(new Project("Axis","Es una empresa",1800,90,"Una sudadera","Tecnologia",R.drawable.proyecto4));
        lstProject.add(new Project("Koto","Es una marca",1900,50,"Una sudadera","Ambiente",R.drawable.proyecto5));
        lstProject.add(new Project("Marvel","Es una pelicula",2000,40,"Una sudadera","Tecnologia",R.drawable.proyecto6));
        lstProject.add(new Project("Greendy","Es un invernadero",1500,60,"Una sudadera","Tecnologia",R.drawable.proyecto1));
        lstProject.add(new Project("DigitalFuture","Es una computadora",1600,70,"Una sudadera","Salud",R.drawable.proyecto2));
        lstProject.add(new Project("Donkerry","Es un robot",1700,80,"Una sudadera","Ciencias",R.drawable.proyecto3));
        lstProject.add(new Project("Axis","Es una empresa",1800,90,"Una sudadera","Tecnologia",R.drawable.proyecto4));
        lstProject.add(new Project("Koto","Es una marca",1900,50,"Una sudadera","Ambiente",R.drawable.proyecto5));
        lstProject.add(new Project("Marvel","Es una pelicula",2000,40,"Una sudadera","Tecnologia",R.drawable.proyecto6));*/

        RecyclerView myrv=(RecyclerView)vista.findViewById(R.id.recyclerview_pro);
        RecyclerViewAdapter myAdapter = new RecyclerViewAdapter(contexto,lstProject);
        myrv.setLayoutManager(new GridLayoutManager(contexto,2));
        myrv.setAdapter(myAdapter);

        return vista;
    }
    @Override
    public void onAttach (Activity activity) {
        super.onAttach(activity);

        contexto = getActivity();

        //activi = new Intent(contexto,informacionUsuario.class);
        System.out.println("Si jala el attach");
    }
}
