# What is "MyShoppingApp"?

MyShoppingApp is an ecommerce app that helps the transaction between sellers and users(buyers).

This app was initially designed with the hope of helping people selling items on their sns account by making the process easier to this app.

To run the app, please refer to below (#To Run the App).

# To Run the App

1. Clone the entire project

2. Open Android folder on Android Studio

2. Go to Android/flutter_module on terminal
    - cd flutter_module

3. Run flutter packages get
    - flutter packages get

4. gradle sync on Android Studio, and run


# In case of Error

- Please check if you have flutter sdk and dart sdk first.

1. go to Android/flutter_module
    - cd flutter_module

2. clean the cache for flutter
    - flutter clean

3. Invalidate cache/restart on Android Studio

4. get packages/ upgrade packages
    - flutter packages get
    - flutter packages upgrade

5. sync gradle and run


# How does this app work?

When you log in as a user, please use the "New User? Sign Up" button. 
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Fstart_page.jpg?alt=media&token=6e8ad6d3-cb01-4653-a359-e1cf6222b1a8" height="300" />
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Flogin_page.jpg?alt=media&token=95ab285f-7dcb-42b2-b0fa-9a0853a8c455" height="300" />
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Fsignup_page.jpg?alt=media&token=fc00e4f3-5d86-4058-8228-faa2bde3a7af" height="300" />

This will let you create your account to the database. Now, you can use the username and password to log in. When you log in, you will see all available listings. To change user information, you can click the profile button on top right. When you click on a listing, it leads you to ldp (listing detail page). You can press "cart", which will be stored on database. Also, you could click "See More of ...'s itmes >" button, which will let you see all available listings from the same seller.
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Flistings_page.jpg?alt=media&token=86b39b83-6c70-4e2a-9a82-8b2835e05171" height="300" />
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Fuser_profile_section.jpg?alt=media&token=2f527696-7e88-48f8-9f47-996400b74936" height="300" />
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Flisting_page.jpg?alt=media&token=8214a3b9-67cf-498d-85c2-34a107e87420" height="300" />
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Fseller_listing_page.jpg?alt=media&token=c3f79e8d-9321-4bb6-b3b8-a14410223acb" height="300" />
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Fadded_to_cart.jpeg?alt=media&token=ca1aa4b6-e2df-4872-b75e-becba13bf5ba" height="300" />
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Flisting_seller_page.jpg?alt=media&token=0da9eb9e-b741-4bce-a720-526a0b3ad934" height="300" />

When you log in with the "are you a seller?" button, it leads you to the seller page. Seller account cannot be registered through the app. If you would like to check out, please use id: seller1, password: seller1pw. This will lead you to the seller page with the account. Here, you can click "My Listings" and look at the listings, and also add listing by clicking on "Add Listing" button below.
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Flogin_page_seller.jpg?alt=media&token=153f20a7-41b6-45fa-86e3-796a2defe18b" height="300" />
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Fseller_screen_page.jpg?alt=media&token=1b3d4d73-3bda-418b-a7c8-7696fd5d9ee2" height="300" />
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Fseller_listings_page.jpg?alt=media&token=f60b5f6c-ade5-41cb-bc57-6a120a8f8265" height="300" />
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Fseller_listing_posting_page.jpg?alt=media&token=b668254a-729b-43b9-be82-11f45a327ba0" height="300" />


# What did I use to develop the app?

This app is written in **Java (Android)** and **Dart (Flutter)**. 

The app integrates Flutter into Android on run.

Android consists of login page, listings page.

Flutter includes ldp and smp, and those can be run on its own (read README.md under Flutter-Core folder).

For database, I used **Firebase Realtime Database** and **Firebase Storage** (for image files).

The database is constructed in regards to the ER diagram below.

![ER Diagram](https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2FER%20Diagram.png?alt=media&token=1a53def8-dedd-4926-93c6-becc07ccadfa)


