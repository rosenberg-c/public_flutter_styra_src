import 'package:flutter/material.dart';
import 'package:flutter_styra/models/devices/devices.dart';
import 'package:flutter_styra/screens/devices/energenie/energenie_page.dart';
import 'package:flutter_styra/screens/devices/magic/magic_page.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:flutter_styra/shared/constants/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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

Widget selectDevicePage(DeviceModel device) {
  if (device.type == DeviceItems.energenie) {
    return EnergeniePage(device: device);
  }

  return MagicPage(device: device);
}

class DeviceGridTileBuilder extends StatelessWidget {
  final DeviceModel device;

  DeviceGridTileBuilder({@required this.device});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeService>(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return selectDevicePage(device);
            }));
      },
      child: _buildTile(
        context: context,
        device: device,
        pColor: theme.pColor,
        label: device.name == "" ? " " : device.name,
      ),
    );
  }
}

_buildTile({context, device, pColor, label}) {
  return GridTile(
    child: Card(
      color: pColor[50],
      margin: EdgeInsets.all(12.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Colors.transparent,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
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
            child: Text(
              label,
              softWrap: false,
              style: TextStyle(color: pColor[500]),
            ),
          ),
        ],
      ),
    ),
  );
}
