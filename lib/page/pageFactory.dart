library jasonPage;

import 'pageExport.dart';

class PageFactory {
  static Map<String, Function> PageInstanceMap = {
    //"productcat": ProductCategoryPage.getInstance,
    "shopmain": ShopMainPage.getInstance,
  };

  static dynamic getPageInstance(String classname, Map<String, dynamic> param) {
    print("Request page name: " + classname);
    if (classname == "generic") {
      return GenericPage(pageId: param["pageId"].toString());
    } else {
      return Function.apply(PageInstanceMap[classname], [
        param
      ]);
    }
  }
}
