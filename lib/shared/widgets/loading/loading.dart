import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:provider/provider.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitChasingDots(
          color: Provider.of<ThemeService>(context).pColor,
          size: 50.0,
        ),
      ),
    );
  }
}

class Loading2 extends StatelessWidget {
  final double size;

  Loading2({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,width: size,
      child: Center(
        child: CircularProgressIndicator(
          //color: Provider.of<ThemeService>(context).pColor,
          //size: size,
        ),
      ),
    );
  }
}
