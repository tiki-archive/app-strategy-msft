
# Microsoft Provider
Microsoft conector for Tiki App.

## How to Use

### Link new account
1. Initialize with `MicrosoftProvider({onLink, onUnlink, httpp})`.
2. Use `accountWidget()` method to build the login Widget.

### Open account with auth token
1. Initialize with `MicrosoftProvider.loggedIn()` passing the auth token.
2. Use `accountWidget()` method to build the login Widget.

### Available methods
- Fetches the inbox and passes a list of messages ids to onResult callback.
```  
Future<void> fetchInbox(  
{DateTime? since,  
required Function(List<String> messagesIds) onResult,  
required Function() onFinish}) 
```  

- Fetches the messages base on the list of messagesIds passed to it.
```  
Future<void> fetchMessages(  
{required List<String> messageIds,  
required Function(MicrosoftProviderModelEmail message) onResult,  
required Function() onFinish})  
```  

- Sends an email.
```  
Future<void> sendEmail(  
{String? body,  
required String to,  
String? subject,  
Function(bool)? onResult})  
```  

- Updates the model with the user info.
  `Future<void> update({Function(MicrosoftProviderModel)? onUpdate})`

- Gets the user display name.  
  ``` String? get displayName```
  ## Setup

### Android setup

Go to the `build.gradle` file for your Android app to specify the custom scheme so that there should be a section in it that look similar to the following but replace `<your_custom_scheme>` with the desired value

```  
...  
android {  
 ... defaultConfig { 
    ... manifestPlaceholders += [ 'appAuthRedirectScheme': '<your_custom_scheme>' ] 
    }
 }  
```  

Please ensure that value of `<your_custom_scheme>` is all in lowercase as there've been reports from the community who had issues with redirects if there were any capital letters. You may also notice the `+=` operation is applied on `manifestPlaceholders` instead of `=`. This is intentional and required as newer versions of the Flutter SDK has made some changes underneath the hood to deal with multidex. Using `=` instead of `+=` can lead to errors like the following

```  
Attribute application@name at AndroidManifest.xml:5:9-42 requires a placeholder substitution but no value for <applicationName> is provided.  
```  

If you see this error then update your `build.gradle` to use `+=` instead.

If your app is target API 30 or above (i.e. Android 11 or newer), make sure to add the following to your `AndroidManifest.xml` file a level underneath the `<manifest>` element


```xml  
<queries>  
 <intent> <action android:name="android.intent.action.VIEW" /> <category android:name="android.intent.category.BROWSABLE" /> <data android:scheme="https" /> </intent> <intent> <action android:name="android.intent.action.VIEW" /> <category android:name="android.intent.category.APP_BROWSER" /> <data android:scheme="https" /> </intent></queries>  
```  

## iOS setup

Go to the `Info.plist` for your iOS app to specify the custom scheme so that there should be a section in it that look similar to the following but replace `<your_custom_scheme>` with the desired value


```xml  
<key>CFBundleURLTypes</key>  
<array>  
 <dict> <key>CFBundleTypeRole</key> <string>Editor</string> <key>CFBundleURLSchemes</key> <array> <string><your_custom_scheme></string> </array> </dict></array>  
```  

## How to contribute
Thank you for contributing with the data revolution!      
All the information about contribution can be found in [CONTRIBUTING](https://github.com/tiki/app/CONTRIBUTING.md)

## License
MIT license