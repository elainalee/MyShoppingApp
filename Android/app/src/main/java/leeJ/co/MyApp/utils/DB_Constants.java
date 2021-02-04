package leeJ.co.MyApp.utils;

public class DB_Constants {

    public final static String SID = "sellerid";
    public final static String UID = "username";
    public final static String PW = "password";

    // for items_sell table:
    public final static String ITEMS_SELL_TABLE = "items_sell";
    public final static String I_DESCRIPTION = "description";
    public final static String I_IMAGE = "image";
    public final static String I_PRICE = "price";
    public final static String I_TITLE = "title";
    public final static String I_ORIGIN = "origin";
    public final static String I_TAGS = "tags";
    public final static String I_CATEGORY = "category";

    // for carts table:
    public final static String CARTS_TABLE = "carts";
    public final static String C_UID = "userid";
    public final static String C_IID = "itemid";

    // for firebase storage (images) folder
    public final static String ITEMS_IMAGES = "items_images";

    // for sellers table:
    public final static String SELLER_TABLE = "sellers";
    public final static String S_SHOPNAME = "shopname";
    public final static String S_SELLERNAME = "sellername";
    public final static String S_SELLERIMAGE = "sellerimage";

    // for users table:
    public final static String USERS_TABLE = "users";
}
