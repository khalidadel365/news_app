# news_app

A modern Flutter application that delivers  news updates in Business, Science, and Sports categories. Users can sign up and log in securely through Firebase Authentication, and search for news articles powered by a News API.

## Features
- Email-based Authentication via Firebase
- News categorized by Business, Sports, and Science
- Search Functionality to find news articles by keyword
- Live data fetched from a News API
- Smooth, responsive UI built with Flutter

---

## Implementation Approach

The news_app is built using Flutter, a cross-platform framework, to provide a seamless and responsive user experience on both Android and iOS devices. The app fetches live news articles categorized into Business, Science, and Sports from a News API. Here’s an overview of the key implementation details:

1. **UI Design**:  
   The user interface is designed to be clean, responsive. Flutter’s widget-based structure allowed for easy creation of screens and layouts. The app adapts smoothly to different screen sizes and orientations, ensuring a positive user experience across devices.

2. **State Management**:  
   The app uses **Cubit** for state management. Cubit is a lightweight state management solution that provides simple and predictable states across the app. It’s ideal for managing the app’s state, such as loading states, API responses, and user interactions.

3. **Firebase Authentication**:  
   Firebase Authentication is integrated for secure user sign-up and login. Users can create accounts with their email addresses, securely authenticate, and maintain their sessions during app usage. This ensures a safe and streamlined login process for users.

4. **Fetching News Data**:  
   The app retrieves news data using a News API. The data is displayed based on categories like Business, Science, and Sports. A search function allows users to find articles by keyword, enhancing the app's usability.

5. **Firebase Setup**:  
   Firebase is used for user authentication. Firebase’s powerful, secure authentication system simplifies login and registration, ensuring users have a reliable and smooth experience.
   
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

