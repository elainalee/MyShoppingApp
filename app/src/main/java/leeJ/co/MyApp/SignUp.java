package leeJ.co.MyApp;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ActivityOptions;
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

import java.util.regex.Pattern;

public class SignUp extends AppCompatActivity {

    private InputFormatValidator inputFormatValidator = new InputFormatValidator();

    // Variables
    TextInputLayout fullNameField, usernameField, emailField, phoneNumField, passwordField;
    Button regButton, regToLogInButton;
    ImageView logoImage;
    TextView logoText;

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
        });

        regToLogInButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(SignUp.this, LogIn.class);
                Pair[] pairs = new Pair[2];
                pairs[0] = new Pair<View,String> (logoImage, "logo_image_trans");
                pairs[1] = new Pair<View,String> (logoText, "logo_text_trans");
                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                    ActivityOptions options = ActivityOptions.makeSceneTransitionAnimation(SignUp.this, pairs);
                    startActivity(intent, options.toBundle());
                }

            }
        });
    }

    //This function will execute when user click on Register Button
    public void registerUser(View view) {
        if(!inputFormatValidator.validateRegName(fullNameField) | !inputFormatValidator.validateRegUsername(usernameField) |
                !inputFormatValidator.validateRegEmail(emailField) | !inputFormatValidator.validatePhoneNum(phoneNumField) |
                !inputFormatValidator.validatePassword(passwordField)) {
            return;
        } else {
            SignUpUser();
        }
    }

    private void SignUpUser() {
        rootNode = FirebaseDatabase.getInstance();
        reference = rootNode.getReference("users");

        // Get all the values
        String name = fullNameField.getEditText().getText().toString();
        String username = usernameField.getEditText().getText().toString();
        String email = emailField.getEditText().getText().toString();
        String phoneNum = phoneNumField.getEditText().getText().toString();
        String password = passwordField.getEditText().getText().toString();

        UserHelperClass helperClass = new UserHelperClass(name, username, email, phoneNum, password);

        reference.child(username).setValue(helperClass);
    }
}
