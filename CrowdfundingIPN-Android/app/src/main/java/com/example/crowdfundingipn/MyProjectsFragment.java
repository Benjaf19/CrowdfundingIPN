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
import android.widget.Button;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class MyProjectsFragment extends Fragment implements View.OnClickListener {
    Intent activi;
    Context contexto;
    private List<Project> lstProject;

    Button añade;
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View vista =inflater.inflate(R.layout.fragment_my_projects, container, false);
        añade = vista.findViewById(R.id.anadeRroyecto);

        añade.setOnClickListener(this);


        lstProject = new ArrayList<>();
        conexionWS con = new conexionWS("consultaMisProyectos");
        SharedPreferences sesion = PreferenceManager.getDefaultSharedPreferences(contexto);
        int valor= sesion.getInt("Usuario",0);
        JSONArray jsonArray = null;
        String boleta = Integer.toString(valor);
        String ver = "";
        try {
            ver = con.execute(boleta).get();
            jsonArray = new JSONArray(ver);
            for (int i = 0;i<jsonArray.length();i++){
                JSONObject ob = jsonArray.getJSONObject(i);
                lstProject.add(new Project(ob.getString("nombre"),ob.getString("descripcion"), Float.parseFloat(ob.getString("financiacion")),ob.getInt("plazo"),ob.getString("recompensa"),ob.getString("categoria"),R.drawable.proyecto1,ob.getInt("idProyecto"),ob.getDouble("suma"),true,ob.getString("imagen")));
            }
        }catch (Exception e){
            System.out.println(e.toString());
        }
        RecyclerView myrv=(RecyclerView)vista.findViewById(R.id.recyclerview_mypro);
        RecyclerViewAdapter myAdapter = new RecyclerViewAdapter(contexto,lstProject);
        myrv.setLayoutManager(new GridLayoutManager(contexto,2));
        myrv.setAdapter(myAdapter);
        return vista;
    }
    @Override
    public void onAttach (Activity activity) {
        super.onAttach(activity);

        contexto = getActivity();

        activi = new Intent(contexto,agregaProyecto.class);
        System.out.println("Si jala el attach");
    }

    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.anadeRroyecto){
            startActivity(activi);
        }
    }
}
