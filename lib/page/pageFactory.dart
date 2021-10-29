library jasonPage;

import 'pageExport.dart';

class PageFactory {
  static dynamic getPageInstance(String classname, Map<String, dynamic> param) {
    print("Request page name: " + classname);
    if (classname == "generic") {
      return GenericPage(pageId: param["pageId"].toString());
    }
  }
}
