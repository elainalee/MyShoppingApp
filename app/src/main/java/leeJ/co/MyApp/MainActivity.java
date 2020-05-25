package leeJ.co.MyApp;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ActivityOptions;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.util.Pair;
import android.view.View;
import android.view.WindowManager;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.Timer;
import java.util.TimerTask;

import io.flutter.app.FlutterApplication;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;


public class MainActivity extends AppCompatActivity {

    // screen changing time limit
    private static int SPLASH_SCREEN = 1100;

    //Variables
    Animation topAnim, bottomAnim;
    ImageView logoImage;
    TextView logoText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // ----- flutter start ----
//        setContentView(R.layout.activity_main);
//
//        startActivity(FlutterActivity.createDefaultIntent(this));
//
//
//         ----- flutter end ----


        // hiding the top appBar and making the app full screen
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_main);

        // Animations
        topAnim = AnimationUtils.loadAnimation(this, R.anim.top_animation);
        bottomAnim = AnimationUtils.loadAnimation(this, R.anim.bottom_animation);

        // Hooks
        logoImage = findViewById(R.id.sign_up_logo);
        logoText = findViewById(R.id.textView);

        logoImage.setAnimation(topAnim);
        logoText.setAnimation(bottomAnim);

        // MainActivity to LogIn screen with animation
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(MainActivity.this, LogIn.class);

                // change to the next screen w/ no animation
                //      startActivity(intent);
                //      finish();

                // this is the version with the inputted animation
                Pair[] pairs = new Pair[2];
                pairs[0] = new Pair<View,String> (logoImage, "logo_image_trans");
                pairs[1] = new Pair<View,String> (logoText, "logo_text_trans");
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                    ActivityOptions options = ActivityOptions.makeSceneTransitionAnimation(MainActivity.this, pairs);
                    startActivity(intent, options.toBundle());
                }
            }
        }, SPLASH_SCREEN);

        Constant.finishAfter(this, SPLASH_SCREEN + Constant.closeTime);
    }
}
