# news_app

A modern Flutter application that delivers  news updates in Business, Science, and Sports categories. Users can sign up and log in securely through Firebase Authentication, and search for news articles powered by a 
 News API.

## Features
- Email-based Authentication via Firebase
- News categorized by Business, Sports, and Science
- Search Functionality to find news articles by keyword
- Live data fetched from a News API
- Smooth, responsive UI built with Flutter

---

## Prerequisites:
Flutter SDK (version 3.29.2) - Install from Flutter docs (https://flutter.dev/docs/get-started/install)

Android Studio or VS Code

Firebase Project Enable Email/Password Authentication in Firebase Console

---

## Setup Instructions

1- **Clone the repository**

 First, clone the repository to your local machine:
 bash
 git clone https://github.com/khalidadel365/news_app.git
 cd news_app

2-Install dependencies:
flutter pub get

3- Set up Firebase:
For Android: Add google-services.json to android/app/
For iOS: Add GoogleService-Info.plist to ios/Runner/

4-Run the app:
flutter run

## Tech Stack:

Flutter for UI

cubit for state management

Dart programming language

Firebase Authentication for login

News API for fetching live articles

