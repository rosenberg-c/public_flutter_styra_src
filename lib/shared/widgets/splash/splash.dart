import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  static const route = "splash";

  final onSuccessRoute;

  SplashScreen({Key key, @required this.onSuccessRoute}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(milliseconds: 500), onDoneLoading);
  }

  onDoneLoading() {
    Navigator.of(context).pushReplacementNamed(widget.onSuccessRoute);
//    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//      return ScreenWrapper();
//    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Container(
                  child: Text("Setting up...."),
                )),
              ],
            ),
          ),
        ),
      ),
    );
//  return LogoWidget();
  }
}
