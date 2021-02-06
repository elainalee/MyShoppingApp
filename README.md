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
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Flogin_page.jpg?alt=media&token=95ab285f-7dcb-42b2-b0fa-9a0853a8c455" width="200" height="200" />
<img src="https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2Fsignup_page.jpg?alt=media&token=fc00e4f3-5d86-4058-8228-faa2bde3a7af" width="200" height="200" />

This will let you create your account to the database. Now, you can use the username and password to log in. When you log in, you will see all available listings. To change user information, you can click the profile button on top right. When you click on a listing, it leads you to ldp (listing detail page). You can press "cart", which will be stored on database. Also, you could click "See More of ...'s itmes >" button, which will let you see all available listings from the same seller.


When you log in with the "are you a seller?" button, it leads you to the seller page. Seller account cannot be registered through the app. If you would like to check out, please use id: seller1, password: seller1pw. This will lead you to the seller page with the account. Here, you can click "My Listings" and look at the listings, and also add listing by clicking on "Add Listing" button below.


# What did I use to develop the app?

This app is written in **Java (Android)** and **Dart (Flutter)**. 

The app integrates Flutter into Android on run.

Android consists of login page, listings page.

Flutter includes ldp and smp, and those can be run on its own (read README.md under Flutter-Core folder).

For database, I used **Firebase Realtime Database** and **Firebase Storage** (for image files).

The database is constructed in regards to the ER diagram below.

![ER Diagram](https://firebasestorage.googleapis.com/v0/b/my-app-leej.appspot.com/o/sample_images%2FER%20Diagram.png?alt=media&token=1a53def8-dedd-4926-93c6-becc07ccadfa)


