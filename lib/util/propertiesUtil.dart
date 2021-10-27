import "../restservice/propertiesRestService.dart";
import "localstorageUtil.dart";

class PropertiesUtil {
  static Map initParamMap = {
    "app-id": "flutter-template",
    "app-name": "flutter-template 1.0",
    "apiUrl": "https://flutter-backend.imagworkshop.com/wp-json/wp/v2",
    "app-version": "0.0.1",
    "pageid-initparam": 57
  };

  static final PropertiesRestService restService = PropertiesRestService();

  static String getProp(String key) {
    if (propertiesMap[key] != null) {
      return propertiesMap[key].toString();
    } else {
      return LocalStorageUtil.getFromStorage(key);
    }
  }

  static Map propertiesMap = new Map();

  static Future<String> loadMap() async {
    propertiesMap.addAll(initParamMap);

    Future<Map> propertiesMapFromWP = restService.getAppProperitesFromWPpage();
    Map m = await propertiesMapFromWP;
    propertiesMap.addAll(m["properties"]);
    print("Loading param done (map size:" + propertiesMap.length.toString() + ")");
    print("Save into localStorage");
    LocalStorageUtil.clearStorage();
    propertiesMap.keys.forEach((k) {
      print(k + ":" + propertiesMap[k].toString());
      LocalStorageUtil.saveToStorage(k, propertiesMap[k].toString());
    });

    return Future.value("Done");
    /**
    propertiesMapFromWP.then((m) {
      propertiesMap.addAll(m["properties"]);
      print("Loading param done (map size:" + propertiesMap.length.toString() + ")");
      propertiesMap.keys.forEach((k) => print(k + ":" + propertiesMap[k].toString()));
    }).whenComplete(() => return Future.value("Done"));
     */

    /**
    Map propertiesMapFromWP = await restService.getAppProperitesFromWPpage();
    aMap.addAll(propertiesMapFromWP);
    return propertiesMapFromWP;
     */
  }

  static final String appId = "app-id";
  static final String appName = "app-name";
  static final String apiURL = "apiUrl";
  static final String appVersion = "app-version";
  static final String pageid_initparam = "pageid-initparam";
}
