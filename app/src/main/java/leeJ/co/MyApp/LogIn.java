package leeJ.co.MyApp;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.app.ActivityOptions;
import android.content.Intent;
import android.os.Bundle;
import android.util.Pair;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.android.material.textfield.TextInputLayout;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;
import com.google.firebase.database.ValueEventListener;

public class LogIn extends AppCompatActivity {

    Button logIn_btn, callSignUp;
    ImageView logoImage;
    TextView logoText;
    TextInputLayout usernameField, passwordField;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // hiding the top appBar and making the app full screen
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_log_in);

        // Hooks
        logIn_btn = findViewById(R.id.logIn_go_button);
        callSignUp = findViewById(R.id.logIn_sign_up_button);
        logoImage = findViewById(R.id.sign_up_logo);
        logoText = findViewById(R.id.sign_up_hello);
        usernameField = findViewById(R.id.logIn_username_field);
        passwordField = findViewById(R.id.logIn_password_field);

        // when the GO button is pressed, connect to firebase and vertify info
        logIn_btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                logInUser(view);
            }
        });

        // when sign up button is pressed, move to signup screen with animation effects
        callSignUp.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                Intent intent = new Intent(LogIn.this, SignUp.class);

                Pair[] pairs = new Pair[2];
                pairs[0] = new Pair<View,String> (logoImage, "logo_image_trans");
                pairs[1] = new Pair<View,String> (logoText, "logo_text_trans");

                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                    ActivityOptions options = ActivityOptions.makeSceneTransitionAnimation(LogIn.this, pairs);
                    startActivity(intent, options.toBundle());
                }
            }
        });

    }

    public void logInUser(View view) {
        //Validate Login Info
        if (!validateUsername() | !validatePassword()) {
            return;
        } else {
            isUser();
        }
    }

    private Boolean validateUsername() {
        String val = usernameField.getEditText().getText().toString();

        if (val.isEmpty()) {
            usernameField.setError("Field cannot be empty");
            return false;
        } else {
            usernameField.setError(null);
            usernameField.setErrorEnabled(false);
            return true;
        }
    }

    private Boolean validatePassword() {
        String val = passwordField.getEditText().getText().toString();
        if (val.isEmpty()) {
            passwordField.setError("Field cannot be empty");
            return false;
        } else {
            passwordField.setError(null);
            passwordField.setErrorEnabled(false);
            return true;
        }
    }

    private void isUser() {

        final String userEnteredUsername = usernameField.getEditText().getText().toString().trim();
        final String userEnteredPassword = passwordField.getEditText().getText().toString().trim();

        DatabaseReference reference = FirebaseDatabase.getInstance().getReference("users");

        Query checkUser = reference.orderByChild("username").equalTo(userEnteredUsername);

        checkUser.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                if (dataSnapshot.exists()) {

                    usernameField.setError(null);
                    usernameField.setErrorEnabled(false);

                    String passwordFromDB = dataSnapshot.child(userEnteredUsername).child("password").getValue(String.class);

                    if (passwordFromDB.equals(userEnteredPassword)) {

                        usernameField.setError(null);
                        usernameField.setErrorEnabled(false);

                        String nameFromDB = dataSnapshot.child(userEnteredUsername).child("name").getValue(String.class);
                        String usernameFromDB = dataSnapshot.child(userEnteredUsername).child("username").getValue(String.class);
                        String phoneNumFromDB = dataSnapshot.child(userEnteredUsername).child("phoneNum").getValue(String.class);
                        String emailFromDB = dataSnapshot.child(userEnteredUsername).child("email").getValue(String.class);

                        Intent intent = new Intent(getApplicationContext(), UserProfile.class);

                        intent.putExtra("name", nameFromDB);
                        intent.putExtra("username", usernameFromDB);
                        intent.putExtra("phoneNum", phoneNumFromDB);
                        intent.putExtra("email", emailFromDB);
                        intent.putExtra("password", passwordFromDB);

                        startActivity(intent);
                    }
                    else {
                        passwordField.setError("Wrong Password");
                        passwordField.requestFocus();
                    }
                }
                else {
                    usernameField.setError("No such user exists");
                    usernameField.requestFocus();
                }
            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        });
    }


}
