package leeJ.co.MyApp;

import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.android.material.textfield.TextInputLayout;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class UserProfile extends AppCompatActivity {

    private InputFormatValidator inputFormatValidator = new InputFormatValidator();


    ImageView profileImage;
    TextInputLayout fullNameField, emailField, phoneNumField, passwordField;
    TextView fullNameLabel, usernameLabel;
    Button updateButton;

    // Firebase setup
    FirebaseDatabase rootNode;
    DatabaseReference reference;

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

        updateButton = findViewById(R.id.userProfile_update_button);

        // Show All of the User's Data
        showAllUserData();

        updateButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                updateUserInfo();
                informUser();
            }

            private void updateUserInfo() {
                if(!inputFormatValidator.validateRegName(fullNameField) | !inputFormatValidator.validateRegEmail(emailField)
                        | !inputFormatValidator.validatePhoneNum(phoneNumField) | !inputFormatValidator.validatePassword(passwordField)) {
                    return;
                } else {
                    _updateUserInfo();
                }
            }
        });
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

    private void _updateUserInfo() {
        rootNode = FirebaseDatabase.getInstance();
        reference = rootNode.getReference("users");

        // Get all the values
        String username = usernameLabel.getText().toString();
        String name = fullNameField.getEditText().getText().toString();
        String email = emailField.getEditText().getText().toString();
        String phoneNum = phoneNumField.getEditText().getText().toString();
        String password = passwordField.getEditText().getText().toString();

        UserHelperClass helperClass = new UserHelperClass(name, username, email, phoneNum, password);

        reference.child(username).setValue(helperClass);
    }

    private void informUser() {
        AlertDialog.Builder builder1 = new AlertDialog.Builder(this);
        builder1.setMessage("Your information is updated");
        builder1.setCancelable(true);

        builder1.setPositiveButton(
                "OK",
                new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        dialog.cancel();
                    }
                });

        AlertDialog alert11 = builder1.create();
        alert11.show();
    }



}
