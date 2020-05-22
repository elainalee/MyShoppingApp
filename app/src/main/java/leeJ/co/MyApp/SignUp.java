package leeJ.co.MyApp;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.google.android.material.textfield.TextInputLayout;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import java.util.regex.Pattern;

public class SignUp extends AppCompatActivity {

    private InputFormatValidator inputFormatValidator = new InputFormatValidator();
    Pattern namePattern = Pattern.compile("[A-Za-z0-9_]");

    // Variables
    TextInputLayout fullNameField, usernameField, emailField, phoneNumField, passwordField;
    Button regButton, regToLogInButton;

    FirebaseDatabase rootNode;
    DatabaseReference reference;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_up);
        // Hooks
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
    }

    //This function will execute when user click on Register Button
    public void registerUser(View view) {
        if(!validateName() | !validateUsername() |!validatePassword() | !validatePhoneNum() | !validateEmail()) {
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

    private Boolean validateName() {
        String val = fullNameField.getEditText().getText().toString();

        if (val.isEmpty()) {
            fullNameField.setError("Field cannot be empty");
            return false;
        } else if (val.length() >= 25) {
            fullNameField.setError("Name too long");
            return false;
        } else if (!(inputFormatValidator.validateName(val))) {
            fullNameField.setError("Special characters/Numbers are not allowed");
            return false;
        } else {
            fullNameField.setError(null);
            fullNameField.setErrorEnabled(false);
            return true;
        }
    }

    private Boolean validateUsername() {
        String val = usernameField.getEditText().getText().toString();

        if (val.isEmpty()) {
            usernameField.setError("Field cannot be empty");
            return false;
        }
        //
//        if (inputFormatValidator.validateUsername(val)) {
//            System.out.println("SIGNUP-TEST: username matches the pattern");
//        } else {
//            System.out.println("SIGNUP-TEST: username doesn't match the pattern");
//        }
        // else


//        if (!(inputFormatValidator.validateUsername(val))) {
//
//            if (inputFormatValidator.validateUsername(val)) {
//                System.out.println("SIGNUP-TEST: username matches the pattern");
//            } else {
//                System.out.println("SIGNUP-TEST: username doesn't match the pattern");
//            }


//            usernameField.setError("Special characters are not allowed");
//            return false;
//        } else if (val.length() >= 15) {
//            usernameField.setError("Username too long");
//            return false;
//        }
        else {
            usernameField.setError(null);
            usernameField.setErrorEnabled(false);
            return true;
        }
    }

    private Boolean validateEmail() {
        String val = emailField.getEditText().getText().toString();

        if (val.isEmpty()) {
            emailField.setError("Field cannot be empty");
            return false;
        }
//        else if (!(inputFormatValidator.validateEmail(val))) {
//            emailField.setError("Invalid email address");
//            return false;
//        }
        else {
            emailField.setError(null);
            emailField.setErrorEnabled(false);
            return true;
        }
    }

    private Boolean validatePhoneNum() {
        String val = phoneNumField.getEditText().getText().toString();

        if (val.isEmpty()) {
            phoneNumField.setError("Field cannot be empty");
            return false;
        }
//        else if (!(inputFormatValidator.validatePhoneNum(val))) {
//            phoneNumField.setError("Invalid phone number");
//            return false;
//        }
        else {
            phoneNumField.setError(null);
            phoneNumField.setErrorEnabled(false);
            return true;
        }
    }

    String passwordVal = "^" +
            //"(?=.*[0-9])" +         //at least 1 digit
            //"(?=.*[a-z])" +         //at least 1 lower case letter
            //"(?=.*[A-Z])" +         //at least 1 upper case letter
            "(?=.*[a-zA-Z])" +      //any letter
            "(?=.*[@#$%^&+=])" +    //at least 1 special character
            "(?=\\S+$)" +           //no white spaces
            ".{4,}" +               //at least 4 characters
            "$";

    private Boolean validatePassword() {
        String val = passwordField.getEditText().getText().toString();
        String passwordVal = "^" +
                //"(?=.*[0-9])" +         //at least 1 digit
                //"(?=.*[a-z])" +         //at least 1 lower case letter
                //"(?=.*[A-Z])" +         //at least 1 upper case letter
                "(?=.*[a-zA-Z])" +      //any letter
                "(?=.*[@#$%^&+=])" +    //at least 1 special character
                "(?=\\S+$)" +           //no white spaces
                ".{4,}" +               //at least 4 characters
                "$";

        if (val.isEmpty()) {
            passwordField.setError("Field cannot be empty");
            return false;
        }
//        else if (!val.matches(passwordVal)) {
//            passwordField.setError("Password is too weak");
//            return false;
//        }
        else {
            passwordField.setError(null);
            passwordField.setErrorEnabled(false);
            return true;
        }
    }


}
