import 'package:flutter/material.dart';
import 'package:flutter_styra/models/devices/energenie/energenie_device_model.dart';
import 'package:flutter_styra/services/http/requests/general/utils/get-online.dart';
import 'package:flutter_styra/services/http/requests/general/utils/get-temp.dart';
import 'package:flutter_styra/services/http/requests/general/utils/get-uptime.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:flutter_styra/shared/connection_status.dart';
import 'package:provider/provider.dart';

class EnergenieOverviewPage extends StatefulWidget {
  final EnergenieDeviceModel device;

  EnergenieOverviewPage({@required this.device});

  @override
  _EnergenieOverviewPageState createState() => _EnergenieOverviewPageState();
}

class _EnergenieOverviewPageState extends State<EnergenieOverviewPage> {
  String _uptime;
  String _temp;
  Widget _status_widget;

  _syncWithDevice() async {
    final _uptime_response = await getUptime(
      host: widget.device.host,
      port: widget.device.requestPort,
    );

    final _temp_response = await getTemp(
      host: widget.device.host,
      port: widget.device.requestPort,
    );

    setState(() {
      _uptime = _uptime_response;
      _temp = _temp_response;
    });
  }

  @override
  void initState() {
    getOnline(
      host: widget.device.host,
      port: widget.device.requestPort,
    ).then((val) {
      setState(() {
        _status_widget = status_box(val);
      });
      _syncWithDevice();
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
              await _syncWithDevice();
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

  _buildOverview() {
    final theme = Provider.of<ThemeService>(context);

    return Expanded(
      child: ListView(
        children: <Widget>[
          Card(
            //color: theme.pColor[100],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Host"),
                    trailing: Text(widget.device.host),
                  ),
                  ListTile(
                    title: Text("Uptime"),
                    trailing: Text(_uptime.toString()),
                  ),
                  ListTile(
                    title: Text("Temp"),
                    trailing: Text(_temp.toString()),
                  ),
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
        children: <Widget>[
          _buildStatusRow(),
          Divider(),
          _buildOverview(),
        ],
      ),
    );
  }
}
