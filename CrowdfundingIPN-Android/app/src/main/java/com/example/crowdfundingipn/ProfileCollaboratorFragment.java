package com.example.crowdfundingipn;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

public class ProfileCollaboratorFragment extends Fragment implements View.OnClickListener {
    Context contexto;
    Intent activi;
    Button b;
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View vista =inflater.inflate(R.layout.fragment_profile_collaborator, container, false);
        b = vista.findViewById(R.id.formu);
        b.setOnClickListener(this);



        return vista;
    }
    @Override
    public void onAttach (Activity activity) {
        super.onAttach(activity);

        contexto = getActivity();

        activi = new Intent(contexto,registraProyecto.class);
        System.out.println("Si jala el attach");
    }

    @Override
    public void onClick(View v) {
        if(v.getId()==R.id.formu){
            startActivity(activi);
        }
    }
}
