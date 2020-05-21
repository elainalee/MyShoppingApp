package leeJ.co.MyApp;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.google.android.material.textfield.TextInputLayout;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class SignUp extends AppCompatActivity {

    // Variables
    TextInputLayout regName, regUserName, regEmail, regPhoneNum, regPassword;
    Button regButton, regToLogInButton;

    FirebaseDatabase rootNode;
    DatabaseReference reference;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_up);
        // Hooks
        regName = findViewById(R.id.signUp_full_name_field);
        regUserName = findViewById(R.id.signUp_username_field);
        regEmail = findViewById(R.id.signUp_email_field);
        regPhoneNum = findViewById(R.id.signUp_phone_num_field);
        regPassword = findViewById(R.id.signUp_password_field);
        regButton = findViewById(R.id.signUp_go_button);
        regToLogInButton =findViewById(R.id.signUp_log_in_button);

        // Save data in FireBase on button click
        regButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                rootNode = FirebaseDatabase.getInstance();
                reference = rootNode.getReference("users");

                // Get all the values
                String name = regName.getEditText().getText().toString();
                String username = regUserName.getEditText().getText().toString();
                String email = regEmail.getEditText().getText().toString();
                String phoneNum = regPhoneNum.getEditText().getText().toString();
                String password = regPassword.getEditText().getText().toString();

                UserHelperClass helperClass = new UserHelperClass(name, username, email, phoneNum, password);

                reference.child(username).setValue(helperClass);

            }
        });
    }

    private Boolean validateUsername() {
        String val = regUserName.getEditText().getText().toString();
        String noWhiteSpace = "\\A\\w{4,20}\\z";

        if (val.isEmpty()) {
            regUserName.setError("Field cannot be empty");
            return false;
        } else if (val.length() >= 15) {
            regUserName.setError("Username too long");
            return false;
        } else if (!val.matches(noWhiteSpace)) {
            regUserName.setError("White spaces are not allowed");
            return false;
        } else {
            regUserName.setError(null);
            regUserName.setErrorEnabled(false);
            return true;
        }
    }
}
