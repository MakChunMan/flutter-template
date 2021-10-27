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
    List<PopupMenuItem> items = new List<PopupMenuItem>();
    menuItems.forEach((s) => {
          items.add(new PopupMenuItem(child: s["name"], value: s["page-id"]))
        });
    return PopupMenuButton(icon: Icon(Icons.more_horiz), itemBuilder: (context) => menuItems);
  }
}
