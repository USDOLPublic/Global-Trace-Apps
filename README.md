# Global-trace-apps

A Global-trace-apps project created in flutter, supports both iOS and Android.

## Getting Started
Setup Environment:
**Flutter SDK** • ver 3.13.6 • channel stable • https://github.com/flutter/flutter.git
**Dart** • ver 3.1.3
**Dev Tools** • ver 2.25.0
**Engine** • revision a794cf2681

## How to Use 

**Step 1:**
Download or clone this repo by using the link below:
```
https://gitlab.com/diginexhk/Global-trace/global-trace-apps.git
```
**Step 2:**
Go to project root and execute the following command in console to get the required dependencies: 
```
flutter pub get 
```
**Step 3:**
This project uses `inject` library that works with code generation, execute the following command to generate files:
```
flutter packages pub run build_runner build --delete-conflicting-outputs
```
or watch command in order to keep the source code synced automatically:
```
flutter packages pub run build_runner watch
```
**Step 4:**
To run project
```
flutter run --debug
```

To deploy

Go to `_buildScripts`

Development environment:

**iOS**
```console
./ios_build.sh dev
```
**ANDROID**
```console
./android_build.sh dev
```

UAT environment:

**iOS**
```console
./_buildScripts/ios_build.sh uat
```
**ANDROID**
```console
./_buildScripts/android_build.sh uat
```

### Libraries & Tools Used

* [Dio](https://github.com/flutterchina/dio) (HTTP Client)
* [Hive](https://pub.dev/packages/hive) (Database)
* [GetX](https://pub.dev/packages/get) (State Management)

### Folder Structure
Here is the core folder structure which flutter provides.

```
usdol-app/
|-  android
|-  assets
|   |- fonts                => Fonts
|   |- icons                => App icon files
|   |- images               => Image files (SVG, PNG, JPG)
|-  build
|-  ios
|-  lib                     => App src
|-  test
|-  pubspec.yaml
|-  analysis_options.yaml   => This file configures the analyzer, which statically analyzes Dart code to check for errors, warnings, and lints.
```

Here is the folder structure we have been using in this project

```
lib/
|-  app/
|   |-  config/        => Contains routes, themes, build config
|   |-  constants/      => All the application level constants are defined in this directory 
|   |-  hive-manager/   => Contains hive manager, key models
|   |-  pages/          => Contains all the business logic of a screen
|       |-  login/      => exp: login page
|           |-  bindings/
|           |-  controllers/
|           |-  repositories/
|           |-  services/
|           |-  views/
|           |-  login.dart
|   |-  utils/          => Contains utils
|   |-  widgets/        => Contains the common widgets that are shared across multiple screens
|   |-  core.dart
|-  common/             => Contains the common file(s) and utilities used in a project
|-  generated/          => Generated files
|-  l10n/               => Text files
|-  main.dart           => Run app
```
### Code Rule
Rules defined in the analysis_options.yaml file. Please check more details at:
[Rules](https://dart.dev/tools/linter-rules)
