# CocoaPods
sudo gem install cocoapods

## Add Firebase SDK

### Create a Podfile if you don't have one:
pod init

### Open your Podfile and add:
pod 'Firebase/Core'

https://firebase.google.com/docs/auth/ios/custom-auth
pod 'Firebase/Auth'

### Save the file and run:
pod install


## to appDelegate.swift add

import Firebase


FirebaseApp.configure()

## shortcut

commit - alt cmd c

library - cmd shift l

## library
https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html
https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html


## Firebase Auth
https://firebase.google.com/docs/auth/ios/manage-users

## alert controller
https://guides.codepath.com/ios/Using-UIAlertController

## switch toggler keyboard
hardware - cmd k

## security rules

service cloud.firestore {
match /databases/{database}/documents {

match /testdb/{thought=**} {
allow read, write: if request.auth != null
}

match /users/{userId} {
allow create
allow read, write : if request.auth.id == userId
}


//     match /testdb/{thought} {
//       allow read, write: if request.auth != null

//       match /testdb/{thought}/comments/{comment} {
//         allow read, write : if request.auth != null
//       }
//     }

// match /testdb/{thought}/comments/{comment} {
//   allow read, write : if request.auth != null
// }
}
}




