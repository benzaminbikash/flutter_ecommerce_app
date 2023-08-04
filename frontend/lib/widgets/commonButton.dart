import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyCustomButton extends StatelessWidget {
  final String? title;
  final VoidCallback? voidCallback;
  MyCustomButton({required this.title, this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          onPressed: () {
            voidCallback!();
          },
          child: Text(
            title!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
    );
  }
}
