import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:frontend/firebase/firebase_auth_helper.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:frontend/screen/homeScreen.dart';
import 'package:frontend/screen/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/widgets/bottomWidget.dart';
import 'constants/themeData.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance.currentUser;
    return ChangeNotifierProvider(
      create: (context) => AppProvider()..get_dashCategory(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: mycustomtheme,
        home: (_auth != null ? BottomNavigator() : WelcomeScreen()),
      ),
    );
  }
}
// BottomNavigator