import 'package:flutter/material.dart';

class Routes {
  static Routes instance = Routes();
  Future<dynamic> pushAndRemoveUtil(Widget widget, BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }

  Future<dynamic> push(Widget widget, BuildContext context) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget));
  }
}
