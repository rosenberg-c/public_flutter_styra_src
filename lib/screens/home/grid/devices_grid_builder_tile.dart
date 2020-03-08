import 'package:flutter/material.dart';
import 'package:flutter_styra/models/device/device_model.dart';
import 'package:flutter_styra/screens/devices/devices.dart';
import 'package:flutter_styra/screens/devices/energenie/energenie_page.dart';
import 'package:flutter_styra/screens/devices/magic/magic_page.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:flutter_styra/shared/constants/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DeviceGridBuilderTile extends StatelessWidget {
  final DeviceModel device;
  final _ctrlName = TextEditingController();

  DeviceGridBuilderTile({@required this.device});

  pageToLoad(DeviceModel device) {
    if (device.type == DeviceItems.energenie) {
      return EnergeniePage(title: device.name);
    }
    return MagicPage(title: device.name);
  }

  _icon(String icon, context) {
    final theme = Provider.of<ThemeService>(context);
    return ConstrainedBox(
      constraints: new BoxConstraints(
        minHeight: 50.0,
        minWidth: 50.0,
        maxHeight: 68.0,
        maxWidth: 68.0,
      ),
      child: new SvgPicture.asset(
        icon,
        semanticsLabel: 'Logo',
        color: theme.pColor[500],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeService>(context);
    _ctrlName.text = device.name == "" ? " " : device.name;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Provider<DeviceModel>.value(
                value: device,
                child: pageToLoad(device),
              );
            },
          ),
        );
      },
      child: GridTile(
        child: Card(
          color: theme.pColor[50],
          margin: EdgeInsets.all(12.0),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                //color: theme.pColor[600],
                color: Colors.transparent,
                width: 1.0,
                style: BorderStyle.solid,
              )),
          elevation: 4.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(),
              device.type == DeviceItems.magic
                  ? _icon(Assets().icons.magic, context)
                  : _icon(Assets().icons.sunny, context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
//                  overflow: TextOverflow.ellipsis,
                    Text(
                  _ctrlName.text,
                  softWrap: false,
                  style: TextStyle(
                    color: theme.pColor[500],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

grid_style_box(Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
    child: Container(
      child: AnimatedContainer(
        height: 10,
        width: 10,
        duration: Duration(milliseconds: 100),
        color: color,
      ),
      //color: color,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.black87),
        //color: Colors.black87
      ),
    ),
  );
}
