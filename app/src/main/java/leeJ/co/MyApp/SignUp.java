package leeJ.co.MyApp;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.google.android.material.textfield.TextInputLayout;

public class SignUp extends AppCompatActivity {

    // Variables
    TextInputLayout regName, regUserName, regEmail, regPhoneNum, regPassword;
    Button regButton, regToLogInButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_up);
        // Hooks
        regName = findViewById(R.id.reg_name);
        regUserName = findViewById(R.id.reg_username);
        regEmail = findViewById(R.id.reg_email);
        regPhoneNum = findViewById(R.id.reg_phoneNum);
        regPassword = findViewById(R.id.reg_password);
        regButton = findViewById(R.id.reg_button);
        regToLogInButton =findViewById(R.id.reg_login_button);

        // Save data in FireBase on button click
        regButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });

    }
}
