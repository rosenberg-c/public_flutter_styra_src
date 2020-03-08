import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/models/user/auth/auth_user.dart';
import 'package:flutter_styra/screens/devices/devices.dart';
import 'package:flutter_styra/services/storage/concatenated/database/items/item_database_service.dart';
import 'package:flutter_styra/services/storage/concatenated/storage_concatenated_services.dart';
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

  String _selectedType = DeviceItems.energenie;
  bool _loading = false;

  tryAdd(DeviceDatabaseService deviceDB) async {
    if (_formKey.currentState.validate()) {
      await ConcatenatedServices().tryAddEnergenieDevice(
        deviceDB: deviceDB,
        name: _cNameCtrl.text,
        host: _cHostCtrl.text,
        requestPort: _cRequestPortCtrl.text,
        type: _selectedType,
        uid: widget.uid,
      );
      return true;
    }
    return false;
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
    return _fieldPadding(
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
    return _fieldPadding(
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
        bool didAdd = await tryAdd(databaseService);
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
