import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/auth_screen/loginScreen.dart';
import 'package:frontend/constants/asset_image.dart';
import 'package:frontend/constants/routes.dart';

import '../auth_screen/signupScreen.dart';
import '../widgets/commonButton.dart';
import '../widgets/commonheader.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 290),
              Center(
                child: MyHeader(
                  title: '   Welcome To Our App',
                  subtitle: 'Buy Your favourite Mobiles',
                ),
              ),
              SizedBox(height: 20),
              MyCustomButton(
                title: 'Login',
                voidCallback: () {
                  Routes.instance.push(MyLoginScreen(), context);
                },
              ),
              SizedBox(height: 10),
              MyCustomButton(
                title: 'Sign Up',
                voidCallback: () {
                  Routes.instance.push(MySignupScreen(), context);
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
