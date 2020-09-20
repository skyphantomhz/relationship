import 'package:intl/intl.dart';

extension DateTimeExt on DateTime{
  int get toZodiacFormat{
    return int.parse(getDateFormat("MMdd"));
  }

  String getDateFormat(String format){
    final DateFormat formatter = DateFormat(format);
    return formatter.format(this);
  }
}