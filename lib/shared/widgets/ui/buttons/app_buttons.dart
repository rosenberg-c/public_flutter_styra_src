import 'package:flutter/material.dart';
import 'package:flutter_styra/shared/widgets/loading/loading.dart';

class AppRaisedButton extends StatefulWidget {
  final Widget child;
  final Function onPressed;

  AppRaisedButton({
    @required this.child,
    @required this.onPressed,
  });

  @override
  _AppRaisedButtonState createState() => _AppRaisedButtonState();
}

class _AppRaisedButtonState extends State<AppRaisedButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    var xx = widget.child;
    return Stack(
      children: [
        RaisedButton(
          onPressed: () async {
            setState(() {
              _loading = true;
            });
            await widget.onPressed();
            setState(() {
              _loading = false;
            });
          },
          child: Row(children: [
            widget.child
          ],),
        ),
        Positioned(
          child: SizedBox(
            //height: 50,
            //width: 50,
            child: _loading ? Loading2(size: 10): Container()  //Container(color: Colors.pink,),
          ),
          left: 4,
          top: 20,
        )
      ],
    );
  }
}
