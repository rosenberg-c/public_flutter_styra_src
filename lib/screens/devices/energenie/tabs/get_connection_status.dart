import 'package:flutter/material.dart';

status_box_(bool status_online) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
    child: Container(
      child: AnimatedContainer(
        height: 10,
        width: 10,
        duration: Duration(milliseconds: 100),
        color: status_online ? Colors.green : Colors.amber,
      ),
      //color: color,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.black87),
        //color: Colors.black87
      ),
    ),
  );
}

status_circle_(bool didLoad) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
    child: Container(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: didLoad ? Colors.green : Colors.amber,
          borderRadius: new BorderRadius.all(Radius.circular(100.0)),
          //color: Colors.black87
        ),
        height: 10,
        width: 10,
      ),
      //color: color,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: Colors.black87),
        borderRadius: new BorderRadius.all(Radius.circular(100.0)),
        //color: Colors.black87
      ),
    ),
  );
}
