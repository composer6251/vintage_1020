

### ADDING PROJECT TO FIREBASE
#### Go to console.firebase.google.com and sign in(if necessary)
#### Create app

#### Android
#### In the IDE go to android manifest and copy package name

#### IOS:
Go to project.pbxproj and copy the BUNDLE_IDENTIFIER



#### HOSTING WITH FIREBASE:
*** ALL COMMANDS ARE RUN FROM PROJECT ROOT. WHERE THE PUBSPEC.YAML RESIDES ***
1. Install firebase CLI:
npm install -g firebase-tools
2. Login to firebase from command line:
firebase login
3. (OPTIONAL) Enable experiemental web frameworks
firebase experiments:enable webframeworks
4. Build/Enable hosting
firebase init hosting
Follow prompts

You will be given a URL for accessing your URL


#### Using firebase within Application

AuthGuard creates Firebase instance and stores credentials. 
This can be used throughout the app. 