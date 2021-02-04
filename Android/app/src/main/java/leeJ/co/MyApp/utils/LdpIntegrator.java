package leeJ.co.MyApp.utils;

import android.content.Context;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;

public class LdpIntegrator implements FlutterIntegrator {

    private static final String ENGINE_NAME = "my_engine_id_ldp";
    private static final String FLUTTER_ROUTE = "/lead_to_ldp";

    private static String curListingID = "";


    static String getCurListingID() {
        return curListingID;
    }

    static void setCurListingID(String newListingID) {
        curListingID = newListingID;
    }

    static void navigateToFlutter(Context context) {
        context.startActivity(FlutterActivity.withCachedEngine(ENGINE_NAME).build(context));
    }


    public static void setFlutterEngine(String user_username, String user_password, Context context) {
        // Instantiate a FlutterEngine.
        FlutterEngine flutterEngine = new FlutterEngine(context);
        // Configure an initial route.
        flutterEngine.getNavigationChannel().setInitialRoute(FLUTTER_ROUTE);
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
                        result.success(LdpIntegrator.getCurListingID());
                    } else {
                        result.notImplemented();
                    }
                })
        );

    }

}
