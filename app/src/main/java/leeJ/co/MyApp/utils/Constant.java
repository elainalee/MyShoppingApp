package leeJ.co.MyApp.utils;

import androidx.appcompat.app.AppCompatActivity;

import java.util.Timer;
import java.util.TimerTask;

public class Constant {

    public static int closeTime = 300;

    static public void finishAfter(final AppCompatActivity activity, final int delayTime) {
        new Timer().schedule(new TimerTask() {
            @Override
            public void run() {
                activity.finish();
            }
        }, delayTime);
    }
}
