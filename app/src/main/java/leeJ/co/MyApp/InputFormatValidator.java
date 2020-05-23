package leeJ.co.MyApp;

import com.google.android.material.textfield.TextInputLayout;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class InputFormatValidator {

    private Pattern namePattern, userPattern, emailPattern, phoneNumPattern, passwordPattern;
    private Matcher matcher;

    private static final String NAME_PATTERN = "[a-zA-Z]+(\\s[a-zA-Z]+)?";
    private static final String USERNAME_PATTERN = "[a-zA-Z0-9_]+";
    private static final String EMAIL_PATTERN = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
    private static final String PHONE_NUM_PATTERN = "[0-9-+]+";
    private static final String PASSWORD_NUM_PATTERN = "\\S+";

//    String passwordVal = "^" +
//            //"(?=.*[0-9])" +         //at least 1 digit
//            //"(?=.*[a-z])" +         //at least 1 lower case letter
//            //"(?=.*[A-Z])" +         //at least 1 upper case letter
//            "(?=.*[a-zA-Z])" +      //any letter
//            "(?=.*[@#$%^&+=])" +    //at least 1 special character
//            "(?=\\S+$)" +           //no white spaces
//            ".{4,}" +               //at least 4 characters
//            "$";


    public InputFormatValidator(){
        namePattern = Pattern.compile(NAME_PATTERN);
        userPattern = Pattern.compile(USERNAME_PATTERN);
        emailPattern = Pattern.compile(EMAIL_PATTERN);
        phoneNumPattern = Pattern.compile(PHONE_NUM_PATTERN);
        passwordPattern = Pattern.compile(PASSWORD_NUM_PATTERN);
    }


    public Boolean validateRegName(TextInputLayout fullNameField) {
        String val = fullNameField.getEditText().getText().toString();

        if (val.isEmpty()) {
            fullNameField.setError("Field cannot be empty");
            return false;
        } else if (val.length() >= 25) {
            fullNameField.setError("Name too long");
            return false;
        } else if (!(matchesNameFormat(val))) {
            fullNameField.setError("Special characters/Numbers are not allowed");
            return false;
        } else {
            fullNameField.setError(null);
            fullNameField.setErrorEnabled(false);
            return true;
        }
    }

    public boolean matchesNameFormat(final String name) {
        matcher = namePattern.matcher(name);
        return matcher.matches();
    }

    public Boolean validateRegUsername(TextInputLayout usernameField) {
        String val = usernameField.getEditText().getText().toString();

        if (val.isEmpty()) {
            usernameField.setError("Field cannot be empty");
            return false;
        } else if (!(matchesUsernameFormat(val))) {
            usernameField.setError("Special characters are not allowed");
            return false;
        } else if (val.length() < 5) {
            usernameField.setError("Username has to be longer than 5 digits");
            return false;
        } else if (val.length() >= 15) {
            usernameField.setError("Username too long");
            return false;
        } else {
            usernameField.setError(null);
            usernameField.setErrorEnabled(false);
            return true;
        }
    }

    public boolean matchesUsernameFormat(final String username) {
        matcher = userPattern.matcher(username);
        return matcher.matches();
    }

    public Boolean validateRegEmail(TextInputLayout emailField) {
        String val = emailField.getEditText().getText().toString();

        if (val.isEmpty()) {
            emailField.setError("Field cannot be empty");
            return false;
        }else if (!(matchesEmailFormat(val))) {
            emailField.setError("Invalid email address");
            return false;
        } else {
            emailField.setError(null);
            emailField.setErrorEnabled(false);
            return true;
        }
    }


    public boolean matchesEmailFormat(final String email) {
        matcher = emailPattern.matcher(email);
        return matcher.matches();
    }

    public Boolean validatePhoneNum(TextInputLayout phoneNumField) {
        String val = phoneNumField.getEditText().getText().toString();

        if (val.isEmpty()) {
            phoneNumField.setError("Field cannot be empty");
            return false;
        } else if (val.length() < 9) {
            phoneNumField.setError("Phone number too short");
            return false;
        } else if (val.length() >= 18) {
            phoneNumField.setError("Phone number too long");
            return false;
        } else if (!(matchesPhoneNumFormat(val))) {
            phoneNumField.setError("Invalid phone number");
            return false;
        } else {
            phoneNumField.setError(null);
            phoneNumField.setErrorEnabled(false);
            return true;
        }
    }

    public boolean matchesPhoneNumFormat(final String phoneNum) {
        matcher = phoneNumPattern.matcher(phoneNum);
        return matcher.matches();
    }

    public Boolean validatePassword(TextInputLayout passwordField) {
        String val = passwordField.getEditText().getText().toString();

        if (val.isEmpty()) {
            passwordField.setError("Field cannot be empty");
            return false;
        } else if (val.length() < 3) {
            passwordField.setError("Password too short");
            return false;
        } else if (!(matchesPasswordFormat(val))) {
            // this not implemented yet
            passwordField.setError("Password is too weak");
            return false;
        }
        else {
            passwordField.setError(null);
            passwordField.setErrorEnabled(false);
            return true;
        }
    }

    public boolean matchesPasswordFormat(final String password) {
        matcher = passwordPattern.matcher(password);
        return matcher.matches();
    }
}