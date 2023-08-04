import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class utils {
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

void ShowDialog(BuildContext context, String message) {
  showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Builder(builder: (context) {
            return SizedBox(
              width: 120,
              height: 100,
              child: Column(
                children: [
                  CircularProgressIndicator(color: Colors.red),
                  SizedBox(height: 10),
                  Text(
                    message.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  )
                ],
              ),
            );
          }),
        );
      });
}
