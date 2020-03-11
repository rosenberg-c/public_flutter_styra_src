import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/models/devices/magic/magic_device_model.dart';
import 'package:flutter_styra/models/user/auth/auth_user.dart';
import 'package:flutter_styra/screens/devices/support/picker.dart';
import 'package:flutter_styra/services/storage/concatenated/database/items/item_database_service.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:flutter_styra/shared/functions/utils.dart';
import 'package:flutter_styra/shared/validators/string_validate.dart';
import 'package:provider/provider.dart';

class MagicEditPage extends StatefulWidget {
  final DeviceAuthUser authUser;
  final MagicDeviceModel device;
  final inEdit;
  final DeviceDatabaseService databaseService;

  MagicEditPage(
      {@required this.authUser,
      @required this.device,
      @required this.inEdit,
      @required this.databaseService});

  @override
  _MagicEditPageState createState() => _MagicEditPageState();
}

class _MagicEditPageState extends State<MagicEditPage> {
  String _name;
  String _host;
  String _mmPort;
  String _requestPort;
  int _weight;

  String _type;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static List<int> _weightList = getWeightList();

  @override
  void initState() {
    setState(() {
      _name = widget.device.name;
      _host = widget.device.host;
      _mmPort = widget.device.mmPort.toString();
      _requestPort = widget.device.requestPort.toString();
      _weight = widget.device.weight;
      _type = widget.device.type;
    });
    super.initState();
  }

  _fieldPadding({Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
      child: child,
    );
  }

  Widget _buildName() {
    return _fieldPadding(
      child: TextFormField(
        decoration: InputDecoration()
            .copyWith(labelText: Strings().app.devices.fields.name),
        enabled: widget.inEdit,
        initialValue: _name,
        keyboardType: TextInputType.text,
        validator: (val) =>
            val == "" ? Strings().app.devices.addFields.validateName : null,
        onSaved: (String value) {
          _name = value;
        },
      ),
    );
  }

  Widget _buildHost() {
    return _fieldPadding(
      child: TextFormField(
        decoration: InputDecoration()
            .copyWith(labelText: Strings().app.devices.fields.host),
        enabled: widget.inEdit,
        initialValue: _host,
        keyboardType: TextInputType.text,
        validator: (val) => stringIsValidIp(val)
            ? null
            : Strings().app.devices.addFields.validateHost,
        onSaved: (String value) {
          _host = value;
        },
      ),
    );
  }

  Widget _buildMMPort() {
    return _fieldPadding(
      child: TextFormField(
        decoration: InputDecoration()
            .copyWith(labelText: Strings().app.devices.magic.fields.mmPort),
        enabled: widget.inEdit,
        initialValue: _mmPort,
        keyboardType: TextInputType.text,
        validator: (val) => stringIsValidInt(val)
            ? null
            : Strings().app.devices.magic.fields.validatePort,
        onSaved: (String value) {
          _mmPort = value;
        },
      ),
    );
  }

  Widget _buildRPort() {
    return _fieldPadding(
      child: TextFormField(
        decoration: InputDecoration()
            .copyWith(labelText: Strings().app.devices.fields.requestPort),
        enabled: widget.inEdit,
        initialValue: _requestPort,
        keyboardType: TextInputType.text,
        validator: (val) => validRequestPort(val) ? null : "5000",
        onSaved: (String value) {
          _requestPort = value;
        },
      ),
    );
  }

  Widget _buildWeight(ctx) {
    return ListTile(
      title: Text(Strings().app.devices.fields.weight),
      trailing: Text(_weight.toString()),
      onTap: () {
        if (widget.inEdit) {
          return getWeightPicker(
            ctx: ctx,
            weights: _weightList,
            weight: _weight,
            onSelected: (val) {
              setState(() {
                _weight = _weightList[val];
              });
            },
          );
        }
      },
    );
  }

  Widget _buildId() {
    return _fieldPadding(
      child: TextFormField(
        decoration: InputDecoration()
            .copyWith(labelText: Strings().app.devices.fields.id),
        enabled: false,
        initialValue: widget.device.id,
      ),
    );
  }

  _formOnSave() async {
    if (widget.inEdit) {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();
      final newDevice = MagicDeviceModel(
        id: widget.device.id,
        name: _name ?? widget.device.name.trim(),
        host: _host ?? widget.device.host.trim(),
        mmPort: _mmPort.trim() ?? widget.device.mmPort,
        requestPort: _requestPort.trim() ?? widget.device.requestPort,
        type: _type ?? widget.device.type.trim(),
        weight: _weight ?? widget.device.weight,
      );
      await widget.databaseService.update(device: newDevice.toMap());
      Navigator.of(context).popUntil(
        (route) => route.isFirst,
      );
      if (_formKey.currentState.validate()) {}
    }
  }

  _submit() {
    final theme = Provider.of<ThemeService>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: widget.inEdit ? null : theme.pColor[200],
                child: Text(
                  Strings().ui.buttons.update.label,
                  style: TextStyle(color: Colors.grey[200]),
                ),
                onPressed: () async {
                  await _formOnSave();
                },
              ),
            ],
          ),
          Divider(),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 16.0),
          _buildName(),
          _buildHost(),
          _buildMMPort(),
          _buildRPort(),
          _buildWeight(context),
          _buildId(),
          _submit(),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
