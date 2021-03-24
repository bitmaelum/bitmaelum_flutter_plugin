# bitmaelum_flutter_plugin

Library for use Bitmaelum client with (future) support for android, ios, macos, windows, linux, web and hover

Heavily based on the [openpgp flutter plugin](https://github.com/jerson/flutter-openpgp)

## Contents

- [Usage](#usage)
- [Setup](#setup)
  - [Android](#android)
    - [ProGuard](#proguard)
  - [iOS](#ios)
  - [Web](#web)
  - [MacOS](#macos)
  - [Hover](#hover)
  - [Linux](#linux)
  - [Windows](#windows)
- [Example](#example)
- [Native Code](#native-code)

## Usage

## Open vault method
```dart
import 'package:bitmaelum_flutter_plugin/bitmaelum_flutter_plugin.dart';

void main() async {
    var result = BitmaelumClientPlugin.openVault(filePath, password);
}
```

## Setup

### Android

#### ProGuard

Add this lines to `android/app/proguard-rules.pro` for proguard support.

```proguard
-keep class go.** { *; }
-keep class bitmaelum_flutter_plugin.** { *; }
```

### iOS

No additional setup required.

### Web

Add to you `pubspec.yaml`.

```yaml
assets:
    - packages/bitmaelum_flutter_plugin/web/assets/worker.js
    - packages/bitmaelum_flutter_plugin/web/assets/wasm_exec.js
    -packages/bitmaelum_flutter_plugin/web/assets/bitmaelum.wasm
```

ref: https://github.com/jerson/flutter-openpgp/blob/master/example/pubspec.yaml

### MacOS

No additional setup required.

### Hover

Update your plugins.

```bash
hover plugins get
```

In you `main_desktop.dart` by now you need to add `BitmaelumClientPlugin.bindingEnabled = false` in order to use channels instead of shared objects

```dart
import 'main.dart' as original_main;
import 'package:bitmaelum_flutter_plugin/bitmaelum_flutter_plugin.dart';

void main() {
  BitmaelumClientPlugin.bindingEnabled = false;
  original_main.main();
}

```

### Linux

No additional setup required.

### Windows

No additional setup required.

## Example

Inside example folder.

```bash
cd example && flutter run
```

## Native Code

Native library is made in `Go` for faster performance.

[https://github.com/bitmaelum/bitmaelum-client-lib]
