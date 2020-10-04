import 'package:get_it/get_it.dart';
import 'package:relationship/model/relationship.dart';
import 'package:relationship/repositories/database.dart';
import 'package:sqflite/sqflite.dart';

class RelationShipDao {
  Future<Database> get _database async => await DatabaseProvider.open();

  Future<RelationShip> insert(RelationShip relationShip) async {
    final database = await _database;
    await database.insert(RelationShip.tableRelationShip, relationShip.toJson());
    return relationShip;
  }

  Future<RelationShip> getRelationShip() async {
    final database = await _database;
    List<Map> maps = await database.query(RelationShip.tableRelationShip, columns: [
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
    final database = await _database;
    return await database.update(
        RelationShip.tableRelationShip, relationShip.toJson(),
        where: '${RelationShip.columnId} = ?', whereArgs: [relationShip.id]);
  }

}