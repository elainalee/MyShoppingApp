package leeJ.co.MyApp.screens;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import leeJ.co.MyApp.R;

public class MainScreen extends AppCompatActivity {

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
            public void onClick(View view) {
                navigateToLdp();
            }

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
}
