# smp

flutter module for smp

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.dev/).

# Firebase setup

1. for smp/.android/app:
    // add the file google-services.json from firebase
    // link: https://console.firebase.google.com/project/my-app-leej/settings/general/android:leeJ.co.MyApp

2. for smp/.android/build.gradle:
    1) // add the below line to dependencies

        classpath 'com.google.gms:google-services:4.3.3'

       // it should look like this
        //
        dependencies {
        ...
        classpath 'com.google.gms:google-services:4.3.3'
        //
        }   

3. for smp/.android/app/build.gradle
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
    

# iOS Setup:

1. for image_picker (https://pub.dev/packages/image_picker):

    1) Add the following keys to your Info.plist file, located in <project root>/ios/Runner/Info.plist:
    
        - NSPhotoLibraryUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.

        - NSCameraUsageDescription - describe why your app needs access to the camera. This is called Privacy - Camera Usage Description in the visual editor.

        - NSMicrophoneUsageDescription - describe why your app needs access to the microphone, if you intend to record videos. This is called Privacy - Microphone Usage Description in the visual editor.



# Android Setup:

1. for image_picker (https://pub.dev/packages/image_picker):

    1) for API < 29 only

        - Add android:requestLegacyExternalStorage="true" as an attribute to the <application> tag in AndroidManifest.xml. The attribute is false by default on apps targeting Android Q.

2. for image_cropper (https://pub.dev/packages/image_cropper)

    1) Add the below into android/app/AndroidManifest.xml (under <application> tag along with other activity)

        - <activity
            android:name="com.yalantis.ucrop.UCropActivity"
            android:screenOrientation="portrait"
            android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
