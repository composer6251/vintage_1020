#### COMMON VERSION RECONCILING
<img src="ios/XCODE-Change Deployment Version.png"/>
1. Open app in XCODE
2. Click on "Runner" in the left pane.
3. Click "Build Settings" in the middle pane
4. Scroll down to "Deployment" section and change iOS Deployment Target


#### PROBLEM 1
 You have either:
     * out-of-date source repos which you can update with `pod repo update` or with `pod install --repo-update`.
     * changed the constraints of dependency `GoogleDataTransport` inside your development pod `firebase_crashlytics`.
       You should run `pod update GoogleDataTransport` to apply changes you've made.
#### FIRST TRY:
Before these steps, go to XCode Target - Runner - Deployment Info and change iOS target version


flutter clean

Delete /ios/Pods

Delete /ios/Podfile.lock

flutter pub get

from inside ios folder: pod install

flutter run

flutter clean ; rm -rf /ios/Pods ; rm /ios/Podfile.lock ; flutter pub get ; cd ios ; pod install ; cd .. ; flutter run

Note: if ; (semicolon) don't work for you then use && in place of ;


Error: Type 'Notifier' not found.