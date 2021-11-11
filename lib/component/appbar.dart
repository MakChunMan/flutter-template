import 'package:flutter/material.dart';
import '../util/wppage_menu_model.dart';
import '../util/stringUtil.dart';
import '../page/pageFactory.dart';

class AppBarComponent {
  static AppBar getAppBar(BuildContext context, String title, List<dynamic> menuItems) {
    PopupMenuButton popupMenuButton;
    List<Widget> topButtonList = [];
    ;

    if (menuItems != null) {
      popupMenuButton = getPopupMenuButton(context, menuItems);
      topButtonList.add(popupMenuButton);
    }
    return AppBar(
      title: Text(title),
      actions: topButtonList,
    );
  }

  static PopupMenuButton getPopupMenuButton(BuildContext context, List<MenuItem> menuItems) {
    //List items = new List();
    if (menuItems == null || menuItems.length == 0) {
      print("menuItems is null");
      return null;
    }
    List<PopupMenuItem> newList = [];
    menuItems.forEach((s) {
      print(s.name + s.pageid);
      newList.add(new PopupMenuItem(
        child: Text(s.name),
        value: s.pageid + (s.pagecode == null ? "" : ("-" + s.pagecode)),
      ));
    });

    return PopupMenuButton(
        icon: Icon(Icons.more_horiz),
        onSelected: (result) {
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => GenericPage(pageId: result)),
            MaterialPageRoute(builder: (context) {
              var paramMap;
              List<String> a = StringUtil.split(result, "-", max: 1);
              if (a.length == 2) {
                //If it is a type specific page, the format of "result" is "pageid-pagecode"
                //a[0]: pageid; a[1]: pagecode
                paramMap = {
                  'pageId': a[0]
                };
                return PageFactory.getPageInstance(a[1], paramMap);
              } else {
                paramMap = {
                  'pageId': result
                };
                return PageFactory.getPageInstance("generic", paramMap);
                ;
              }
            }),
          );
        },
        itemBuilder: (context) => newList);
  }
}
