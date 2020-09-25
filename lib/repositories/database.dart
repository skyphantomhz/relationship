import 'package:relationship/model/relationship.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $tableRelationShip ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDone integer not null)
      ''');
    });
  }

  Future<RelationShip> insert(RelationShip relationShip) async {
    await db.insert(tableRelationShip, relationShip.toMap());
    return relationShip;
  }

  Future<RelationShip> getRelationShip() async {
    List<Map> maps = await db
        .query(tableRelationShip, columns: [columnId, columnDone, columnTitle]);
    if (maps.length > 0) {
      return RelationShip.fromMap(maps.first);
    }
    return null;
  }

  Future<int> update(RelationShip relationShip) async {
    return await db.update(tableRelationShip, relationShip.toMap(),
        where: '$columnId = ?', whereArgs: [relationShip.id]);
  }

  Future close() async => db.close();
}
