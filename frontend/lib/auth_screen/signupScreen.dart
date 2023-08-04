import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/auth_screen/loginScreen.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/firebase/firebase_auth_helper.dart';
import 'package:frontend/widgets/commonButton.dart';
import 'package:frontend/widgets/commonheader.dart';

class MySignupScreen extends StatefulWidget {
  const MySignupScreen({super.key});

  @override
  State<MySignupScreen> createState() => _MySignupScreenState();
}

class _MySignupScreenState extends State<MySignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyHeader(
                title: 'Create account',
                subtitle: 'You can Sign up Here',
              ),
              SizedBox(height: 20),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            hintText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
                title: "Sign Up",
                voidCallback: () async {
                  if (_formKey.currentState!.validate()) {
                    firebaseAuthHelper.instance.signup(
                        name.text.toString(),
                        email.text.toString(),
                        password.text.toString(),
                        context);
                  }
                },
              ),
              SizedBox(height: 10),
              Center(
                  child: Text(
                "Already have an account?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              )),
              SizedBox(height: 10),
              Center(
                  child: InkWell(
                onTap: () {
                  Routes.instance.push(MyLoginScreen(), context);
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ))
            ],
          ),
        ),
      )),
    );
  }
}
