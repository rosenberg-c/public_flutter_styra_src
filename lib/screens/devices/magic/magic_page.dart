import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app/strings_app.dart';
import 'package:flutter_styra/models/devices/magic/magic_device_model.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:flutter_styra/shared/widgets/appBar/text.dart';
import 'package:flutter_styra/shared/widgets/loading/loading.dart';
import 'package:provider/provider.dart';

import 'screens/magic_edit/magic_edit.dart';
import 'tabs/magic_overview_page.dart';
import 'tabs/magic_remote_control.dart';
import 'tabs/magic_time_schedule_edit.dart';

class MagicPage extends StatefulWidget {
  final MagicDeviceModel device;

  MagicPage({@required this.device});

  @override
  _MagicPageState createState() => _MagicPageState();
}

class _MagicPageState extends State<MagicPage> {
  int _selectedPage = 0;
  List<Widget> _pageOptions = [];

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeService>(context);

    if (widget.device == null) {
      return Loading();
    }

    _pageOptions = [
      MagicOverviewPage(
        device: widget.device,
      ),
      MagicTimeDeltaEdit(
        device: widget.device,
      ),
      MagicRemoteControl(
        device: widget.device,
      )
    ];

    final fontSize = 12.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
        actions: <Widget>[
          FlatButton(
            child: AppBarText(
              string: StringsApp().other.titles.edit,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MagicEditScreen(currentDevice: widget.device);
              }));
            },
          )
        ],
      ),
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        selectedFontSize: fontSize,
        unselectedFontSize: fontSize,
        selectedItemColor: theme.bottomNavigationBarSelected,
        unselectedItemColor: theme.bottomNavigationBarUnSelected,
        backgroundColor: theme.bottomNavigationBarBackground,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(StringsApp().other.titles.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text(StringsApp().other.titles.time),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_remote),
            title: Text(StringsApp().other.titles.remote),
          )
        ],
      ),
    );
  }
}
