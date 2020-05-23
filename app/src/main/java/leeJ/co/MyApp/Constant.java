package leeJ.co.MyApp;

import androidx.appcompat.app.AppCompatActivity;

import java.util.Timer;
import java.util.TimerTask;

public class Constant {

    static int closeTime = 500;

    static public void finishAfter(final AppCompatActivity activity, final int delayTime) {
        new Timer().schedule(new TimerTask() {
            @Override
            public void run() {
                activity.finish();
            }
        }, delayTime);
    }
}
