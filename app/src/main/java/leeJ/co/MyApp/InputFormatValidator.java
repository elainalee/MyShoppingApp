package leeJ.co.MyApp;

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

    public boolean validateName(final String name) {
        matcher = namePattern.matcher(name);
        return matcher.matches();
    }

    public boolean validateUsername(final String username) {
        matcher = userPattern.matcher(username);
        return matcher.matches();
    }


    public boolean validateEmail(final String email) {
        matcher = emailPattern.matcher(email);
        return matcher.matches();
    }

    public boolean validatePhoneNum(final String phoneNum) {
        matcher = phoneNumPattern.matcher(phoneNum);
        return matcher.matches();
    }

    public boolean validatePassword(final String password) {
        matcher = passwordPattern.matcher(password);
        return matcher.matches();
    }
}