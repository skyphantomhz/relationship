
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relationship/base/bloc.dart';
import 'package:relationship/model/gender.dart';
import 'package:relationship/model/person.dart';
import 'package:relationship/model/relationship.dart';
import 'package:relationship/repositories/dao/relationshipdao.dart';
import 'package:relationship/repositories/filerepository.dart';
import 'package:rxdart/rxdart.dart';

class CoupleRelationshipBloc extends Bloc {
  final RelationShipDao _relationShipDao = GetIt.I<RelationShipDao>();
  final FileRepository _fileRepository = GetIt.I<FileRepository>();

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
    _getData();
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
    _saveRelationShip(cloneRelationShip);
  }

  void updateMyDob(Future<DateTime> dobFuture) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.persons.first.dob = await dobFuture;
    _relationShip.add(cloneRelationShip);
    _saveRelationShip(cloneRelationShip);
  }

  void updateMyGender(Future<Gender> gender) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.persons.first.gender = await gender;
    _relationShip.add(cloneRelationShip);
    _saveRelationShip(cloneRelationShip);
  }

  void updatePartnerName(Future<String> nameFuture) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.persons.last.name = await nameFuture;
    _relationShip.add(cloneRelationShip);
    _saveRelationShip(cloneRelationShip);
  }

  void updatePartnerDob(Future<DateTime> dobFuture) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.persons.last.dob = await dobFuture;
    _relationShip.add(cloneRelationShip);
    _saveRelationShip(cloneRelationShip);
  }

  void updatePartnerGender(Future<Gender> gender) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.persons.last.gender = await gender;
    _relationShip.add(cloneRelationShip);
    _saveRelationShip(cloneRelationShip);
  }

  void updateStartRelationShip(Future<DateTime> startDate) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.startInDate = await startDate;
    _relationShip.add(cloneRelationShip);
    _saveRelationShip(cloneRelationShip);
  }

  void updateUnit(Future<String> unit) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.unit = await unit;
    _relationShip.add(cloneRelationShip);
    _saveRelationShip(cloneRelationShip);
  }

  void updateTitle(Future<String> titleFuture) async {
    final cloneRelationShip = _relationShip.value;
    cloneRelationShip.title = await titleFuture;
    _relationShip.add(cloneRelationShip);
    _saveRelationShip(cloneRelationShip);
  }

  void _saveRelationShip(RelationShip relationShip) {
    _relationShipDao.update(relationShip);
  }

  void _getData() async {
    final relationShip = await _relationShipDao.getRelationShip();
    if (relationShip == null) {
      final added = await _relationShipDao.insert(_initialRelationShip);
      _relationShip.add(added);
    } else {
      _relationShip.add(relationShip);
    }
  }

  final _initialRelationShip = RelationShip(
      title: "Fall in love",
      startDate: DateTime.now().millisecondsSinceEpoch,
      unit: "days",
      isCouple: true,
      persons: [
        Person(
            avatarUrl: "assets/images/monster_male_face.jpg",
            name: "My name",
            gender: Gender.Male,
            dateOfBirth: 830710800000),
        Person(
            avatarUrl: "assets/images/monster_female_face.jpg",
            name: "Patner name",
            gender: Gender.Female,
            dateOfBirth: 831229200000)
      ]);

  void updateMyAvatar(Future<PickedFile> avatar) async {
    final cloneRelationShip = _relationShip.value;
    PickedFile file = await avatar;
    final path = _fileRepository.saveFile(
        File.fromRawPath(await file.readAsBytes()),
        FileRepository.generateImageName());
    final oldAvatarPath = cloneRelationShip.persons.first.avatarUrl;
    cloneRelationShip.persons.first.avatarUrl = await path;
    _relationShip.add(cloneRelationShip);
    _saveRelationShip(cloneRelationShip);
    _fileRepository.deleteFile(oldAvatarPath);
  }
}
