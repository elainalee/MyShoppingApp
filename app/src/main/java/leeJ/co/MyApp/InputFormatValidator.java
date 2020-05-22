package leeJ.co.MyApp;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class InputFormatValidator {

    private Pattern namePattern;
//    , userPattern, emailPattern, phoneNumPattern;
    private Matcher matcher;

    private static final String NAME_PATTERN = "[a-zA-Z]+(\\s[a-zA-Z]+)?";
//    private static final String USERNAME_PATTERN = "^[a-zA-Z0-9.-]$";
//    private static final String EMAIL_PATTERN = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+";
//    private static final String PHONE_NUM_PATTERN = "^[0-9-+]+$";


    public InputFormatValidator(){
        namePattern = Pattern.compile(NAME_PATTERN);
//        userPattern = Pattern.compile(USERNAME_PATTERN);
//        emailPattern = Pattern.compile(EMAIL_PATTERN);
//        phoneNumPattern = Pattern.compile(PHONE_NUM_PATTERN);
    }

    public boolean validateName(final String name) {

        matcher = namePattern.matcher(name);

        System.out.println("VALIDATOR-TEST: "+name);

        if (matcher.matches()) {
            System.out.println("VALIDATOR-TEST: name matches the pattern");
        } else {
            System.out.println("VALIDATOR-TEST: name doesn't match the pattern");
        }

        return matcher.matches();
    }

//    public boolean validateUsername(final String username){
//        matcher = userPattern.matcher(username);
//        if (matcher.matches()) {
//            System.out.println("VALIDATOR-TEST: username matches the pattern");
//        } else {
//            System.out.println("VALIDATOR-TEST: username doesn't match the pattern");
//        }
//        return matcher.matches();
//    }
//
//    public boolean validateEmail(final String email){
//        matcher = emailPattern.matcher(email);
//        return matcher.matches();
//    }
//
//    public boolean validatePhoneNum(final String phoneNum){
//        matcher = phoneNumPattern.matcher(phoneNum);
//        return matcher.matches();
//    }
}