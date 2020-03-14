import 'package:flutter/widgets.dart';

DateTime buildDateTimeObj(
    {year = 0,
    month = 1,
    day = 1,
    @required hour,
    @required minute,
    @required second,
    millisec = 0,
    microsec = 0}) {
  return DateTime(
    year,
    month,
    day,
    hour,
    minute,
    second,
    millisec,
    microsec,
  );
}
