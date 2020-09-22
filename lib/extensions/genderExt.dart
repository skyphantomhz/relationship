import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:relationship/model/gender.dart';

extension GenderExt on Gender {
  String get inString => describeEnum(this);

  IconData get icon {
    switch (this) {
      case Gender.Male:
        return FontAwesomeIcons.mars;
      case Gender.Female:
        return FontAwesomeIcons.venus;
      case Gender.Transgender:
        return FontAwesomeIcons.transgenderAlt;
      case Gender.Lesbian:
        return FontAwesomeIcons.venusDouble;
      default:
        return FontAwesomeIcons.marsDouble;
    }
  }
}
