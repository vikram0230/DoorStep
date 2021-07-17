# DoorStep

Rental Management System built on Flutter with Firebase. 

<img src="https://github.com/vikram0230/DoorStep/blob/master/assets/images/logo.png" height=400>

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Build Instructions

Set up flutter on your local machine [Official Flutter Docs](https://flutter.dev/docs/get-started/install)

Clone this repo on your local machine:

```cmd
git clone https://github.com/vikram0230/DoorStep.git
```
### Firebase setup

Create a project on [Firebase](https://console.firebase.google.com/) named DoorStep and follow the [instructions](https://firebase.google.com/docs/android/setup)

### Using Android Studio:

Set up your editor of choice. [Official Flutter Docs for setting up editor](https://flutter.dev/docs/get-started/editor?tab=androidstudio)

- Android Studio
  - Open the project in Android Studio.
  - Make sure that you have your cursor has focused on lib/main.dart (or any other dart file) i.e. just open one of the dart files and click on the (dart) file once.
  - Click on Build > Flutter > Build APK in the menubar at the top of Android Studio.
  - Once the build finshes successfully, in the project folder, go to build > app > outputs > apk > release > app-release.apk
  - This will be your generated apk file which you can install on your phone.

### Using terminal:

- Using the terminal or cmd
  - Make sure you are in the project directory where the pubspec.yaml is present and open your terminal or cmd.
  - Run `flutter build apk`
  - Once the build finshes successfully, in the project folder, go to build > app > outputs > apk > release > app-release.apk
  - This will be your generated apk file which you can install on your phone.
