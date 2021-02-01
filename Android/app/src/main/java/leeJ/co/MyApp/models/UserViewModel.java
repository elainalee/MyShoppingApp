package leeJ.co.MyApp.models;

public class UserViewModel {
    private String username;
    private String name;
    private String password;
    private String email;
    private String phoneNum;

    public UserViewModel(String username, String name, String password, String email, String phoneNum) {
        this.username = username;
        this.name = name;
        this.password = password;
        this.email = email;
        this.phoneNum = phoneNum;
    }

    public String getUsername() {
        return username;
    }

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

}
