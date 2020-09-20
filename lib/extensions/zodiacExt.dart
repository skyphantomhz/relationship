import 'package:flutter/foundation.dart';
import 'package:relationship/model/zodiac.dart';

extension ZodiacExt on Zodiac {
  String get inString => describeEnum(this);
}
