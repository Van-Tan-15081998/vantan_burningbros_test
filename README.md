# product_demo

Run the Project:

1. System Requirements:
   - Flutter SDK: 3.32.0
   - Dart SDK: included with Flutter
   - Android Studio / VS Code (for development).

2. Clone the Repository & Install Dependencies:
   - git clone https://github.com/Van-Tan-15081998/vantan_burningbros_test.git
   - cd product_demo.
   - command: flutter pub get.

3. Platform Configuration:
   - Android:
     + Check android/app/build.gradle for minSdkVersion and ndkVersion
     + Ensure Internet permission is enabled in AndroidManifest.xml
       <uses-permission android:name="android.permission.INTERNET" />

4. Run the App:
   - command: flutter run