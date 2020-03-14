import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

Future<T> getIntegerDialog<T>({
  @required BuildContext context,
  @required Text title,
  @required int initialValue,
  @required int min,
  @required int max,
}) {
  return showDialog<T>(
    context: context,
    builder: (BuildContext context) {
      return NumberPickerDialog.integer(
        minValue: min,
        maxValue: max,
        title: title,
        initialIntegerValue: initialValue,
      );
    },
  );
}
// dialogBackgroundColor
