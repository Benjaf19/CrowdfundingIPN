package com.example.crowdfundingipn;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
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

import com.getbase.floatingactionbutton.FloatingActionButton;
import com.getbase.floatingactionbutton.FloatingActionsMenu;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;



public class MethodsPaymentFragment extends Fragment implements View.OnClickListener {
    Intent activi,activi2;
    Context contexto;
    FloatingActionsMenu menu;
    FloatingActionButton agregatag,agregaPP;

    private List<metodosPago> lstProject;




    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View vista = inflater.inflate(R.layout.fragment_methods_payment, container, false);
        lstProject = new ArrayList<>();
        menu = vista.findViewById(R.id.menu);
        agregaPP = vista.findViewById(R.id.agrega_Paypal);
        agregatag = vista.findViewById(R.id.agrega_Tarjeta);

        agregatag.setOnClickListener(this);
        agregaPP.setOnClickListener(this);

        conexionWS con = new conexionWS("consultaTarjetas");
        //conexionWS con2 = new conexionWS("consultaPayPal");
        SharedPreferences sesion = PreferenceManager.getDefaultSharedPreferences(contexto);
        int valor= sesion.getInt("Usuario",0);
        JSONArray jsonArray = null,jsonA = null;
        String boleta = Integer.toString(valor);
        String ver = "";
        String ver2 ="";
        try {
            ver = con.execute(boleta).get();

            jsonArray = new JSONArray(ver);

            for (int i = 0;i<jsonArray.length();i++){
                JSONObject ob = jsonArray.getJSONObject(i);
                lstProject.add(new metodosPago(R.drawable.logotag,"**** **** **** "+ob.getString("numeroTAG").substring(12)));
            }
            con = new conexionWS("consultaPayPal");
            ver2 = con.execute(boleta).get();
            jsonA = new JSONArray(ver2);
            for (int i = 0;i<jsonA.length();i++){
                JSONObject ob = jsonA.getJSONObject(i);
                lstProject.add(new metodosPago(R.drawable.paypallogo,ob.getString("correoPP")));
            }
        }catch (Exception e){
            System.out.println(e.toString());
        }
        RecyclerView myrv=(RecyclerView)vista.findViewById(R.id.recyclerview_metodos);
        AdapterPagos myAdapter = new AdapterPagos(contexto,lstProject);
        myrv.setLayoutManager(new GridLayoutManager(contexto,1));
        myrv.setAdapter(myAdapter);
        return vista;
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);

        contexto = getActivity();

        activi = new Intent(contexto, addPaypal.class);
        activi2 = new Intent(contexto, addCard.class);
        System.out.println("Si jala el attach");
    }

    @Override
    public void onClick(View v) {
        if (v.getId() == R.id.agrega_Paypal) {
            startActivity(activi);
        }else{
            if(v.getId()==R.id.agrega_Tarjeta){
                startActivity(activi2);
            }
        }
    }
}