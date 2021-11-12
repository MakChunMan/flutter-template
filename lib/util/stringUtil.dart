import 'package:html/parser.dart';

class StringUtil {
  static bool isNullOrEmpty(String str) {
    return (str == null || str.trim == "");
  }

  static String removeHtmlTag(String str) {
    final document = parse(str);
    return parse(document.body.text).documentElement.text;
  }

  static String trim(String str, int maxlength) {
    if (str.length > maxlength) {
      return str.substring(1, maxlength);
    } else {
      return str;
    }
  }

  static List<String> split(String string, String separator, {int max = 0}) {
    List<String> result = [];

    if (separator.isEmpty) {
      result.add(string);
      return result;
    }

    while (true) {
      var index = string.indexOf(separator, 0);
      if (index == -1 || (max > 0 && result.length >= max)) {
        result.add(string);
        break;
      }

      result.add(string.substring(0, index));
      string = string.substring(index + separator.length);
    }

    return result;
  }
}
