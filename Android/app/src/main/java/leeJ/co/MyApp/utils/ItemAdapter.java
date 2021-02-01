package leeJ.co.MyApp.utils;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.view.LayoutInflater;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;

import leeJ.co.MyApp.R;
import leeJ.co.MyApp.models.ItemViewModel;

public class ItemAdapter extends RecyclerView.Adapter<ItemAdapter.Viewholder> {

    private List<ItemViewModel> itemViewModels;
    private Context context;

    public ItemAdapter(Context context, ArrayList<ItemViewModel> itemViewModels) {
        this.itemViewModels = itemViewModels;
        this.context = context;
    }

    @NonNull
    @Override
    public ItemAdapter.Viewholder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        // to inflate the layout for each item of recycler view.
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_card, parent, false);
        return new Viewholder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ItemAdapter.Viewholder holder, int position) {
        // to set data to textview and imageview of each card layout
        ItemViewModel itemViewModel = itemViewModels.get(position);
        holder.imageView.setImageResource(itemViewModel.getImage());
        holder.title.setText(itemViewModel.getTitle());
        holder.price.setText("" + itemViewModel.getPrice());
        holder.description.setText(itemViewModel.getDescription());
    }

    @Override
    public int getItemCount() {
        // this method is used for showing number
        // of card items in recycler view.
        return itemViewModels.size();
    }

    // View holder class for initializing of
    // your views such as TextView and Imageview.
    public class Viewholder extends RecyclerView.ViewHolder {
        ImageView imageView;
        TextView title, description, price;

        public Viewholder(@NonNull View itemView) {
            super(itemView);
            imageView = itemView.findViewById(R.id.item_image);
            title = itemView.findViewById(R.id.item_title);
            price = itemView.findViewById(R.id.item_price);
            description = itemView.findViewById(R.id.item_description);
        }
    }


}
