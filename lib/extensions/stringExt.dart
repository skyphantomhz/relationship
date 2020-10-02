import 'package:relationship/model/gender.dart';
import 'package:relationship/extensions/genderExt.dart';

extension StringExt on String {
  Gender get gender {
    return Gender.values.firstWhere((element) => element.inString == this);
  }
}
