import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app/strings_app.dart';
import 'package:flutter_styra/models/device/device_model.dart';
import 'package:flutter_styra/screens/devices/energenie/tabs/energenie_time_schedule_edit.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:flutter_styra/shared/widgets/appBar/text.dart';
import 'package:flutter_styra/shared/widgets/loading/loading.dart';
import 'package:provider/provider.dart';

import 'screens/energenie_edit/energenie_edit.dart';
import 'tabs/energenie_overview_page.dart';
import 'tabs/energenie_remote_control.dart';

class EnergeniePage extends StatefulWidget {
  final String title;

  EnergeniePage({@required this.title});

  @override
  EenergeniePageState createState() => EenergeniePageState();
}

class EenergeniePageState extends State<EnergeniePage> {
  int _selectedPage = 0;
  List<Widget> _pageOptions = [];

  DeviceModel _device;

  @override
  Widget build(BuildContext context) {
    _device = Provider.of<DeviceModel>(context);
    final theme = Provider.of<ThemeService>(context);

    if (_device == null) {
      return Loading();
    }

    _pageOptions = [
      EnergenieOverviewPage(
        device: _device,
      ),
      EnergenieTimeSchedule(
        device: _device,
      ),
      EnergenieRemoteControl(
        device: _device,
      )
    ];

    final fontSize = 12.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          FlatButton(
            child: AppBarText(
              string: StringsApp().other.titles.edit,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EnergenieEditScreen(device: _device);
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
