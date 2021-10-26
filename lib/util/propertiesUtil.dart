import "dart:collection";

class PropertiesUtil {
  static String getProp(String key) {
    return PropertiesUtil.propertiesMap()[key].toString();
  }

  static Map propertiesMap() {
    Map aMap = {
      "app-id": "flutter-template",
      "app-name": "flutter-template 1.0",
      "apiUrl": "https://flutter-backend.imagworkshop.com/wp-json/wp/v2/",
      "app-version": "0.0.1",
      "pageid-initparam": 10
    };
    return aMap;
  }
}
