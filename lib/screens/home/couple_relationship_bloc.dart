import 'package:relationship/base/bloc.dart';
import 'package:relationship/model/gender.dart';
import 'package:relationship/model/person.dart';
import 'package:relationship/model/relationship.dart';
import 'package:rxdart/rxdart.dart';

class CoupleRelationshipBloc extends Bloc {
  BehaviorSubject<Person> _me = new BehaviorSubject();
  Stream<Person> get me => _me.stream;

  BehaviorSubject<Person> _partner = new BehaviorSubject();
  Stream<Person> get partner => _partner.stream;

  BehaviorSubject<RelationShip> _relationShip = new BehaviorSubject();
  Stream<RelationShip> get relationShip => _relationShip.stream;

  CoupleRelationshipBloc() {
    relationShip.listen((value) {
      if (value != null) {
        _me.add(value.persons.first);
        _partner.add(value.persons.last);
      }
    });
    _relationShip.add(RelationShip(
        title: "Fall in love",
        startDate: 1595869200000,
        unit: "days",
        isCouple: true,
        persons: [
          Person(
              avatarUrl: "assets/images/monster_male_face.jpg",
              name: "Shusui",
              gender: Gender.Male,
              dateOfBirth: 830710800000),
          Person(
              avatarUrl: "assets/images/monster_female_face.jpg",
              name: "Olinn",
              gender: Gender.Female,
              dateOfBirth: 831229200000)
        ]));
  }

  @override
  void dispose() {
    _me.close();
    _partner.close();
  }

  void updateMyName(Future<String> nameFuture) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.persons.first.name = await nameFuture;
    _relationShip.add(cloneRelationShip);
  }

  void updateMyDob(Future<DateTime> dobFuture) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.persons.first.dob = await dobFuture;
    _relationShip.add(cloneRelationShip);
  }

  void updateMyGender(Future<Gender> gender) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.persons.first.gender = await gender;
    _relationShip.add(cloneRelationShip);
  }

  void updatePartnerName(Future<String> nameFuture) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.persons.last.name = await nameFuture;
    _relationShip.add(cloneRelationShip);
  }

  void updatePartnerDob(Future<DateTime> dobFuture) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.persons.last.dob = await dobFuture;
    _relationShip.add(cloneRelationShip);
  }

  void updatePartnerGender(Future<Gender> gender) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.persons.last.gender = await gender;
    _relationShip.add(cloneRelationShip);
  }

  void updateStartRelationShip(Future<DateTime> startDate) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.startInDate = await startDate;
    _relationShip.add(cloneRelationShip);
  }

  void updateUnit(Future<String> unit) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.unit = await unit;
    _relationShip.add(cloneRelationShip);
  }

  void updateTitle(Future<String> titleFuture) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.title = await titleFuture;
    _relationShip.add(cloneRelationShip);
  }
}
