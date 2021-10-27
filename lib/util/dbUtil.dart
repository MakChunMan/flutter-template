import 'package:sqflite/sqflite.dart';

class DBUtil {
  static var db;

  static Future<String> initDB() async {
    print('initDB() started:' + await getDatabasesPath());
    db = await openDatabase('localstorage.db', version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
          create table LocalStorage(
            Id integer primary key autoincrement, 
            Key varchar not null,
            Value text not null)
          ''');
    });
    return new Future.value("Done");
  }

  checkDB() {
    if (db == null) {
      initDB();
    }
  }
}
