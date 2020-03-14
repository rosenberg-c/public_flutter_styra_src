import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styra/models/devices/energenie/energenie_device_model.dart';
import 'package:flutter_styra/models/user/auth/auth_user.dart';
import 'package:flutter_styra/services/storage/concatenated/database/items/item_database_service.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:provider/provider.dart';

import 'pages/energenie_edit_page.dart';

class EnergenieEditScreen extends StatefulWidget {
  final EnergenieDeviceModel device;

  EnergenieEditScreen({@required this.device});

  @override
  _EnergenieEditScreenState createState() => _EnergenieEditScreenState();
}

class _EnergenieEditScreenState extends State<EnergenieEditScreen> {
  bool inEdit = false;

  _deleteDevice(DeviceAuthUser user, deviceDB) async {
    await deviceDB.delete(id: widget.device.id);
  }

  _buildAppBar(authUser, databaseService) {
    final theme = Provider.of<ThemeService>(context);
    return AppBar(
      title: Text("Edit"),
      actions: <Widget>[
        inEdit
            ? FlatButton.icon(
                color: inEdit ? Colors.red[800] : null,
                icon: Icon(
                  Icons.delete,
                  color: theme.appBarIconColor,
                ),
                label: Text(""),
                onPressed: () {
                  deleteDialog(
                    context: context,
                    onOk: () async {
                      await _deleteDevice(authUser, databaseService);

                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  );
                },
              )
            : Container(),
        FlatButton.icon(
          color: inEdit ? Colors.amber[800] : null,
          icon: Icon(
            Icons.edit,
            color: theme.appBarIconColor,
          ),
          label: Text(""),
          onPressed: () {
            setState(() {
              inEdit = !inEdit;
              if (inEdit == false) {
                //_formKey.currentState.reset();
              }
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<DeviceAuthUser>(context);
    final DeviceDatabaseService databaseService = DeviceDatabaseService();
    databaseService.setupRef(uid: authUser.uid);

    return Scaffold(
      appBar: _buildAppBar(authUser, databaseService),
      body: EnergenieEditPage(
        authUser: authUser,
        device: widget.device,
        inEdit: inEdit,
        databaseService: databaseService,
      ),
    );
  }
}

void deleteDialog({BuildContext context, Function onOk}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text("Hey there!"),
        content: Container(
          height: 100.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "You are about to delete this device!",
              ),
              Text(
                "",
              ),
              Text(
                "Continue?",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              onOk();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
