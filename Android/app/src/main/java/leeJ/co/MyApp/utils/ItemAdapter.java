package leeJ.co.MyApp.utils;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.view.LayoutInflater;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.squareup.picasso.Picasso;

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
        ItemViewModel itemViewModel = itemViewModels.get(position);
        holder.title.setText(itemViewModel.getTitle());
        holder.price.setText("" + itemViewModel.getPrice());
        holder.description.setText(itemViewModel.getDescription());

        String imageURL = itemViewModel.getImageURL();
        if (isValidURL(imageURL)) {
            Picasso.get().load(imageURL)
                    .error(R.drawable.pineapple_default)
                    .placeholder(R.drawable.pineapple_default)
                    .into(holder.imageView);
        } else {
            holder.imageView.setImageResource(R.drawable.pineapple_default);
        }
    }

    private boolean isValidURL(String imageURL) {
        if (imageURL.startsWith(
                "https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/items_images")) {
            return true;
        }
        return false;
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
