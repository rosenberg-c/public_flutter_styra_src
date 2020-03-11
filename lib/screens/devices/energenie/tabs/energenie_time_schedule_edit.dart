import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_styra/models/device/device_model.dart';
import 'package:flutter_styra/models/energenie/energenie.dart';
import 'package:flutter_styra/services/http/requests/energenie/energenie_get_config.dart';
import 'package:flutter_styra/services/http/requests/energenie/energenie_restart_service.dart';
import 'package:flutter_styra/services/http/requests/energenie/energenie_update_config.dart';
import 'package:flutter_styra/services/http/requests/utils/get-online.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:flutter_styra/shared/connection_status.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class EnergenieTimeSchedule extends StatefulWidget {
  final DeviceModel device;

  EnergenieTimeSchedule({this.device});

  @override
  _EnergenieTimeScheduleState createState() => _EnergenieTimeScheduleState();
}

class _EnergenieTimeScheduleState extends State<EnergenieTimeSchedule> {
  EnergenieConfigModel _delta_config = EnergenieConfigModel.empty();
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

  setupFields() {
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
    setupFields();

    getOnline(
      host: widget.device.host,
      port: widget.device.requestPort,
    ).then((val) {
      setState(() {
        _status_widget = status_box(val);
      });
      getEnergenieConfig(widget.device).then((onValue) {
        _delta_config = onValue;
        setState(() {
          setupFields();
        });
      });
    });

    super.initState();
  }

  padDigit(int val) {
    return val.toString().padLeft(2, '0');
  }

  onChangeDisable(time) {
    setState(() {
      _disableFromHour = time.hour;
      _disableFromMinute = time.minute;
      _disableFromSecond = time.second;
    });
  }

  onChangeEnable(time) {
    setState(() {
      _enableFromHour = time.hour;
      _enableFromMinute = time.minute;
      _enableFromSecond = time.second;
    });
  }

  onDatePressed(color, date, onChange) {
    DatePicker.showTimePicker(
      context,
      theme: DatePickerTheme(containerHeight: 210.0, backgroundColor: color),
      showTitleActions: false,
      onChanged: (val) => onChange(val),
      currentTime: date,
    );
  }

  void _showIntegerDialog(color) {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: Theme.of(context).copyWith(dialogBackgroundColor: color),
            child: NumberPickerDialog.integer(
              minValue: 0,
              maxValue: 6000,
              title: new Text("Update cycle"),
              initialIntegerValue: int.parse(_currentCycle),
            ),
          );
        }).then((int value) {
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

  _buildSchedule() {
    final theme = Provider.of<ThemeService>(context);
    return Expanded(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Socket 1 Schedule"),
          ),
          SwitchListTile(
            title: Text("Ignore gpio"),
            activeColor: Colors.green,
            value: _ignoreGPIO,
            onChanged: (val) {
              setState(() {
                _ignoreGPIO = !_ignoreGPIO;
              });
            },
          ),
          SwitchListTile(
            title: Text("Auto on"),
            activeColor: Colors.green,
            value: _autoOn,
            onChanged: (val) {
              setState(() {
                _autoOn = !_autoOn;
              });
            },
          ),
          SwitchListTile(
            title: Text("Auto off"),
            activeColor: Colors.green,
            value: _autoOff,
            onChanged: (val) {
              setState(() {
                _autoOff = !_autoOff;
              });
            },
          ),
          ListTile(
            title: Text(
              "Enable from",
            ),
            trailing: Text(
              "${padDigit(_enableFromHour)}:${padDigit(_enableFromMinute)}:${padDigit(_enableFromSecond)}",
            ),
            onTap: () => onDatePressed(
                theme.mThemeData.scaffoldBackgroundColor,
                DateTime(
                  0,
                  0,
                  0,
                  _enableFromHour,
                  _enableFromMinute,
                  _enableFromSecond,
                  0,
                  0,
                ),
                onChangeEnable),
          ),
          ListTile(
            title: Text(
              "Disable from",
            ),
            trailing: Text(
              "${padDigit(_disableFromHour)}:${padDigit(_disableFromMinute)}:${padDigit(_disableFromSecond)}",
            ),
            onTap: () => onDatePressed(
                theme.mThemeData.scaffoldBackgroundColor,
                DateTime(
                  0,
                  0,
                  0,
                  _disableFromHour,
                  _disableFromMinute,
                  _disableFromSecond,
                  0,
                  0,
                ),
                onChangeDisable),
          ),
          ListTile(
            title: Text(
              "Cycle",
            ),
            trailing: Text(
              "${_currentCycle}",
            ),
            onTap: () =>
                _showIntegerDialog(theme.mThemeData.scaffoldBackgroundColor),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
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
                      "${padDigit(_disableFromHour)}:${padDigit(_disableFromMinute)}:${padDigit(_disableFromSecond)}";
                  _delta_config.enableFrom =
                      "${padDigit(_enableFromHour)}:${padDigit(_enableFromMinute)}:${padDigit(_enableFromSecond)}";
                  _delta_config.updateCycle = int.parse(_currentCycle);

                  await updateEnergenieConfig(widget.device, _delta_config);
                  await restartEnergenieService(widget.device);
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[_buildStatusRow(), Divider(), _buildSchedule()],
      ),
    );
  }
}
