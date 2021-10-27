import 'package:localstorage/localstorage.dart';
import 'dart:convert';

class LocalStorageUtil {
  static final LocalStorage storage = new LocalStorage('lstore.json');

  static void saveToStorage(String key, String value) {
    storage.setItem(key, json.encode(value));
  }

  static void clearStorage() async {
    await storage.clear();
  }

  static String getFromStorage(String key) {
    String value = storage.getItem(key);
    print("get from local storage:" + key + "/" + value);
    return storage.getItem(key);
  }
}
