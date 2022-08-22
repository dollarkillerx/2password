import 'localstorage.dart';

class Encryption {
  late String publicKey;
  late String privateKey;

  Encryption(this.publicKey, this.privateKey);
}

class AppData {
  static Future<String?> getJWT() async {
    var value = await LocalStorage.getString("my_jwt");
    if (value == null) {
      return null;
    }
    return value;
  }

  static setJWT(String jwt) async {
    await LocalStorage.setString("my_jwt", jwt);
  }

  static Future<Encryption?> encryption() async {
    var publicKey = await LocalStorage.getString("my_publicKey");
    if (publicKey == null) {
      return null;
    }
    var privateKey = await LocalStorage.getString("my_privateKey");
    if (privateKey == null) {
      return null;
    }
    return Encryption(publicKey, privateKey);
  }

  static setEncryption(String publicKey, String privateKey) async {
    await LocalStorage.setString("my_publicKey", publicKey);
    await LocalStorage.setString("my_privateKey", privateKey);
  }
}
