# CocoaPods
sudo gem install cocoapods

## Add Firebase SDK

### Create a Podfile if you don't have one:
pod init

### Open your Podfile and add:
pod 'Firebase/Core'

### Save the file and run:
pod install


## to appDelegate.swift add

import Firebase


FirebaseApp.configure()




