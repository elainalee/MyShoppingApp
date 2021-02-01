package leeJ.co.MyApp.utils;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.view.LayoutInflater;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.squareup.picasso.Picasso;

import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;
import leeJ.co.MyApp.R;
import leeJ.co.MyApp.models.ItemViewModel;
import leeJ.co.MyApp.models.UserViewModel;
import leeJ.co.MyApp.screens.MainScreen;


public class ItemAdapter extends RecyclerView.Adapter<ItemAdapter.Viewholder> {
    private static final String ENGINE_NAME = "my_engine_id";
    private static final String CHANNEL = "my_app/request";
    private static final String LDP_FLUTTER_ROUTE = "/lead_to_ldp";

    private UserViewModel userViewModel;
    private List<ItemViewModel> itemViewModels;
    private Context context;

    public ItemAdapter(UserViewModel userViewModel, ArrayList<ItemViewModel> itemViewModels, Context context) {
        this.userViewModel = userViewModel;
        this.itemViewModels = itemViewModels;
        this.context = context;
    }

    private static String curListingID = "";

    public static String getCurListingID() {
        return curListingID;
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
        holder.price.setText(String.format("%s", itemViewModel.getPrice()));
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

        holder.cardView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                curListingID = itemViewModel.getListingID();
                navigateToLdpScreen();

                //implement onClick
                Toast.makeText(context, "Action clicked - profile", Toast.LENGTH_LONG).show();
            }

            private void navigateToLdpScreen() {
                if (itemViewModel.getListingID() != null && itemViewModel.getListingID() == curListingID) {
                    context.startActivity(FlutterActivity.withCachedEngine(ENGINE_NAME).build(context));
                }
            }
        });
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

    // View holder class for initializing of views such as TextView and Imageview.
    public class Viewholder extends RecyclerView.ViewHolder {
        CardView cardView;
        ImageView imageView;
        TextView title, description, price;

        public Viewholder(@NonNull View itemView) {
            super(itemView);
            cardView = itemView.findViewById(R.id.item_card);
            imageView = itemView.findViewById(R.id.item_image);
            title = itemView.findViewById(R.id.item_title);
            price = itemView.findViewById(R.id.item_price);
            description = itemView.findViewById(R.id.item_description);
        }
    }

    private void setFlutterEngine() {
        // Instantiate a FlutterEngine.
        FlutterEngine flutterEngine = new FlutterEngine(context);
        // Configure an initial route.
        flutterEngine.getNavigationChannel().setInitialRoute(LDP_FLUTTER_ROUTE);
        // Start executing Dart code to pre-warm the FlutterEngine.
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );
        // Cache the FlutterEngine to be used by FlutterActivity or FlutterFragment.
        FlutterEngineCache
                .getInstance()
                .put(ENGINE_NAME, flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor(), CHANNEL).setMethodCallHandler(
                ((call, result) -> {
                    if (call.method.equals("getUsername")) {
                        result.success(userViewModel.getUsername());
                    } else if (call.method.equals("getPassword")) {
                        result.success(userViewModel.getPassword());
                    } else if (call.method.equals("getListingID")) {
                        result.success(curListingID);
                    } else {
                        result.notImplemented();
                    }
                })
        );
    }


}
