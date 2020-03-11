import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styra/models/devices/energenie/energenie_device_model.dart';
import 'package:flutter_styra/services/http/requests/devices/energenie/socket_control/energenie-control-off.dart';
import 'package:flutter_styra/services/http/requests/devices/energenie/socket_control/energenie-control-on.dart';
import 'package:flutter_styra/services/http/requests/general/device_control/device-control-reboot.dart';
import 'package:flutter_styra/services/http/requests/general/device_control/device-control-shutdown.dart';
import 'package:flutter_styra/services/http/requests/general/utils/get-online.dart';
import 'package:flutter_styra/shared/connection_status.dart';

class EnergenieRemoteControl extends StatefulWidget {
  final EnergenieDeviceModel device;

  EnergenieRemoteControl({this.device});

  @override
  EenergenieRemoteControlState createState() => EenergenieRemoteControlState();
}

class EenergenieRemoteControlState extends State<EnergenieRemoteControl> {
  Widget _status_widget;

  @override
  void initState() {
    getOnline(
      host: widget.device.host,
      port: widget.device.requestPort,
    ).then((val) {
      setState(() {
        _status_widget = status_box(val);
      });
    });
    super.initState();
  }

  _buildStatusRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(),
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
          ),
        ],
      ),
    );
  }

  _buildRemoteControl() {
    double width = MediaQuery.of(context).size.width / 2;
    return Expanded(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              "Socket 1",
            ),
            trailing: SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text("On"),
                    onPressed: () => energenieOn(widget.device, 1),
                  ),
                  RaisedButton(
                    child: Text("Off"),
                    onPressed: () => energenieOff(widget.device, 1),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Socket 2",
            ),
            trailing: SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text("On"),
                    onPressed: () => energenieOn(widget.device, 2),
                  ),
                  RaisedButton(
                    child: Text("Off"),
                    onPressed: () => energenieOff(widget.device, 2),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Socket 3",
            ),
            trailing: SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text("On"),
                    onPressed: () => energenieOn(widget.device, 3),
                  ),
                  RaisedButton(
                    child: Text("Off"),
                    onPressed: () => energenieOff(widget.device, 3),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Socket 4",
            ),
            trailing: SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text("On"),
                    onPressed: () => energenieOn(widget.device, 4),
                  ),
                  RaisedButton(
                    child: Text("Off"),
                    onPressed: () => energenieOff(widget.device, 4),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Control",
            ),
            trailing: SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Poweroff"),
                    onPressed: () async {
                      await deviceShutdown(
                        host: widget.device.host,
                        port: widget.device.requestPort,
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text("Reboot"),
                    onPressed: () async {
                      await deviceReboot(
                        host: widget.device.host,
                        port: widget.device.requestPort,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[_buildStatusRow(), Divider(), _buildRemoteControl()],
      ),
    );
  }
}
