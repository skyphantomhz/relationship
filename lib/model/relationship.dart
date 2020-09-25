import 'package:flutter/material.dart';
import 'package:relationship/model/person.dart';



class RelationShip extends ChangeNotifier {

  static String tableRelationShip = 'relationship';
  static String columnId = '_id';
  static String columnTitle = 'title';
  static String columnStartDate = 'startDate';
  static String columnUnit = 'unit';
  static String columnIsCouple = 'isCouple';
  static String columnPersons = 'persons';

  int id;
  String title;
  int startDate;
  String unit;
  bool isCouple;
  List<Person> persons;
  RelationShip(
      {this.title, this.startDate, this.unit, this.isCouple, this.persons});

  DateTime get startInDate => DateTime.fromMillisecondsSinceEpoch(startDate);

  set startInDate(DateTime value) {
    if (value != null) {
      startDate = value.millisecondsSinceEpoch;
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      RelationShip.columnTitle: title,
      columnDone: done == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    done = map[columnDone] == 1;
  }
}
