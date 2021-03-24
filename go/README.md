# bitmaelum flutter plugin

This Go package implements the host-side of the Flutter [bitmaelum](https://github.com/bitmaelum/bitmaelum_flutter_plugin) plugin.

## Usage

Import as:

```go
import bitmaelum "github.com/bitmaelum/bitmaelum_flutter_plugin/go"
```

Then add the following option to your go-flutter [application options](https://github.com/go-flutter-desktop/go-flutter/wiki/Plugin-info):

```go
flutter.AddPlugin(&bitmaelum.Plugin{}),
```