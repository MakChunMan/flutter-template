import 'package:flutter/material.dart';

class AppBarComponent {
  static AppBar getAppBar(String title, String menuJson) {
    PopupMenuButton popupMenuButton = null;
    List<Widget> topButtonList = new List<Widget>();

    if (menuJson != null) {
      popupMenuButton = getPopupMenuButton(menuJson);
      topButtonList.add(popupMenuButton);
    }
    return AppBar(
      title: Text(title),
      actions: topButtonList,
    );
  }

  static PopupMenuButton getPopupMenuButton(String menuJson) {
    return PopupMenuButton(
        icon: Icon(Icons.more_horiz),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("First"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Second"),
                value: 2,
              )
            ]);
  }
}
