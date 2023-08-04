import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  MyHeader({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title == 'Login' || title == 'Create account')
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              child: Icon(Icons.arrow_back_outlined, size: 28),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        Text(
          title!,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          subtitle!,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
