package leeJ.co.MyApp.utils;

import android.content.Context;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;

public class SmpIntegrator implements FlutterIntegrator {

    private static final String ENGINE_NAME = "my_engine_id_smp";
    private static final String FLUTTER_ROUTE = "/lead_to_smp";

    private static String sellerID;
    private static String sellerPW;

    public static void navigateToFlutter(Context context) {
        context.startActivity(FlutterActivity.withCachedEngine(ENGINE_NAME).build(context));
    }

    public static void setSellerInfo(String sID, String sPW) {
        sellerID = sID;
        sellerPW = sPW;
    }

    public static void setFlutterEngine(Context context) {
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
                    if (call.method.equals("getSellerID")) {
                        result.success(sellerID);
                    } else if (call.method.equals("getSellerPW")) {
                        result.success(sellerPW);
                    } else {
                        result.notImplemented();
                    }
                })
        );
    }
}
