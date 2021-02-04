package leeJ.co.MyApp.screens;

import android.app.ActivityOptions;
import android.content.Intent;
import android.os.Bundle;
import android.util.Pair;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.google.android.material.textfield.TextInputLayout;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;
import com.google.firebase.database.ValueEventListener;

import leeJ.co.MyApp.*;
import leeJ.co.MyApp.utils.Constant;
import leeJ.co.MyApp.utils.DB_Constants;
import leeJ.co.MyApp.utils.SmpIntegrator;

public class LogInScreen extends AppCompatActivity {

    Button logIn_btn, callSignUp;
    CheckBox isSeller_checkBox;
    ImageView logoImage;
    TextView logoText;
    TextInputLayout usernameField, passwordField;

    boolean isSeller = false;

    // Firebase setup
    DatabaseReference reference;
    Query checkUser;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // hiding the top appBar and making the app full screen
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_log_in);

        // Hooks
        isSeller_checkBox = findViewById(R.id.logIn_isSeller_button);
        logIn_btn = findViewById(R.id.logIn_go_button);
        callSignUp = findViewById(R.id.logIn_sign_up_button);
        logoImage = findViewById(R.id.sign_up_logo);
        logoText = findViewById(R.id.sign_up_hello);
        usernameField = findViewById(R.id.logIn_username_field);
        passwordField = findViewById(R.id.logIn_password_field);

        SmpIntegrator.setFlutterEngine(this);

        isSeller_checkBox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {

           @Override
           public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
               if (isChecked) {
                   isSeller = true;
               } else {
                   isSeller = false;
               }
           }
        });


        // when the GO button is pressed, connect to firebase and vertify info
        logIn_btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                logIn();
            }

            private void logIn() {
                if (!validateUsername() | !validatePassword()) {
                    return;
                } else {
                    if (isSeller) {
                        logInSeller();
                    } else {
                        logInUser();
                    }
                }
            }
        });

        // when sign up button is pressed, move to signup screen with animation effects
        callSignUp.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                Intent intent = new Intent(LogInScreen.this, SignUpScreen.class);

                Pair[] pairs = new Pair[2];
                pairs[0] = new Pair<View,String> (logoImage, "logo_image_trans");
                pairs[1] = new Pair<View,String> (logoText, "logo_text_trans");

                if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                    ActivityOptions options = ActivityOptions.makeSceneTransitionAnimation(LogInScreen.this, pairs);
                    startActivity(intent, options.toBundle());
                }
                Constant.finishAfter(LogInScreen.this,  Constant.closeTime);
            }
        });

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

    private void logInSeller() {
        final String userEnteredID = usernameField.getEditText().getText().toString().trim();
        final String userEnteredPW = passwordField.getEditText().getText().toString().trim();

        reference = FirebaseDatabase.getInstance().getReference(DB_Constants.SELLER_TABLE);

        checkUser = reference.orderByChild(DB_Constants.SID).equalTo(userEnteredID);

        checkUser.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                if (dataSnapshot.exists()) {

                    usernameField.setError(null);
                    usernameField.setErrorEnabled(false);

                    String passwordFromDB = dataSnapshot.child(userEnteredID).child(DB_Constants.PW).getValue(String.class);

                    if (passwordFromDB.equals(userEnteredPW)) {

                        usernameField.setError(null);
                        usernameField.setErrorEnabled(false);

                        SmpIntegrator.setSellerInfo(userEnteredID, userEnteredPW);
                        SmpIntegrator.navigateToFlutter(LogInScreen.this);

//                        // closes log in screen
                        Constant.finishAfter(LogInScreen.this, Constant.closeTime);
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

    private void logInUser() {

        final String userEnteredUsername = usernameField.getEditText().getText().toString().trim();
        final String userEnteredPassword = passwordField.getEditText().getText().toString().trim();

        reference = FirebaseDatabase.getInstance().getReference(DB_Constants.USERS_TABLE);

        checkUser = reference.orderByChild(DB_Constants.UID).equalTo(userEnteredUsername);

        checkUser.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                if (dataSnapshot.exists()) {

                    usernameField.setError(null);
                    usernameField.setErrorEnabled(false);

                    String passwordFromDB = dataSnapshot.child(userEnteredUsername).child(DB_Constants.PW).getValue(String.class);

                    if (passwordFromDB.equals(userEnteredPassword)) {

                        usernameField.setError(null);
                        usernameField.setErrorEnabled(false);

                        String nameFromDB = dataSnapshot.child(userEnteredUsername).child("name").getValue(String.class);
                        String usernameFromDB = dataSnapshot.child(userEnteredUsername).child("username").getValue(String.class);
                        String phoneNumFromDB = dataSnapshot.child(userEnteredUsername).child("phoneNum").getValue(String.class);
                        String emailFromDB = dataSnapshot.child(userEnteredUsername).child("email").getValue(String.class);

                        Intent intent = new Intent(getApplicationContext(), MainScreen.class);

                        intent.putExtra("name", nameFromDB);
                        intent.putExtra("username", usernameFromDB);
                        intent.putExtra("phoneNum", phoneNumFromDB);
                        intent.putExtra("email", emailFromDB);
                        intent.putExtra("password", passwordFromDB);

                        startActivity(intent);

                        // closes log in screen
                        Constant.finishAfter(LogInScreen.this, Constant.closeTime);
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
