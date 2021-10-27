import 'package:shared_preferences/shared_preferences.dart';

class DBUtil {
  static SharedPreferences prefs;

  static Future<SharedPreferences> init() async {
    print("SharedPreferences init..");
    prefs = await SharedPreferences.getInstance();
    print("return SharedPreferences init..");
    return prefs;
  }
}
