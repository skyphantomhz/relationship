import 'package:relationship/model/zodiac.dart';

extension IntExt on int {
  bool inRange(int first, int second) {
    return first <= this && this <= second;
  }

  Zodiac toZodiac() {
    Zodiac result;
    if (this.inRange(120, 218)) {
      result = Zodiac.Aquarius;
    } else if (this.inRange(219, 320)) {
      result = Zodiac.Pisces;
    } else if (this.inRange(321, 419)) {
      result = Zodiac.Aries;
    } else if (this.inRange(420, 520)) {
      result = Zodiac.Taurus;
    } else if (this.inRange(521, 620)) {
      result = Zodiac.Gemini;
    } else if (this.inRange(621, 722)) {
      result = Zodiac.Cancer;
    } else if (this.inRange(723, 822)) {
      result = Zodiac.Leo;
    } else if (this.inRange(823, 922)) {
      result = Zodiac.Virgo;
    } else if (this.inRange(923, 1022)) {
      result = Zodiac.Libra;
    } else if (this.inRange(1023, 1121)) {
      result = Zodiac.Scorpio;
    } else if (this.inRange(1122, 1221)) {
      result = Zodiac.Sagittarius;
    } else {
      result = Zodiac.Capricorn;
    }
    return result;
  }
}