import 'package:flutter/material.dart';
import 'package:relationship/model/gender.dart';
import 'package:relationship/model/zodiac.dart';
import 'package:relationship/extensions/intExt.dart';
import 'package:relationship/extensions/dateTimeExt.dart';
import 'package:relationship/extensions/zodiacExt.dart';

class Person extends ChangeNotifier {

  static String name;
  int _dob;
  Gender gender;
  String avatarUrl;

  int id;
  String name;
  int _dob;
  Gender gender;
  String avatarUrl;
  Person({this.avatarUrl, int dateOfBirth, this.gender, this.name}) {
    setDob(dateOfBirth);
  }

  set dob(DateTime value) {
    if (value != null) {
      _dob = value.millisecondsSinceEpoch;
      birthday = value;
      zodiac = birthday.toZodiacFormat.toZodiac();
      zodiacIcon = "assets/images/zodiac/${zodiac.inString.toLowerCase()}.svg";
      age = getAge();
    }
  }

  void setDob(int value) {
    if (value != null) {
      dob = birthday = DateTime.fromMillisecondsSinceEpoch(value);
    }
  }

  String age;
  Zodiac zodiac;
  DateTime birthday;
  String zodiacIcon;

  String getAge() {
    DateTime currentDate = DateTime.now();
    final dateOfBirth = DateTime.fromMillisecondsSinceEpoch(_dob);
    int age = currentDate.year - dateOfBirth.year;
    int currentMonth = currentDate.month;
    int monthOfBirth = dateOfBirth.month;
    if (monthOfBirth > currentMonth ||
        (currentMonth == monthOfBirth && dateOfBirth.day > currentDate.day)) {
      age--;
    }
    return age.toString();
  }

   Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iDob = json['_dob'];
    gender = json['gender'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['_dob'] = this.iDob;
    data['gender'] = this.gender;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}
