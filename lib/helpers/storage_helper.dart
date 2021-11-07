import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static Future<void> saveData({String? key, String? data}) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString(key!, data!);
    });
    // print("saved $data");
  }

  static Future<String> loadData({String? key}) async {
    String _savedData = "no data found in storage.";
    await SharedPreferences.getInstance().then((prefs) {
      _savedData =
          prefs.getString(key!) ?? "no data found in storage.";
    });
    return _savedData;
  }

  static Future<bool> removeData({String? key}) async {
    var result;
    await SharedPreferences.getInstance().then((prefs) {
      result = prefs.remove(key!);
    });
    return result;
  }
}
