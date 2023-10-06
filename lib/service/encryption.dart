// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

class Encryptor {
  static final key = Uint8List.fromList(
      [74, 110, 86, 57, 52, 53, 53, 112, 69, 107, 72, 105, 78, 68, 105, 65]);

  static String encrypt(String plainText) {
    final key = KeyParameter(Encryptor.key);
    final c = BlockCipher("AES");
    c.init(true, key);

    // Pad the input buffer to a multiple of the block size
    final blockSize = c.blockSize;
    final padLength = blockSize - (plainText.length % blockSize);
    final paddedData = Uint8List.fromList(
        [...utf8.encode(plainText), ...List.filled(padLength, padLength)]);

    final encVal = c.process(paddedData);
    String encryptedValue = base64.encode(encVal);
    return encryptedValue;
  }

  static String decrypt(String cipherText) {
    final key = KeyParameter(Encryptor.key);
    final c = BlockCipher("AES");
    c.init(false, key);
    final decodedValue = base64.decode(cipherText);

    // Unpad the input buffer
    final blockSize = c.blockSize;
    final padLength = decodedValue.last;
    final data = decodedValue.sublist(0, decodedValue.length - padLength);

    final decValue = c.process(data);
    final decryptedValue = utf8.decode(decValue);
    return decryptedValue;
  }
}
