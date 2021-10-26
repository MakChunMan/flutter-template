import 'package:global_configuration/global_configuration.dart';

class PropertiesUtil {
  static String getProp(String key) {
    return GlobalConfiguration().getValue(key);
  }
}
