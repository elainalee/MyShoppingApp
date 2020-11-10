package leeJ.co.MyApp.screens;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ActivityOptions;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.util.Pair;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.android.material.textfield.TextInputLayout;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import leeJ.co.MyApp.MyAppUser;
import leeJ.co.MyApp.utils.Constant;
import leeJ.co.MyApp.R;
import leeJ.co.MyApp.utils.InputFormatValidator;

public class SignUpScreen extends AppCompatActivity {

    private InputFormatValidator inputFormatValidator = new InputFormatValidator();

    // Variables
    TextInputLayout fullNameField, usernameField, emailField, phoneNumField, passwordField;
    Button regButton, regToLogInButton;
    ImageView logoImage;
    TextView logoText;

    // Firebase setup
    FirebaseDatabase rootNode;
    DatabaseReference reference;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_up);

        // Hooks
        logoImage = findViewById(R.id.sign_up_logo);
        logoText = findViewById(R.id.sign_up_hello);
        fullNameField = findViewById(R.id.signUp_full_name_field);
        usernameField = findViewById(R.id.signUp_username_field);
        emailField = findViewById(R.id.signUp_email_field);
        phoneNumField = findViewById(R.id.signUp_phone_num_field);
        passwordField = findViewById(R.id.signUp_password_field);
        regButton = findViewById(R.id.signUp_go_button);
        regToLogInButton =findViewById(R.id.signUp_log_in_button);

        // Save data in FireBase on button click
        regButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                registerUser(view);
            }

            private void registerUser(View view) {
                if(!inputFormatValidator.validateRegName(fullNameField) | !inputFormatValidator.validateRegUsername(usernameField) |
                        !inputFormatValidator.validateRegEmail(emailField) | !inputFormatValidator.validatePhoneNum(phoneNumField) |
                        !inputFormatValidator.validatePassword(passwordField)) {
                    return;
                } else {
                    _registerUser();
                    informUser();
                }
            }
        });

        regToLogInButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(SignUpScreen.this, LogInScreen.class);
                Pair[] pairs = new Pair[2];
                pairs[0] = new Pair<View,String> (logoImage, "logo_image_trans");
                pairs[1] = new Pair<View,String> (logoText, "logo_text_trans");
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                    ActivityOptions options = ActivityOptions.makeSceneTransitionAnimation(SignUpScreen.this, pairs);
                    startActivity(intent, options.toBundle());
                }
                finish();
                Constant.finishAfter(SignUpScreen.this,  Constant.closeTime);
            }
        });
    }

    private void _registerUser() {
        rootNode = FirebaseDatabase.getInstance();
        reference = rootNode.getReference("users");

        // Get all the values
        String name = fullNameField.getEditText().getText().toString();
        String username = usernameField.getEditText().getText().toString();
        String email = emailField.getEditText().getText().toString();
        String phoneNum = phoneNumField.getEditText().getText().toString();
        String password = passwordField.getEditText().getText().toString();

        MyAppUser myAppUser = new MyAppUser(name, username, email, phoneNum, password);

        reference.child(username).setValue(myAppUser);
    }

    private void informUser() {
        AlertDialog.Builder builder1 = new AlertDialog.Builder(this);
        builder1.setMessage("You successfully signed up. Please log in.");
        builder1.setCancelable(true);

        builder1.setPositiveButton(
                "OK",
                new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        dialog.cancel();
                        navigateToLogIn();
                    }
                });

        AlertDialog alert11 = builder1.create();
        alert11.show();
    }

    private void navigateToLogIn() {
        Intent intent = new Intent(SignUpScreen.this, LogInScreen.class);
        // change to the next screen w/ no animation
              startActivity(intent);
        Constant.finishAfter(SignUpScreen.this,  Constant.closeTime);
    }
}
