# WeCount
[![All Contributors](https://img.shields.io/badge/all_contributors-5-orange.svg?style=flat-square)](#contributors)
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
  - dooboolab's [vision-and-mission](https://github.com/dooboolab/dooboolab.com/blob/master/vision-and-mission.md)
  - dooboolab's [code of conduct](https://github.com/dooboolab/dooboolab.com/blob/master/code-of-conduct.md)
* [Contributing](CONTRIBUTING.md)

## Install firebase
* [Setup Firebase Project](https://firebase.google.com/docs/flutter/setup)
* Add google service files to `ios` and `android`.
  - You need to add below files yourself in your project.
    ```
    android/app/google-services.json
    ios/Runner/GoogleService-Info.plist
    ```

## Credentials keys
Copy `.env.sample` to `.env` and replace credentials.
```
cp .env.sample .env
```
* List of keys

  | Name             | Description                | required?    |
  |------------------|----------------------------|--------------|
  | GEO_API_KEY      | Google map api key         | yes          |
  | API_KEY          | firebae api key            | yes          |
  | DATABASE_URL     | firebase firestore url     | yes          |
  | PROJECT_ID       | firebase project id        | yes          |
  | BUNDLE_ID        | bundle id                  | yes          |
  | STORAGE_BUCKET   | firebase storage url       | yes          |
  | GCM_SENDER_ID    | firebase gcm sender id     | yes          |
  | APP_ID_IOS       | google app id for ios      | yes          |
  | APP_ID_ANDROID   | google app id for android  | yes          |
  | APP_ID_WEB       | google app id for web      | yes          |

   - Google API KEY
     * [Installation](https://developers.google.com/maps/documentation/geocoding/get-api-key)
     * [Android](https://developers.google.com/maps/documentation/android-sdk/get-api-key)
     * [iOS](https://developers.google.com/maps/documentation/ios-sdk/get-api-key)
   - PLACE_API_KEY
     > Same as `GEO_API_KEY` but recommend to create another `API_KEY` to track usage seperately. You can use this one without platform specific.
## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table>
  <tr>
    <td align="center"><a href="http://dooboolab.com"><img src="https://avatars0.githubusercontent.com/u/27461460?v=4" width="60px;" alt="Hyo Chan Jang"/><br /><sub><b>Hyo Chan Jang</b></sub></a><br /><a href="https://github.com/dooboolab/WeCount/commits?author=hyochan" title="Code">💻</a> <a href="https://github.com/dooboolab/WeCount/commits?author=hyochan" title="Tests">⚠️</a> <a href="https://github.com/dooboolab/WeCount/commits?author=hyochan" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/Jay-flow"><img src="https://avatars0.githubusercontent.com/u/29420674?v=4" width="60px;" alt="J-flow"/><br /><sub><b>J-flow</b></sub></a><br /><a href="https://github.com/dooboolab/WeCount/commits?author=Jay-flow" title="Code">💻</a></td>
  </tr>
</table>

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
