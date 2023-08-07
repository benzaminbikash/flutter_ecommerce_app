import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screen/FavScreen.dart';
import 'package:frontend/screen/UserProfile.dart';
import 'package:frontend/screen/cartScreen.dart';
import 'package:frontend/screen/homeScreen.dart';
import 'package:frontend/widgets/fav_item.dart';

class BottomNavigator extends StatefulWidget {
  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            activeColor: Colors.white,
            backgroundColor: Colors.black,
            height: 60,
            inactiveColor: Colors.grey,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(child: MyHomeScreen());
              });
            case 1:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(child: MyUserProfile());
              });
          }
          return Container();
        });
  }
}
