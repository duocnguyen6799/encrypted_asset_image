## Features

A widget displays an encrypted image from the asset folder. The best package is to secure your local
resource. It commonly uses in some apps such as Home Workout, Math Riddles and Puzzles, English
Learning,... 

Reference:
- 📁 FileCryptor (https://github.com/webdastur/file_cryptor)

## Getting started

You should ensure that you add the router as a dependency in your flutter project.

```yaml
dependencies:
  encrypted_asset_image: ^0.0.1
```

You should then run `flutter pub get`. Don't forget to declare assets resource in `pubspec.yaml`.

```yaml
flutter:
  assets:
    - assets/
```

## Example Project

There is a example project in the `example` folder. Check it out. However, to encrypt image, you can
check out in `crypto_example` folder.

## Usage

### 1 - Generate an encrypted image
```dart
import 'dart:io';
import 'package:file_cryptor/src/file_cryptor.dart';

void main() async {
  // Init file crypto with key length = 32
  FileCryptor fileCryptor = FileCryptor(
    key: "VihW5CNfR9Fmhgz6b5AbUDQPsAzRWCA8",
    iv: 16,
    dir: "crypto_example",
  );
  const fileName = 'logo_image.png';

  // Encrypt file and calculate executed time
  var stopwatch1 = Stopwatch()..start();

  File encryptedFile = await fileCryptor.encrypt(
      inputFile: "raw/$fileName", outputFile: "encrypt/$fileName");

  print('Encryption executed in ${stopwatch1.elapsed}');
  print('Encrypted file path: ${encryptedFile.absolute}');

  // Decrypt file and calculate executed time
  var stopwatch2 = Stopwatch()..start();

  File decryptedFile = await fileCryptor.decrypt(
      inputFile: "encrypt/$fileName", outputFile: "decrypt/$fileName");

  print('Decryption executed in ${stopwatch2.elapsed}');
  print('Decrypted file path: ${decryptedFile.absolute}');
}
```
### 2 - EncryptedAssetImage

Basic widget

```dart
final FileCryptor fileCryptor = FileCryptor(
    key: 'VihW5CNfR9Fmhgz6b5AbUDQPsAzRWCA8', // This is your key with a length equal to 32
    iv: 16, // iv is Initialization vector encryption times
    dir: 'example', // Not required for this widget
    );
```
```dart
new EncryptedAssetImage(
    assetPath: 'assets/encrypted_logo_image.png',
    fileCryptor: fileCryptor)
```
Complete example

```dart
import 'package:encrypted_asset_image/encrypted_asset_image.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final FileCryptor fileCryptor;

  @override
  void initState() {
    fileCryptor = FileCryptor(
      key: 'VihW5CNfR9Fmhgz6b5AbUDQPsAzRWCA8', // This is your key with a length equal to 32
      iv: 16, // iv is Initialization vector encryption times
      dir: '', // Not required for this widget
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Encrypted Asset Image Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: EncryptedAssetImage(
                    assetPath: 'assets/encrypted_logo_image.png',
                    fileCryptor: fileCryptor)),
            Expanded(
                child: EncryptedAssetImage(
                    assetPath: 'assets/encrypted_dash_image.png',
                    fileCryptor: fileCryptor))
          ],
        ),
      ),
    );
  }
}
```

## Additional information

You can follow me on Linkedin [DuocNP] (https://www.linkedin.com/in/duocnguyen6799)