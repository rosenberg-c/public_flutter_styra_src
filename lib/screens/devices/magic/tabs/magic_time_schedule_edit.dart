import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_styra/models/devices/magic/magic_device_model.dart';
import 'package:flutter_styra/models/devices/magic/magic_schedule_config.dart';
import 'package:flutter_styra/screens/devices/support/date.dart';
import 'package:flutter_styra/screens/devices/support/dialogs.dart';
import 'package:flutter_styra/services/http/requests/devices/magic/screen_schedule/get_config.dart';
import 'package:flutter_styra/services/http/requests/devices/magic/screen_schedule/restart_service.dart';
import 'package:flutter_styra/services/http/requests/devices/magic/screen_schedule/update_config.dart';
import 'package:flutter_styra/services/http/requests/general/utils/get-online.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:flutter_styra/shared/connection_status.dart';
import 'package:provider/provider.dart';

class MagicTimeDeltaEdit extends StatefulWidget {
  final MagicDeviceModel device;

  MagicTimeDeltaEdit({this.device});

  @override
  _MagicTimeDeltaEditState createState() => _MagicTimeDeltaEditState();
}

class _MagicTimeDeltaEditState extends State<MagicTimeDeltaEdit> {
  MagicScheduleModel _delta_config = MagicScheduleModel.empty();
  Timer _timer;
  Widget _status_widget;

  int _enableFromHour;
  int _enableFromMinute;
  int _enableFromSecond;

  int _disableFromHour;
  int _disableFromMinute;
  int _disableFromSecond;

  String _currentCycle;

  bool _autoOn;
  bool _autoOff;
  bool _ignoreGPIO;

  bool _didUpdate = false;

  _setupFields() {
    if (_delta_config != null) {
      setState(() {
        try {
          _enableFromHour = int.parse(_delta_config.enableFrom.split(":")[0]);
          _enableFromMinute = int.parse(_delta_config.enableFrom.split(":")[1]);
          _enableFromSecond = int.parse(_delta_config.enableFrom.split(":")[2]);
        } catch (e) {
          _enableFromHour = 0;
          _enableFromMinute = 0;
          _enableFromSecond = 0;
        }

        try {
          _disableFromHour = int.parse(_delta_config.disableFrom.split(":")[0]);
          _disableFromMinute =
              int.parse(_delta_config.disableFrom.split(":")[1]);
          _disableFromSecond =
              int.parse(_delta_config.disableFrom.split(":")[2]);
        } catch (e) {
          _disableFromHour = 0;
          _disableFromMinute = 0;
          _disableFromSecond = 0;
        }

        _currentCycle = _delta_config.updateCycle.toString();
        _autoOff = _delta_config.autoOff;
        _autoOn = _delta_config.autoOn;
        _ignoreGPIO = _delta_config.ignoreGPIO;
      });
    }
  }

  @override
  void initState() {
    _setupFields();

    getOnline(
      host: widget.device.host,
      port: widget.device.requestPort,
    ).then((val) {
      setState(() {
        _status_widget = status_box(val);
      });
      getScreenScheduleConfig(widget.device).then((onValue) {
        _delta_config = onValue;
        setState(() {
          _setupFields();
        });
      });
    });

    super.initState();
  }

  _padDigit(int val) {
    return val.toString().padLeft(2, '0');
  }

  _onChangeDisable(time) {
    setState(() {
      _disableFromHour = time.hour;
      _disableFromMinute = time.minute;
      _disableFromSecond = time.second;
    });
  }

  _onChangeEnable(time) {
    setState(() {
      _enableFromHour = time.hour;
      _enableFromMinute = time.minute;
      _enableFromSecond = time.second;
    });
  }

  _onDatePressed(color, date, onChange) {
//    DatePicker.showTimePicker(
//      context,
//      theme: DatePickerTheme(containerHeight: 210.0, backgroundColor: color),
//      showTitleActions: false,
//      onChanged: (val) => onChange(val),
//      currentTime: date,
//    );
  }

