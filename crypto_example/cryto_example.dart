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
  // const fileName = 'dash_image.png';

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
