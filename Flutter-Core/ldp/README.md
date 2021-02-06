# ldp

flutter module for ldp

# Firebase setup

1. for ldp/.android/app:
    // add the file google-services.json from firebase
    // link: https://console.firebase.google.com/project/my-app-leej/settings/general/android:leeJ.co.MyApp

2. for ldp/.android/build.gradle:
    1) // add the below line to dependencies

        classpath 'com.google.gms:google-services:4.3.3'

       // it should look like this
        //
        dependencies {
        ...
        classpath 'com.google.gms:google-services:4.3.3'
        //
        }   

3. for ldp/.android/app/build.gradle
    1) // add the below line to under plugins
       // safe spot to add: under apply plugin: 'com.android.application'

        apply plugin: 'com.google.gms.google-services'
    
    2) // add the below line under dependencies

        implementation 'com.google.firebase:firebase-analytics:17.2.2'
    
       // it should look like this

        dependencies {
        // add the Firebase SDK for Google Analytics
        implementation 'com.google.firebase:firebase-analytics:17.2.2'
        // add SDKs for any other desired Firebase products
        // https://firebase.google.com/docs/android/setup#available-libraries
        }   

    3) // add the below line under defaultConfig

        multiDexEnabled true

    4) // match the applicationId to the same name as firebase - Android package name
       // in this case, leeJ.co.MyApp

       // it should look like this

       defaultConfig {
        applicationId "leeJ.co.MyApp"
        ...
        multiDexEnabled true
    }
    