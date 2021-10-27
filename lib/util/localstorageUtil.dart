import 'dart:convert';
import 'package:http/http.dart';
import 'post_model.dart';
import 'wppage_menu_model.dart';
import 'propertiesUtil.dart';

import 'package:localstorage/localstorage.dart';

class LocalStorageUtil {
  final LocalStorage storage = new LocalStorage('lstore.json');
}
