import 'package:shared_preferences/shared_preferences.dart';

class DBUtil {
  static SharedPreferences prefs;

  static Future<SharedPreferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