  _showIntegerDialog() {
    getIntegerDialog<int>(
      context: context,
      title: Text("Update ycle"),
      initialValue: int.parse(_currentCycle),
      min: 0,
      max: 6000,
    ).then((value) {
      if (value != null) {
        setState(() => _currentCycle = value.toString());
      }
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  _buildStatusRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          status_circle(_didUpdate),
          GestureDetector(
            onTap: () async {
              setState(() {
                _status_widget = status_box(false);
              });
              await getOnline(
                host: widget.device.host,
                port: widget.device.requestPort,
              );
              setState(() {
                _status_widget = status_box(true);
              });
            },
            child: _status_widget == null ? status_box(false) : _status_widget,
          )
        ],
      ),
    );
  }

  _buildGPIO() {
    return SwitchListTile(
      title: Text("Ignore gpio"),
      activeColor: Colors.green,
      value: _ignoreGPIO,
      onChanged: (val) {
        setState(() {
          _ignoreGPIO = !_ignoreGPIO;
        });
      },
    );
  }

  _buildAutoOn() {
    return SwitchListTile(
      title: Text("Auto on"),
      activeColor: Colors.green,
      value: _autoOn,
      onChanged: (val) {
        setState(() {
          _autoOn = !_autoOn;
        });
      },
    );
  }

  _buildAutoOff() {
    return SwitchListTile(
      title: Text("Auto off"),
      activeColor: Colors.green,
      value: _autoOff,
      onChanged: (val) {
        setState(() {
          _autoOff = !_autoOff;
        });
      },
    );
  }

  _buildDisableFrom(theme) {
    return ListTile(
      title: Text(
        "Disable from",
      ),
      trailing: Text(
        "${_padDigit(_disableFromHour)}:${_padDigit(_disableFromMinute)}:${_padDigit(_disableFromSecond)}",
      ),
      onTap: () => _onDatePressed(
          theme.mThemeData.scaffoldBackgroundColor,
          buildDateTimeObj(
            hour: _disableFromHour,
            minute: _disableFromMinute,
            second: _disableFromSecond,
          ),
          _onChangeDisable),
    );
  }

  _buildEnableFrom(theme) {
    return ListTile(
      title: Text(
        "Enable from",
      ),
      trailing: Text(
        "${_padDigit(_enableFromHour)}:${_padDigit(_enableFromMinute)}:${_padDigit(_enableFromSecond)}",
      ),
      onTap: () => _onDatePressed(
          theme.mThemeData.scaffoldBackgroundColor,
          buildDateTimeObj(
            hour: _enableFromHour,
            minute: _enableFromMinute,
            second: _enableFromSecond,
          ),
          _onChangeEnable),
    );
  }

  _buildCycle() {
    return ListTile(
      title: Text(
        "Cycle",
      ),
      trailing: Text(
        "${_currentCycle}",
      ),
      onTap: () => _showIntegerDialog(),
    );
  }

  _buildUpdateBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RaisedButton(
          child: Text("Update"),
          onPressed: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            _delta_config.ignoreGPIO = _ignoreGPIO;
            _delta_config.autoOn = _autoOn;
            _delta_config.autoOff = _autoOff;
            _delta_config.disableFrom =
                "${_padDigit(_disableFromHour)}:${_padDigit(_disableFromMinute)}:${_padDigit(_disableFromSecond)}";
            _delta_config.enableFrom =
                "${_padDigit(_enableFromHour)}:${_padDigit(_enableFromMinute)}:${_padDigit(_enableFromSecond)}";
            _delta_config.updateCycle = int.parse(_currentCycle);

            await updateScreenScheduleConfig(widget.device, _delta_config);
            await restartScreenScheduleService(widget.device);
            setState(() {
              _didUpdate = true;
            });
            _timer = Timer(Duration(seconds: 3), () {
              setState(() {
                _didUpdate = false;
              });
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeService>(context);
    bool hideGPIO = true;

    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildStatusRow(),
          Divider(),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Screen schedule",
                    style: TextStyle().copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                hideGPIO ? Container() : _buildGPIO(),
                _buildAutoOn(),
                _buildAutoOff(),
                _buildDisableFrom(theme),
                _buildEnableFrom(theme),
                _buildCycle(),
                SizedBox(
                  height: 20.0,
                ),
                _buildUpdateBtn(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
