import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/auth_screen/signupScreen.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/firebase/firebase_auth_helper.dart';
import 'package:frontend/screen/homeScreen.dart';
import 'package:frontend/widgets/bottomWidget.dart';
import 'package:frontend/widgets/commonButton.dart';
import 'package:frontend/widgets/commonheader.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyHeader(
              title: 'Login',
              subtitle: 'You can Login Here',
            ),
            SizedBox(height: 20),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                          hintText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                          suffixIcon: InkWell(
                            child: Icon(Icons.visibility),
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          ),
                          hintText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            SizedBox(height: 30),
            MyCustomButton(
              title: "Login",
              voidCallback: () async {
                if (_formKey.currentState!.validate()) {
                  bool islogged = await firebaseAuthHelper.instance.login(
                      email.text.toString(), password.text.toString(), context);
                  if (islogged) {
                    Routes.instance
                        .pushAndRemoveUtil(BottomNavigator(), context);
                  }
                }
              },
            ),
            SizedBox(height: 10),
            Center(
                child: Text(
              "Don't have an account?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            )),
            SizedBox(height: 10),
            Center(
                child: InkWell(
              onTap: () {
                Routes.instance.push(MySignupScreen(), context);
              },
              child: Text(
                "Create an account",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ))
          ],
        ),
      )),
    );
  }
}
