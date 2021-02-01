package leeJ.co.MyApp.models;

public class ItemViewModel {
    private String title;
    private String description;
    private double price;
    private int image;
    private String imageURL;

    public ItemViewModel(String title, String description, double price, int image, String imageURL) {
        this.title = title;
        this.description = description;
        this.price = price;
        this.image = image;
        this.imageURL = imageURL;
    }

    public String getTitle() {
        return title;
    }

//    public void setTitle(String title) {
//        this.title = title;
//    }

    public String getDescription() {
        return description;
    }

//    public void setDescription(int image) {
//        this.description = description;
//    }

    public double getPrice() {
        return price;
    }

//    public void setPrice(int price) {
//        this.price = price;
//    }

    public int getImage() {
        return image;
    }

//    public void setImage(int image) {
//        this.image = image;
//    }

    public String getImageURL() { return imageURL; }
}
