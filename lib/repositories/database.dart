import 'package:path/path.dart';
import 'package:relationship/model/relationship.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static Database _db;

  static Future<Database> open() async {
    if (_db != null) return _db;
    final databasesPath  = await getDatabasesPath();
    var path = join(databasesPath, 'data.db');
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table ${RelationShip.tableRelationShip} ( 
          ${RelationShip.columnId} integer primary key autoincrement, 
          ${RelationShip.columnTitle} text not null,
          ${RelationShip.columnStartDate} integer not null,
          ${RelationShip.columnUnit} text not null,
          ${RelationShip.columnIsCouple} integer not null,
          ${RelationShip.columnPersons} text not null)
      ''');
    });
    return _db;
  }

  static Database get database => _db;

  static Future close() async => _db.close();
}
