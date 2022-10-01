import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showLoaderDialog(BuildContext context) {
  CupertinoAlertDialog alert = const CupertinoAlertDialog(
    title: Text('Loading'),
    content: CupertinoActivityIndicator(),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
