package com.example.crowdfundingipn;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.support.annotation.NonNull;
import android.support.v7.widget.CardView;
import android.support.v7.widget.RecyclerView;
import android.util.Base64;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.List;

import modelo.Proyecto;

public class RecyclerViewAdapter extends RecyclerView.Adapter<RecyclerViewAdapter.MyViewHolder> {

    private Context mContext;
    private List<Project> mData;
    private Bitmap bitmap;
    public RecyclerViewAdapter(Context mContext, List<Project> mData) {
        this.mContext = mContext;
        this.mData = mData;
    }

    public RecyclerViewAdapter(ProjectsFragment projectsFragment, List<Proyecto> lstProject) {
    }


    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup viewGroup, int i) {

        View view;
        LayoutInflater mInflater=LayoutInflater.from(mContext);
        view = mInflater.inflate(R.layout.cardview_item_project,viewGroup,false);
        return new MyViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MyViewHolder myViewHolder, final int i) {

        myViewHolder.txt_project_name.setText(mData.get(i).getNombre());
        byte[] code= Base64.decode(mData.get(i).getImagen(),Base64.DEFAULT);

       bitmap = BitmapFactory.decodeByteArray(code,0,code.length);
        myViewHolder.img_project_thumbnail.setImageBitmap(bitmap);
        myViewHolder.cardView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                Intent intent = new Intent(mContext,Project_Activity.class);

                //se pasan datos a Project_Activity
                intent.putExtra("Nombre",mData.get(i).getNombre());
                intent.putExtra("Descripcion",mData.get(i).getDescripcion());
                intent.putExtra("Categoria",mData.get(i).getCategoria());
                intent.putExtra("Financiamiento",mData.get(i).getFinanciacion());
                intent.putExtra("Plazo",mData.get(i).getPlazo());
                intent.putExtra("Recompensas",mData.get(i).getRecompensas());
                //intent.putExtra("imagen",mData.get(i).getImagen());
                intent.putExtra("idProyecto",mData.get(i).getIdProyecto());
                intent.putExtra("suma",mData.get(i).getSuma());
                intent.putExtra("edita",mData.get(i).getEdit());
                //empieza la actividad
                mContext.startActivity(intent);


            }
        });

    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public static class MyViewHolder extends RecyclerView.ViewHolder{

        TextView txt_project_name;
        ImageView img_project_thumbnail;
        CardView cardView;


        public MyViewHolder(View itemView) {
            super(itemView);

            txt_project_name=(TextView)itemView.findViewById(R.id.project_name);
            img_project_thumbnail=(ImageView)itemView.findViewById(R.id.project_img);
            cardView=(CardView)itemView.findViewById(R.id.card_view);

        }
    }

}
