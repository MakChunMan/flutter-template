import 'package:sqflite/sqflite.dart';

class DBUtil {
  static var db;

  static initDB() async {
    print('initDB() started');
    db = await openDatabase('localstorage.db', version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
          create table LocalStorage(
            Id integer primary key autoincrement, 
            Key varchar not null,
            Value text not null)
          ''');
    });
  }

  checkDB() {
    if (db == null) {
      initDB();
    }
  }
}
