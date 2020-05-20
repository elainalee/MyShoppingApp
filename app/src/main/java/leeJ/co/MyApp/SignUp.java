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
                rootNode = FirebaseDatabase.getInstance();
                reference = rootNode.getReference("users");

                // Get all the values
                String name = regName.getEditText().getText().toString();
                String username = regUserName.getEditText().getText().toString();
                String email = regEmail.getEditText().getText().toString();
                String phoneNum = regPhoneNum.getEditText().getText().toString();
                String password = regPassword.getEditText().getText().toString();

                UserHelperClass helperClass = new UserHelperClass(name, username, email, phoneNum, password);

                reference.child(phoneNum).setValue(helperClass);

            }
        });

    }
}
