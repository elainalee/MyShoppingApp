package leeJ.co.MyApp;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.android.material.textfield.TextInputLayout;

public class UserProfile extends AppCompatActivity {

    ImageView profileImage;
    TextInputLayout fullNameField, emailField, phoneNumField, passwordField;
    TextView fullNameLabel, usernameLabel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_user_profile);

        // Hooks
        fullNameField = findViewById(R.id.userProfile_full_name_field);
        emailField = findViewById(R.id.userProfile_email_field);
        phoneNumField = findViewById(R.id.userProfile_phone_num_field);
        passwordField = findViewById(R.id.userProfile_password_field);

        profileImage = findViewById(R.id.userProfile_profile_image);
        fullNameLabel = findViewById(R.id.userProfile_full_name_label);
        usernameLabel = findViewById(R.id.userProfile_username_label);

        // Show All of the User's Data
        showAllUserData();
    }

    private void showAllUserData() {
        Intent intent = getIntent();
        String user_username = intent.getStringExtra("username");
        String user_name = intent.getStringExtra("name");
        String user_email = intent.getStringExtra("email");
        String user_phoneNum = intent.getStringExtra("phoneNum");
        String user_password = intent.getStringExtra("password");

        fullNameLabel.setText(user_name);
        usernameLabel.setText(user_username);
        fullNameField.getEditText().setText(user_name);
        emailField.getEditText().setText(user_email);
        phoneNumField.getEditText().setText(user_phoneNum);
        passwordField.getEditText().setText(user_password);
    }
}
