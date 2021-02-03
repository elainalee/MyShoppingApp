package leeJ.co.MyApp.utils;

import android.content.Context;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;

public final class FlutterIntegrator {
    public static final String ENGINE_NAME = "my_engine_id";
    public static final String CHANNEL = "my_app/request";
    public static final String LDP_FLUTTER_ROUTE = "/lead_to_ldp";

    private static String curListingID = "";


    public final static String getCurListingID() {
        return curListingID;
    }

    public final static void setCurListingID(String newListingID) {
        curListingID = newListingID;
    }

    public static final void setFlutterEngine(String user_username, String user_password, Context context) {
        // Instantiate a FlutterEngine.
        FlutterEngine flutterEngine = new FlutterEngine(context);
        // Configure an initial route.
        flutterEngine.getNavigationChannel().setInitialRoute(FlutterIntegrator.LDP_FLUTTER_ROUTE);
        // Start executing Dart code to pre-warm the FlutterEngine.
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );
        // Cache the FlutterEngine to be used by FlutterActivity or FlutterFragment.
        FlutterEngineCache
                .getInstance()
                .put(FlutterIntegrator.ENGINE_NAME, flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor(), FlutterIntegrator.CHANNEL).setMethodCallHandler(
                ((call, result) -> {
                    if (call.method.equals("getUsername")) {
                        result.success(user_username);
                    } else if (call.method.equals("getPassword")) {
                        result.success(user_password);
                    } else if (call.method.equals("getListingID")) {
                        result.success(FlutterIntegrator.getCurListingID());
                    } else {
                        result.notImplemented();
                    }
                })
        );
    }
}
