# MyApp-Android

# To run the Android part:

1. get packages for flutter on Android/flutter_module
    - cd flutter_module
    - flutter packages get

2. gradle sync and run


# To run the Android and flutter part with database connection

1. set up Flutter-Core module under MyShoppingApp
    - instructions are under the Flutter-Core README.md
    - this is to set up the database section for flutter


2. get packages for flutter on Android/flutter_module again
    - cd flutter_module
    - flutter packages get

3. gradle sync and run



# In case of Error

1. go to Android/flutter_module
    - cd flutter_module

2. clean the cache for flutter
    - flutter clean

3. Invalidate cache/restart

4. get packages/ upgrade packages
    - flutter packages get
    - flutter packages upgrade

5. sync gradle and run