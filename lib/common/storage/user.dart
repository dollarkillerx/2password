import 'localstorage.dart';

class AppData {
  static Future<String?> getJWT() async {
    var value = await LocalStorage.getString("my_jwt");
    if (value == null) {
      return null;
    }
    return value;
  }
}
