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
import java.util.List;
import java.util.function.Consumer;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;
import leeJ.co.MyApp.R;
import leeJ.co.MyApp.models.ItemViewModel;
import leeJ.co.MyApp.utils.ItemAdapter;

public class MainScreen extends AppCompatActivity {
    private static final String ENGINE_NAME = "my_engine_id";
    private static final String CHANNEL = "my_app/request";
    private static final String LDP_FLUTTER_ROUTE = "/lead_to_ldp";

    //Firebase setup
    DatabaseReference reference;
    Query listingQuery;

    Button userProfile_btn, ldpScreen_btn;
    String user_name, user_username, user_phoneNum, user_email, user_password;
    Toolbar toolBar;
    RecyclerView itemRV;
    ArrayList<ItemViewModel> itemViewModels;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_screen);

        // Hooks
        userProfile_btn = findViewById(R.id.mainScreen_user_profile_button);
        ldpScreen_btn = findViewById(R.id.mainScreen_ldp_button);
        toolBar = findViewById(R.id.main_screen_toolbar);
        itemRV = findViewById(R.id.main_screen_RV);

        setItemListings();

        setUserInfo();

        setSupportActionBar(toolBar);

        setFlutterEngine();


        userProfile_btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                navigateToUserProfile();
            }

            private void navigateToUserProfile() {
                Intent intent = new Intent(getApplicationContext(), UserProfileScreen.class);

                intent.putExtra("name", user_name);
                intent.putExtra("username", user_username);
                intent.putExtra("phoneNum", user_phoneNum);
                intent.putExtra("email", user_email);
                intent.putExtra("password", user_password);

                startActivity(intent);
            }

        });

        ldpScreen_btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                navigateToLdpScreen();
            }

            private void navigateToLdpScreen() {
                startActivity(FlutterActivity.withCachedEngine(ENGINE_NAME).build(MainScreen.this));
            }
        });

    }

    private void setItemListings() {//
        addItemsToList();
        ItemAdapter itemAdapter = new ItemAdapter(this, itemViewModels);
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
                        String itemName = item.child("title").getValue(String.class);
                        String itemDesc = item.child("description").getValue(String.class);
                        double itemPrice = item.child("price").getValue(double.class);
                        itemViewModels.add(new ItemViewModel(itemName, itemDesc, itemPrice, R.drawable.pineapple_default));
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

        //noinspection SimplifiableIfStatement
        if (id == R.id.menu_cart) {
            Toast.makeText(MainScreen.this, "Action clicked - cart", Toast.LENGTH_LONG).show();
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

        intent.putExtra("name", user_name);
        intent.putExtra("username", user_username);
        intent.putExtra("phoneNum", user_phoneNum);
        intent.putExtra("email", user_email);
        intent.putExtra("password", user_password);

        startActivity(intent);
    }

    private void setFlutterEngine() {
        // Instantiate a FlutterEngine.
        FlutterEngine flutterEngine = new FlutterEngine(this);
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
                        result.success(user_username);
                    } else if (call.method.equals("getPassword")) {
                        result.success(user_password);
                    } else if (call.method.equals("getListingID")) {
                        // TODO: implement this hardcoded stub
                        result.success("-MLkrcZq4IO766ZEF9pX");
                    } else {
                        result.notImplemented();
                    }
                })
        );
    }

    private void setUserInfo() {
        Intent intent = getIntent();
        user_username = intent.getStringExtra("username");
        user_name = intent.getStringExtra("name");
        user_email = intent.getStringExtra("email");
        user_phoneNum = intent.getStringExtra("phoneNum");
        user_password = intent.getStringExtra("password");
    }

    @Override
    public void onPointerCaptureChanged(boolean hasCapture) {

    }
}
