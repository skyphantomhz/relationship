import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:relationship/constants.dart';
import 'package:relationship/model/gender.dart';
import 'package:relationship/model/person.dart';
import 'package:relationship/extensions/zodiacExt.dart';
import 'package:relationship/extensions/genderExt.dart';
import 'package:relationship/screens/home/components/text_dialog.dart';
import 'package:relationship/screens/home/home_screen.dart';

class CoupleProfile extends StatelessWidget {
  const CoupleProfile({Key key, this.person, this.callback}) : super(key: key);

  final Person person;
  final ProfileCallback callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage(person.avatarUrl ?? ''),
          radius: 70,
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              final nameFuture =
                  updateTextDialog(context, "Edit name", person.name);
              callback.onEditName(nameFuture);
            },
            child: Text(
              person.name ?? '',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          InkWell(
            onTap: () => _showModalBottomSheet(context),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kDefaultPadding),
                    color: kPrimaryColor),
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: kTextColor,
                          textBaseline: TextBaseline.alphabetic),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            person.gender.icon,
                            size: 14,
                            color: kTextColor,
                          ),
                        ),
                        WidgetSpan(child: SizedBox(width: 8)),
                        TextSpan(text: person.age ?? '')
                      ]),
                )),
          ),
          SizedBox(
            width: kDefaultPadding,
          ),
          InkWell(
            onTap: () {
              final dobFuture = showDateDialog(context, person.birthday);
              callback.onEditDob(dobFuture);
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kDefaultPadding),
                    color: kPrimaryColor),
                alignment: Alignment.center,
                child: RichText(
                  text:
                      TextSpan(style: TextStyle(color: kTextColor), children: [
                    WidgetSpan(
                        child: SvgPicture.asset(
                      person.zodiacIcon ?? '',
                      width: 14,
                      height: 14,
                      color: kTextColor,
                    )),
                    WidgetSpan(child: SizedBox(width: 8)),
                    TextSpan(text: person.zodiac.inString ?? '')
                  ]),
                )),
          )
        ])
      ],
    );
  }

  void _showModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(FontAwesomeIcons.transgenderAlt),
                    title: new Text('Gender'),
                    onTap: () {
                      Navigator.pop(context);
                      _showModalGenderBottomSheet(context);
                    }),
                new ListTile(
                  leading: new Icon(FontAwesomeIcons.calendar),
                  title: new Text('Date of birth'),
                  onTap: () {
                    Navigator.pop(context);
                    final dobFuture = showDateDialog(context, person.birthday);
                    callback.onEditDob(dobFuture);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _showModalGenderBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Column(
              mainAxisSize: MainAxisSize.min,
              children: Gender.values
                  .map<Widget>((item) => ListTile(
                      leading: Icon(
                        item.icon,
                        color: kTextSufaceColor,
                      ),
                      title: Text(item.inString),
                      onTap: () {
                        Navigator.pop(context);
                        callback.onEditGender(Future.value(item));
                      }))
                  .toList());
        });
  }

  Future<String> updateTextDialog(
      BuildContext context, String title, String textInput) async {
    return showDialog(
        child: TextDialog(textInput, title: title), context: context);
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
}
