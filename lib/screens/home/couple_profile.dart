import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:relationship/constants.dart';

class CoupleProfile extends StatelessWidget {
  const CoupleProfile(
      {Key key, this.avatarUrl, this.name, this.gender, this.age, this.zodiac})
      : super(key: key);

  final String avatarUrl;
  final String name;
  final String gender;
  final String age;
  final String zodiac;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage(avatarUrl),
          radius: 70,
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Row(children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                  color: kPrimaryColor),
              margin: EdgeInsets.only(left: kDefaultPadding),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: kTextColor,
                        textBaseline: TextBaseline.alphabetic),
                    children: [
                      WidgetSpan(
                          child: SvgPicture.asset(
                        "assets/images/${gender.toLowerCase()}.svg",
                        width: 14,
                        height: 14,
                        color: kTextColor,
                      )),
                      WidgetSpan(child: SizedBox(width: 8)),
                      TextSpan(text: age)
                    ]),
              )),
          Spacer(),
          Container(
              margin: EdgeInsets.only(right: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                  color: kPrimaryColor),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(style: TextStyle(color: kTextColor), children: [
                  WidgetSpan(
                      child: SvgPicture.asset(
                    "assets/images/zodiac/${zodiac.toLowerCase()}.svg",
                    width: 14,
                    height: 14,
                    color: kTextColor,
                  )),
                  WidgetSpan(child: SizedBox(width: 8)),
                  TextSpan(text: zodiac)
                ]),
              ))
        ])
      ],
    );
  }
}
