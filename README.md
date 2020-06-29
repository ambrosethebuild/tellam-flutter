# tellam

Tellam flutter package to integrate FAQ and live support chat using firebase.

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.dev/).

For help on editing plugin code, view the [documentation](https://flutter.dev/docs/development/packages-and-plugins/using-packages#edit-code).

## Important
Tellam depends on firebase database. Firebase database must be configured before you can use tellam.

For help on adding firebase database, view the [documentation](https://pub.dev/packages/firebase_database)

## Usage

To use this package :

```yaml
dependencies:
    flutter:
      sdk: flutter
    tellam:
```

Then initialize the package whenever you need it:

```dart

//setup tellam
  Tellam.initialize(    
    //secretKey: "YOUR-SECRET-KEY",
    databaseUrl: "YOUR-FIREBASE-DATABASE-URL",
    uiconfiguration: UIConfiguration(
      accentColor: Colors.red[300],
      primaryColor: Colors.red[600],
      primaryDarkColor: Colors.red[900],
      buttonColor: Colors.red[400],
    ),
  );

```

To enable live chat you need to register a user
```dart

//register tellam user
TellamUser tellamUser = TellamUser(
    //required
    id: userAccount.id,
    firstName: userAccount.firstName,
    //the rest are optional
    lastName: userAccount.lastName,
    emailAddress: userAccount.emailAddress,
    phoneNumber: userAccount.phoneNumber,
    photo: userAccount.photo,
);

Tellam.client().register(tellamUser);

```

To show tellam FAQ and live support page/view
```dart

    //show tellam page/view
    Tellam.show(
        context,
        //true if you want your user to be able to contact support team via the live chat section
        //note you must have register a user to use this feature
        enableChat: true,
    );

```


## :arrow_forward: Running Example project
For help getting started with Flutter, view the online [documentation](https://flutter.io/).

An [example project](https://github.com/ambrosethebuild/tellam-flutter/tree/master/example) has been provided in this plugin.
Clone this repo and navigate to the **example** folder. Open it with a supported IDE or execute `flutter run` from that folder in terminal.

## :pencil: Contributing, :disappointed: Issues and :bug: Bug Reports
The project is open to public contribution. Please feel very free to contribute.
Experienced an issue or want to report a bug? Please, [report it here](https://github.com/ambrosethebuild/tellam-flutter/issues). Remember to be as descriptive as possible.

## :trophy: Credits
None yet
