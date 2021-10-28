import 'package:flutter/material.dart';

class AppBarComponent {
  static AppBar getAppBar(String title, List<dynamic> menuItems) {
    PopupMenuButton popupMenuButton = null;
    List<Widget> topButtonList = new List<Widget>();

    if (menuItems != null) {
      popupMenuButton = getPopupMenuButton(menuItems);
      topButtonList.add(popupMenuButton);
    }
    return AppBar(
      title: Text(title),
      actions: topButtonList,
    );
  }

  static PopupMenuButton getPopupMenuButton(List<dynamic> menuItems) {
    //List items = new List();
    if (menuItems == null || menuItems.length == 0) {
      print("menuItems is null");
      return null;
    }
    List newList = new List<PopupMenuItem>();
    menuItems.forEach((s) {
      print(s["name"] + s["page-id"]);
      newList.add(new PopupMenuItem(child: Text(s["name"]), value: s["page-id"]));
    });

    print("items" + newList.length.toString());
    /**
    menuItems.forEach((s) => {
          items.add(PopupMenuItem(child: s["name"], value: s["page-id"]))
        });
      */
    return PopupMenuButton(icon: Icon(Icons.more_horiz), itemBuilder: (context) => newList
        /**
      itemBuilder: (context) {
                  return menuItems.map((PopupItem choice) {
                    return PopupMenuItem(
                      value: choice,
                      child: Text(choice.name),
                    );
                  }).toList();
                } */
        );
  }
}
