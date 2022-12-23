# WeCount
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](CONTRIBUTING.md)

WeCount is the social ledger platform.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Contributing to `WeCount`
* See also
  - dooboolab's [vision-and-mission](https://dooboolab.com/vision_and_mission)
  - dooboolab's [code of conduct](https://dooboolab.com/code_of_conduct)
* [Contributing](CONTRIBUTING.md)

## Install firebase
* Follow the [document](https://firebase.google.com/docs/flutter/setup?platform=ios) and run `flutterfire configure`.

## Credentials keys
Copy `.env.sample` to `.env` and replace credentials.
```
cp .env.sample .env
```
* List of keys

  | Name             | Description                | required?    |
  |------------------|----------------------------|--------------|
  | GEO_API_KEY      | Google map api key         | yes          |
  | API_KEY          | firebase api key            | yes          |

   - Google API KEY
     * [Installation](https://developers.google.com/maps/documentation/geocoding/get-api-key)
     * [Android](https://developers.google.com/maps/documentation/android-sdk/get-api-key)
     * [iOS](https://developers.google.com/maps/documentation/ios-sdk/get-api-key)
   - PLACE_API_KEY
     > Same as `GEO_API_KEY` but recommend to create another `API_KEY` to track usage seperately. You can use this one without platform specific.

## Build @freezed model

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```
