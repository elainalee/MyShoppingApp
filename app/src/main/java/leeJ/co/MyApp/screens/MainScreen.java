package leeJ.co.MyApp.screens;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import leeJ.co.MyApp.R;

public class MainScreen extends AppCompatActivity{

    private static final String TAG = LdpScreen.class.getSimpleName();
    private static final String CHANNEL = "my_app/request2";

    Button userProfile_btn, ldpScreen_btn;
    String user_name, user_username, user_phoneNum, user_email, user_password;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_screen);

        // Hooks
        userProfile_btn = findViewById(R.id.mainScreen_user_profile_button);
        ldpScreen_btn = findViewById(R.id.mainScreen_ldp_button);

        setUserInfo();


//        /// - flutter
        // Instantiate a FlutterEngine.
                FlutterEngine flutterEngine = new FlutterEngine(this);
                // Configure an initial route.
                flutterEngine.getNavigationChannel().setInitialRoute("/second");
                // Start executing Dart code to pre-warm the FlutterEngine.
                flutterEngine.getDartExecutor().executeDartEntrypoint(
                        DartExecutor.DartEntrypoint.createDefault()
                );
                // Cache the FlutterEngine to be used by FlutterActivity or FlutterFragment.
                FlutterEngineCache
                        .getInstance()
                        .put("my_engine_id", flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor(), CHANNEL).setMethodCallHandler(
                ((call, result) -> {
                    if (call.method.equals("getUsername")) {
                        String username = "placeholder for username";
                        result.success(username);
                    } else {
                        result.notImplemented();
                    }
                })
        );
//        /// - flutter


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
                startActivity(FlutterActivity.withCachedEngine("my_engine_id").build(MainScreen.this));
//                startActivity(
//                        FlutterActivity
//                                .withNewEngine()
//                                .initialRoute("/second")
//                                .build(MainScreen.this)
//                );
            }

//            @Override
//            public void onClick(View view) {
//                navigateToLdp();
//            }

            private void navigateToLdp() {
                Intent intent = new Intent(getApplicationContext(), LdpScreen.class);
                startActivity(intent);
            }

        });

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
