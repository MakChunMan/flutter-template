import 'package:flutter/material.dart';
import '../util/wppage_menu_model.dart';
import '../page/genericContentPage.dart';

class AppBarComponent {
  static AppBar getAppBar(BuildContext context, String title, List<dynamic> menuItems) {
    PopupMenuButton popupMenuButton = null;
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
        value: s.pageid,
      ));
    });

    return PopupMenuButton(
        icon: Icon(Icons.more_horiz),
        onSelected: (result) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GenericPage(result)),
          );
        },
        itemBuilder: (context) => newList);
  }
}
