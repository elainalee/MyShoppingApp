package leeJ.co.MyApp.screens;

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;

import io.flutter.embedding.android.FlutterActivity;
import leeJ.co.MyApp.R;
import leeJ.co.MyApp.models.ItemViewModel;
import leeJ.co.MyApp.models.UserViewModel;
import leeJ.co.MyApp.utils.FlutterIntegrator;
import leeJ.co.MyApp.utils.ItemAdapter;
import leeJ.co.MyApp.utils.LdpIntegrator;

public class MainScreen extends AppCompatActivity {
    //Firebase setup
    DatabaseReference reference;
    Query listingQuery;

    UserViewModel userViewModel;
    Toolbar toolBar;
    RecyclerView itemRV;
    ArrayList<ItemViewModel> itemViewModels;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_screen);

        // Hooks
        toolBar = findViewById(R.id.main_screen_toolbar);
        itemRV = findViewById(R.id.main_screen_RV);

        setUserInfo();

        setItemListings();

        setSupportActionBar(toolBar);

        LdpIntegrator.setFlutterEngine(userViewModel.getUsername(), userViewModel.getPassword(), this);

    }

    private void setItemListings() {
        addItemsToList();
        ItemAdapter itemAdapter = new ItemAdapter(itemViewModels, this);
        LinearLayoutManager linearLayoutmanager = new LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false);
        itemRV.setLayoutManager(linearLayoutmanager);
        itemRV.setAdapter(itemAdapter);
    }

    private void addItemsToList() {
        itemViewModels = new ArrayList<>();
        reference = FirebaseDatabase.getInstance().getReference("items_sell");
        listingQuery = reference.orderByChild("title");
        listingQuery.addListenerForSingleValueEvent(new ValueEventListener() {

            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                if (dataSnapshot.exists()) {
                    Iterable<DataSnapshot> itemsCollection = dataSnapshot.getChildren();

                    for (DataSnapshot item: itemsCollection) {
                        String itemID = item.getKey();
                        String itemName = item.child("title").getValue(String.class);
                        String itemDesc = item.child("description").getValue(String.class);
                        double itemPrice = item.child("price").getValue(double.class);
                        String itemImageURL = item.child("image").getValue(String.class);
                        itemViewModels.add(new ItemViewModel(itemID, itemName, itemDesc, itemPrice, itemImageURL));
                    }
                }
            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {
            }
        });

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        if (id == R.id.menu_cart) {
            Toast.makeText(MainScreen.this, "Cart: still in progress", Toast.LENGTH_LONG).show();
            return true;
        } else if (id == R.id.menu_userProfile) {
            navigateToUserProfile();
//            Toast.makeText(MainScreen.this, "Action clicked - profile", Toast.LENGTH_LONG).show();
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    private void navigateToUserProfile() {
        Intent intent = new Intent(getApplicationContext(), UserProfileScreen.class);

        intent.putExtra("name", userViewModel.getName());
        intent.putExtra("username", userViewModel.getUsername());
        intent.putExtra("password", userViewModel.getPassword());
        intent.putExtra("phoneNum", userViewModel.getPhoneNum());
        intent.putExtra("email", userViewModel.getEmail());

        startActivity(intent);
    }

    private void setUserInfo() {
        Intent intent = getIntent();
        String username = intent.getStringExtra("username");
        String name = intent.getStringExtra("name");
        String password = intent.getStringExtra("password");
        String email = intent.getStringExtra("email");
        String phoneNum = intent.getStringExtra("phoneNum");
        userViewModel = new UserViewModel(username, name, password, email, phoneNum);
    }

    @Override
    public void onPointerCaptureChanged(boolean hasCapture) {

    }
}
