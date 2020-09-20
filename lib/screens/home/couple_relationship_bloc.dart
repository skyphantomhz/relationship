import 'package:relationship/base/bloc.dart';
import 'package:relationship/model/gender.dart';
import 'package:relationship/model/person.dart';
import 'package:rxdart/rxdart.dart';

class CoupleRelationshipBloc extends Bloc {
  BehaviorSubject<Person> _me = new BehaviorSubject.seeded(Person(
      avatarUrl: "assets/images/monster_male_face.jpg",
      name: "Shusui",
      gender: Gender.Male,
      dateOfBirth: 830710800000));
  Stream<Person> get me => _me.stream;

  Subject<Person> _partner = new BehaviorSubject.seeded(Person(
      avatarUrl: "assets/images/monster_female_face.jpg",
      name: "Olinn",
      gender: Gender.Female,
      dateOfBirth: 831229200000));
  Stream<Person> get partner => _partner.stream;

  @override
  void dispose() {
    _me.close();
    _partner.close();
  }

  void updateMyName(Future<String> nameFuture) async {
    final cloneMyProfile = _me.value;
    cloneMyProfile.name = await nameFuture;
    _me.sink.add(cloneMyProfile);
  }

  void updateMyDob(Future<DateTime> dobFuture) async {
    final cloneMyProfile = _me.value;
    cloneMyProfile.dob = await dobFuture;
    _me.sink.add(cloneMyProfile);
  }
}
