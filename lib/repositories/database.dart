import 'package:relationship/model/relationship.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table ${RelationShip.tableRelationShip} ( 
          ${RelationShip.columnId} integer primary key autoincrement, 
          ${RelationShip.columnTitle} text not null,
          ${RelationShip.columnStartDate} integer not null,
          ${RelationShip.columnUnit} text not null,
          ${RelationShip.columnIsCouple} integer not null,
          ${RelationShip.columnPersons} text not null)s
      ''');
    });
  }

  Future<RelationShip> insert(RelationShip relationShip) async {
    await db.insert(RelationShip.tableRelationShip, relationShip.toJson());
    return relationShip;
  }

  Future<RelationShip> getRelationShip() async {
    List<Map> maps = await db.query(RelationShip.tableRelationShip, columns: [
      RelationShip.columnId,
      RelationShip.columnTitle,
      RelationShip.columnStartDate,
      RelationShip.columnUnit,
      RelationShip.columnIsCouple,
      RelationShip.columnPersons
    ]);
    if (maps.length > 0) {
      return RelationShip.fromJson(maps.first);
    }
    return null;
  }

  Future<int> update(RelationShip relationShip) async {
    return await db.update(
        RelationShip.tableRelationShip, relationShip.toJson(),
        where: '${RelationShip.columnId} = ?', whereArgs: [relationShip.id]);
  }

  Future close() async => db.close();
}
