import 'package:encrypted_asset_image/encrypted_asset_image.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
      key:
          'VihW5CNfR9Fmhgz6b5AbUDQPsAzRWCA8', // This is your key with a length equal to 32
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
