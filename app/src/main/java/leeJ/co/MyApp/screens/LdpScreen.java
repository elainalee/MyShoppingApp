package leeJ.co.MyApp.screens;

import androidx.annotation.NonNull;

import android.content.Context;
import android.os.Bundle;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class LdpScreen extends FlutterActivity {

    private static final String TAG = LdpScreen.class.getSimpleName();
    private static final String CHANNEL = "my_app/request2";


    @Override
    public FlutterEngine provideFlutterEngine(Context context) {
        Log.d(TAG, "provideFlutterEngine: ");
        FlutterEngine flutterEngine = FlutterEngineCache.getInstance().get("my_engine_id");
        return flutterEngine;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.d(TAG, "onCreate: ");
        super.onCreate(savedInstanceState);
        //
//        FlutterEngine flutterEngine = new FlutterEngine(this);
//        // Configure an initial route.
//        flutterEngine.getNavigationChannel().setInitialRoute("/second");
//        // Start executing Dart code to pre-warm the FlutterEngine.
//        flutterEngine.getDartExecutor().executeDartEntrypoint(
//                DartExecutor.DartEntrypoint.createDefault()
//        );
//        // Cache the FlutterEngine to be used by FlutterActivity or FlutterFragment.
//        FlutterEngineCache
//                .getInstance()
//                .put("my_engine_id", flutterEngine);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        Log.d(TAG, "configureFlutterEngine: ");
        GeneratedPluginRegistrant.registerWith(flutterEngine);

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

    }
}
