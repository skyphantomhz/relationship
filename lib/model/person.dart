import 'package:flutter/material.dart';
import 'package:relationship/model/gender.dart';
import 'package:relationship/model/zodiac.dart';
import 'package:relationship/extensions/intExt.dart';
import 'package:relationship/extensions/dateTimeExt.dart';
import 'package:relationship/extensions/zodiacExt.dart';
import 'package:relationship/extensions/genderExt.dart';
import 'package:relationship/extensions/stringExt.dart';

class Person extends ChangeNotifier {

  static String tablePerson = "person";
  static String columnId = "_id";
  static String columnName = "name";
  static String columnDob = "dob";
  static String columnGender = "gender";
  static String columnAvatarUrl = "avatarUrl";

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
    id = json[columnId];
    name = json[columnName];
    setDob(json[columnDob]);
    gender = json[columnGender].toString().gender;
    avatarUrl = json[columnAvatarUrl];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[columnId] = this.id;
    data[columnName] = this.name;
    data[columnDob] = this._dob;
    data[columnGender] = this.gender.inString;
    data[columnAvatarUrl] = this.avatarUrl;
    return data;
  }
}
