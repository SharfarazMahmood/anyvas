import 'package:encrypt/encrypt.dart';

class EncryDecry {
  ////////////32 length key///////
  final _key = Key.fromUtf8('laDdHuaJP35CB51WhB50s4PnuifcHRFW');
  final _iv = IV.fromLength(16);

  EncryDecry();

  factory EncryDecry.methods() {
    return EncryDecry();
  }

  String toEncrypt(String data) {
    final encrypter = Encrypter(AES(_key));
    if (data != null) {
      final encrypted = encrypter.encrypt(data, iv: _iv);
      // print(encrypted.base64);
      return encrypted.base64;
    }
    return "no data received";
  }

  String toDecrypt(String data) {
    final encrypter = Encrypter(AES(_key));
    if (data != null) {
      final decrypted = encrypter.decrypt64(data, iv: _iv);
      // print(decrypted);
      return decrypted;
    }
    return "no data received";
  }
}
