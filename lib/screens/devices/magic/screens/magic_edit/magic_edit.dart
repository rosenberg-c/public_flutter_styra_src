import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/models/devices/magic/magic_device_model.dart';
import 'package:flutter_styra/models/user/auth/auth_user.dart';
import 'package:flutter_styra/services/storage/concatenated/database/items/item_database_service.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:provider/provider.dart';

import 'pages/magic_edit_page.dart';

class MagicEditScreen extends StatefulWidget {
  final MagicDeviceModel currentDevice;

  MagicEditScreen({@required this.currentDevice});

  @override
  _MagicEditScreenState createState() => _MagicEditScreenState();
}

class _MagicEditScreenState extends State<MagicEditScreen> {
  bool inEdit = false;

  _delete(DeviceAuthUser user, deviceDB) async {
    await deviceDB.delete(id: widget.currentDevice.id);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeService>(context);
    final authUser = Provider.of<DeviceAuthUser>(context);
    final DeviceDatabaseService databaseService = DeviceDatabaseService();
    databaseService.setupRef(uid: authUser.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings().app.main.title),
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
                    print("Pressed Delete");
                    comfirmDelete(
                      context: context,
                      onOk: () async {
                        await _delete(authUser, databaseService);

                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
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
              print("Pressed");
              setState(() {
                inEdit = !inEdit;
                if (inEdit == false) {
//                  _formKey.currentState.reset();
                }
              });
            },
          )
        ],
      ),
      body: MagicEditPage(
        authUser: authUser,
        device: widget.currentDevice,
        inEdit: inEdit,
        databaseService: databaseService,
      ),
    );
  }
}

void comfirmDelete({BuildContext context, Function onOk}) {
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
