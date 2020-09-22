import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:relationship/constants.dart';
import 'package:relationship/model/gender.dart';
import 'package:relationship/model/person.dart';
import 'package:relationship/screens/home/components/couple_profile.dart';
import 'package:relationship/screens/home/components/text_dialog.dart';
import 'package:relationship/screens/home/couple_relationship_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

  DateTime fallInLoveDate = DateTime.now();
  String unit = "days";
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
        onEditAvatar: (Future<String> avatar) {},
        onEditGender: (Future<Gender> gender) {
          _coupleBloc.updateMyGender(gender);
        },
        context: context);

    partnerProfileCallback = ProfileCallback(
        onEditName: (Future<String> name) {},
        onEditDob: (Future<DateTime> dob) {},
        onEditAvatar: (Future<String> avatar) {},
        onEditGender: (Future<Gender> gender) {},
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("fall in love",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: kTextSufaceColor)),
                  InkWell(
                    onTap: () {
                      showDateDialog(context, DateTime.now());
                    },
                    child: Text(getFallInLoveDays(),
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: kTextSufaceColor)),
                  ),
                  InkWell(
                    onTap: () {
                      showTextDialog(context, "Textinput", widget.unit);
                    },
                    child: Text(widget.unit,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: kTextSufaceColor)),
                  )
                ],
              ),
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

  void showTextDialog(
      BuildContext context, String title, String textInput) async {
    final unit = await showDialog(
        child: TextDialog(textInput, title: title), context: context);
    setState(() {
      if (unit != null) {
        widget.unit = unit;
      }
    });
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

  String getFallInLoveDays() {
    return DateTime.now().difference(widget.fallInLoveDate).inDays.toString();
  }

  @override
  void dispose() {
    _coupleBloc.dispose();
    super.dispose();
  }
}

typedef OnEditName = void Function(Future<String> name);
typedef OnEditDob = void Function(Future<DateTime> dob);
typedef OnEditAvatar = void Function(Future<String> avatar);
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
