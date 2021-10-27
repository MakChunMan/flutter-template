import "../restservice/propertiesRestService.dart";

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
    return PropertiesUtil.propertiesMap[key].toString();
  }

  static Map propertiesMap = new Map();

  static void loadMap() async {
    propertiesMap.addAll(initParamMap);

    Future<Map> propertiesMapFromWP = restService.getAppProperitesFromWPpage();
    propertiesMapFromWP.then((m) {
      print(m);
      propertiesMap.addAll(m["properties"]);
      print("Loading param done (map size:" + propertiesMap.length.toString() + ")");
    });
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
