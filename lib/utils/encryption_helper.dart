import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt_pkg;
import 'package:path_provider/path_provider.dart';

class EncryptionHelper {
  static final _keyString =
      sha256.convert(utf8.encode('very_secret_key_change_me')).toString().substring(0, 32);

  static Future<String?> encryptFile(String inputFilePath) async {
    try {
      final file = File(inputFilePath);
      final bytes = await file.readAsBytes();
      final key = encrypt_pkg.Key.fromUtf8(_keyString);
      final iv = encrypt_pkg.IV.fromLength(16);
      final encrypter = encrypt_pkg.Encrypter(encrypt_pkg.AES(key));
      final encrypted = encrypter.encryptBytes(bytes, iv: iv);

      final dir = await getApplicationDocumentsDirectory();
      final out = File('${dir.path}/${file.uri.pathSegments.last}.enc');
      await out.writeAsBytes(encrypted.bytes);

      return out.path;
    } catch (e) {
      return null;
    }
  }
}
