import 'package:flutter/widgets.dart';
import 'package:flutter_picker/Picker.dart';

getWeightPicker(
    {BuildContext ctx, List<int> weights, int weight, Function onSelected}) {
  showPickerModal(BuildContext context) {
    int selected = weights.indexOf(weight) != -1 ? weights.indexOf(weight) : 0;
    Picker(
      selecteds: [selected],
      adapter: PickerDataAdapter(
          data: weights
              .map(
                (v) => PickerItem(
                  text: Text(v.toString()),
                ),
              )
              .toList()),
      //changeToFirst: true,
      hideHeader: false,
      onSelect: (picker, col, val) {
        onSelected(val[0]);
      },
    ).showModal(ctx); //_scaffoldKey.currentState);
  }

  return showPickerModal(ctx);
}
