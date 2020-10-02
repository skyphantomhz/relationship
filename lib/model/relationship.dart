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

  RelationShip.fromJson(Map<String, dynamic> json) {
    id = json[columnId];
    title = json[columnTitle];
    startDate = json[columnStartDate];
    unit = json[columnUnit];
    isCouple = json[columnIsCouple] == 1;
    if (json[columnPersons] != null) {
      persons = new List<Person>();
      json['persons'].forEach((v) {
        persons.add(new Person.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[columnId] = this.id;
    data[columnTitle] = this.title;
    data[columnStartDate] = this.startDate;
    data[columnUnit] = this.unit;
    data[columnIsCouple] = this.isCouple == true ? 1 : 0;
    if (this.persons != null) {
      data[columnPersons] = this.persons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
