import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:relationship/constants.dart';
import 'package:relationship/screens/home/couple_profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Text("60",
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: kTextSufaceColor)),
                  Text("Days",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: kTextSufaceColor))
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
                      child: CoupleProfile(
                          avatarUrl: "assets/images/monster_male_face.jpg",
                          name: "Shusui",
                          gender: "Male",
                          age: "24",
                          zodiac: "Taurus")),
                  Expanded(
                      child: CoupleProfile(
                          avatarUrl: "assets/images/monster_female_face.jpg",
                          name: "Olinn",
                          gender: "Female",
                          age: "24",
                          zodiac: "Taurus")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
