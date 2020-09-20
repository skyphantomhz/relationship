import 'package:flutter/foundation.dart';
import 'package:relationship/model/gender.dart';

extension GenderExt on Gender {
  String get inString => describeEnum(this);
}
