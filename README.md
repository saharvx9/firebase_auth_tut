
https://user-images.githubusercontent.com/35892162/172141993-72ff7264-294c-493c-833c-6f11bb966f41.mov

# firebase_auth_tut
This repository is for whole flutter community that his main issue based on flutter authentication with **FIREBASE**.
in adittion using in google and facebook auth front of firebase.

**This project use flutter 3!!**

Support platforms
- [x] Android
- [x] Iphone
- [x] Web
- [x] MacOs
- [ ] Windows 
- [ ] Linux

dont have windows or linux so i could't test it, i think it will work pls notify if someone want to try.

# Main plugin

## Firebase 
### Firebase core , Firebase auth , Firebase storage , Firebase firestore
This is the docs:
pls read it carefully!!
https://firebase.google.com/docs/flutter/setup?platform=web

## bLoc
State mangement Library
https://pub.dev/packages/flutter_bloc

## rxDart
Nice adittion to give more power to bloc (rxDart + bloc = bff ❤️)
https://pub.dev/packages/rxdart

## get_it
For di (dependency injection)
https://pub.dev/packages/get_it

## DotEnv
envioremnt variables file

in this porject his path:

root_project/assets/variables/dotenv
https://pub.dev/packages/flutter_dotenv

## Facebook auth
https://pub.dev/packages/flutter_facebook_auth

## Google sign in
https://pub.dev/packages/google_sign_in

# How to run project:
(recommend to read the docs before , this expknation will be short)


1. Create project in firebase
open cmd/terminal
2. run `firebase login`
3. run `dart pub global activate flutterfire_cli`
4. run `flutterfire configure` (if not found error run this at the terminal `"export PATH="$PATH":"$HOME/.pub-cache/bin"`)
5. Choose your project and platforms you want.
6. Wait untill finish and look that `firebase_options.dart` genereated 
7. Go to `Authentication` -> sign in method enable email password,google,facebook
8. Generate facebook client id and token id -> [https://facebook.meedu.app/docs/4.x.x/intro](url) 
9. After generate facebook_client_id and token_id copy them to :

   a. dotenv file in name `facebook_app_id` path -> (`root_project/assets/variables/dotenv`)
   
   b. go to `strings.xml` and past them in the right places 
   
   c. go to info `ios/runner/Info.plist` and past them in the right places
   
10. Google sign add `GoogleService-Info.plist` to ios project(from firebase porject settings) 
11. copy from `GoogleService-Info.plist` the `REVERSED_CLIENT_ID` and past it inside `ios/runner/Info.plist`
12. Run and enjoy


## Issues that can happened
1. M1 macs for ios or macOs app pod install not working try run in the cmd

   a. `sudo arch -x86_64 gem install ffi`
   
   b. `arch -x86_64 pod install`
   
2. Display image in web `CORS` error, solution :

   a. install brew
   
   b. run `brew install --cask google-cloud-sdk`
   
   c. run `gsutil cors set cors.json gs://{your_bucket_name}`

   





