import 'package:flutter/material.dart';
import 'package:relationship/model/person.dart';

class RelationShip extends ChangeNotifier {
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
}
