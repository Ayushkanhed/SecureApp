import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  // IMPORTANT: In production, never hardcode keys. Use secure keystores.
  static final _key = encrypt.Key.fromUtf8('32chars_long_key_for_aes_256_encrypt!!');
  static final _iv = encrypt.IV.fromLength(16);

  static String encryptText(String plain) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(plain, iv: _iv);
    return encrypted.base64;
  }

  static String decryptText(String cipher) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key, mode: encrypt.AESMode.cbc));
    return encrypter.decrypt64(cipher, iv: _iv);
  }

  static String sha256Hash(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }
}
