import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styra/shared/widgets/modal_progress/modal_progress.dart';

modalProgressWrapper({Widget child, bool loading}) {
  return ModalProgressHUD(
    child: child,
    inAsyncCall: loading,
    opacity: 0.5,
    progressIndicator: CircularProgressIndicator(),
  );
}
