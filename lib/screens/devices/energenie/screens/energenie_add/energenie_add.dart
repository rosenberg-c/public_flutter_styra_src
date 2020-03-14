import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/models/devices/energenie/energenie_device_model.dart';
import 'package:flutter_styra/models/user/auth/auth_user.dart';
import 'package:flutter_styra/screens/devices/support/fields.dart';
import 'package:flutter_styra/services/storage/concatenated/database/devices/item_database_service.dart';
import 'package:flutter_styra/shared/validators/string_validate.dart';
import 'package:flutter_styra/shared/widgets/modal_progress/modal_progress_wrapper.dart';
import 'package:provider/provider.dart';

class AddEnergenie extends StatefulWidget {
  final String uid;

  AddEnergenie({@required this.uid});

  @override
  _AddEnergenieState createState() => _AddEnergenieState();
}

class _AddEnergenieState extends State<AddEnergenie> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _cHostCtrl = TextEditingController();
  TextEditingController _cNameCtrl = TextEditingController();
  TextEditingController _cRequestPortCtrl = TextEditingController();

  bool _loading = false;

  _tryAdd(DeviceDatabaseService deviceDB) async {
    if (_formKey.currentState.validate()) {
      final device = EnergenieDeviceModel(
        name: _cNameCtrl.text,
        host: _cHostCtrl.text,
        requestPort: int.parse(_cRequestPortCtrl.text),
      );

      await deviceDB.create(device: device.toMap());

      return true;
    }
    return false;
  }

  Widget _buildName() {
    return fieldPadding(
      child: TextFormField(
        decoration: InputDecoration().copyWith(
          labelText: Strings().app.devices.fields.name,
        ),
        initialValue: _cNameCtrl.text,
        keyboardType: TextInputType.text,
        validator: (val) => validInputName(val)
            ? null
            : Strings().app.devices.addFields.validateName,
        onSaved: (String value) {
          _cNameCtrl.text = value.trim();
        },
      ),
    );
  }

  Widget _buildHost() {
    return fieldPadding(
      child: TextFormField(
        decoration: InputDecoration().copyWith(
          labelText: Strings().app.devices.fields.host,
        ),
        keyboardType: TextInputType.text,
        validator: (val) => stringIsValidIp(val)
            ? null
            : Strings().app.devices.addFields.hostLabel,
        onSaved: (String value) {
          _cHostCtrl.text = value.trim();
        },
      ),
    );
  }

  Widget _buildRPort() {
    return fieldPadding(
      child: TextFormField(
        decoration: InputDecoration().copyWith(
          labelText: Strings().app.devices.fields.requestPort,
        ),
        keyboardType: TextInputType.text,
        validator: (val) => validRequestPort(val) ? null : "5000",
        onSaved: (String value) {
          _cRequestPortCtrl.text = value.trim();
        },
      ),
    );
  }

  _submit() {
    final authUser = Provider.of<DeviceAuthUser>(context);

    final DeviceDatabaseService databaseService = DeviceDatabaseService();
    databaseService.setupRef(uid: authUser.uid);

    return RaisedButton(
      child: Text(
        Strings().ui.buttons.add.label,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        if (!_formKey.currentState.validate()) {
          return;
        }
        _formKey.currentState.save();
        setState(() {
          _loading = true;
        });
        bool didAdd = await _tryAdd(databaseService);
        setState(() {
          _loading = false;
        });
        if (didAdd) {
          Navigator.of(context).popUntil(
            (route) => route.isFirst,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Energenie Device"),
      ),
      body: modalProgressWrapper(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  _buildName(),
                  _buildHost(),
                  _buildRPort(),
                  SizedBox(height: 20.0),
                  SizedBox(height: 20.0),
                  _submit()
                ],
              ),
            ),
          ),
          loading: _loading),
    );
  }
}
