import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relationship/constants.dart';
import 'package:relationship/model/gender.dart';
import 'package:relationship/model/person.dart';
import 'package:relationship/model/relationship.dart';
import 'package:relationship/screens/home/components/couple_profile.dart';
import 'package:relationship/screens/home/components/text_dialog.dart';
import 'package:relationship/screens/home/couple_relationship_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CoupleRelationshipBloc _coupleBloc = CoupleRelationshipBloc();
  ProfileCallback myProfileCallback;
  ProfileCallback partnerProfileCallback;

  @override
  void initState() {
    _coupleBloc = CoupleRelationshipBloc();

    myProfileCallback = ProfileCallback(
        onEditName: (Future<String> name) {
          _coupleBloc.updateMyName(name);
        },
        onEditDob: (Future<DateTime> dob) {
          _coupleBloc.updateMyDob(dob);
        },
        onEditAvatar: (Future<PickedFile> avatar) {
          _coupleBloc.updateMyAvatar(avatar);
        },
        onEditGender: (Future<Gender> gender) {
          _coupleBloc.updateMyGender(gender);
        },
        context: context);

    partnerProfileCallback = ProfileCallback(
        onEditName: (Future<String> name) {
          _coupleBloc.updatePartnerName(name);
        },
        onEditDob: (Future<DateTime> dob) {
          _coupleBloc.updatePartnerDob(dob);
        },
        onEditAvatar: (Future<PickedFile> avatar) {},
        onEditGender: (Future<Gender> gender) {
          _coupleBloc.updatePartnerGender(gender);
        },
        context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context = context;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/background.png',
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
            child: Container(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.4),
            child: Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                color: kSufaceColor,
                shape: BoxShape.circle,
              ),
              child: StreamBuilder<RelationShip>(
                  stream: _coupleBloc.relationShip,
                  builder: (context, snapshot) {
                    final relationShip = snapshot.data;
                    final startRelationShip =
                        relationShip?.startInDate ?? DateTime.now();
                    final unit = relationShip?.unit ?? "days";
                    final title = relationShip?.title ?? "Fall in love";
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            final titleFuture =
                                showTextDialog(context, "Text input", title);
                            _coupleBloc.updateTitle(titleFuture);
                          },
                          child: Text(title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: kTextSufaceColor)),
                        ),
                        InkWell(
                          onTap: () {
                            final startDate =
                                showDateDialog(context, startRelationShip);
                            _coupleBloc.updateStartRelationShip(startDate);
                          },
                          child: Text(getFallInLoveDays(startRelationShip),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(color: kTextSufaceColor)),
                        ),
                        InkWell(
                          onTap: () {
                            final unitFuture =
                                showTextDialog(context, "Text input", unit);
                            _coupleBloc.updateUnit(unitFuture);
                          },
                          child: Text(unit,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: kTextSufaceColor)),
                        )
                      ],
                    );
                  }),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: kDefaultPadding),
              child: Row(
                children: [
                  Expanded(
                      child: StreamBuilder<Person>(
                          stream: _coupleBloc.me,
                          builder: (context, snapshot) {
                            if (snapshot.data == null)
                              return Container();
                            else
                              return CoupleProfile(
                                  person: snapshot.data,
                                  callback: myProfileCallback);
                          })),
                  Expanded(
                      child: StreamBuilder<Object>(
                          stream: _coupleBloc.partner,
                          builder: (context, snapshot) {
                            if (snapshot.data == null)
                              return Container();
                            else
                              return CoupleProfile(
                                  person: snapshot.data,
                                  callback: partnerProfileCallback);
                          })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> showTextDialog(
      BuildContext context, String title, String textInput) async {
    return showDialog(
        builder: (context) => TextDialog(textInput, title: title),
        context: context);
  }

  Future<DateTime> showDateDialog(
      BuildContext context, DateTime initialDate) async {
    final current = DateTime.now();
    return showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1990),
        lastDate: current);
  }

  String getFallInLoveDays(DateTime startRelationShip) {
    return DateTime.now().difference(startRelationShip).inDays.toString();
  }

  @override
  void dispose() {
    _coupleBloc.dispose();
    super.dispose();
  }
}

typedef OnEditName = void Function(Future<String> name);
typedef OnEditDob = void Function(Future<DateTime> dob);
typedef OnEditAvatar = void Function(Future<PickedFile> avatar);
typedef OnEditGender = void Function(Future<Gender> gender);

class ProfileCallback {
  OnEditName onEditName;
  OnEditDob onEditDob;
  OnEditAvatar onEditAvatar;
  OnEditGender onEditGender;
  BuildContext context;
  ProfileCallback(
      {this.onEditName,
      this.onEditDob,
      this.onEditAvatar,
      this.onEditGender,
      this.context});
}
