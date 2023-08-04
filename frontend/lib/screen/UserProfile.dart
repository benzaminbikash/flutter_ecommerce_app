import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/dashboard/dashboard.dart';
import 'package:frontend/firebase/firebase_auth_helper.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:frontend/screen/FavScreen.dart';
import 'package:frontend/screen/cartScreen.dart';
import 'package:frontend/screen/orderScreen.dart';
import 'package:frontend/screen/welcomeScreen.dart';
import 'package:provider/provider.dart';

class MyUserProfile extends StatefulWidget {
  const MyUserProfile({super.key});

  @override
  State<MyUserProfile> createState() => _MyUserProfileState();
}

class _MyUserProfileState extends State<MyUserProfile> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            CircleAvatar(
              backgroundColor: Colors.black,
              maxRadius: 50,
              child: ClipOval(
                  child: appProvider.usermodel.image == null
                      ? Text(
                          appProvider.usermodel.name!.substring(0, 1),
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      : Image.network(appProvider.usermodel.image!)),
            ),
            SizedBox(height: 10),
            Center(
                child: Text(appProvider.usermodel.name.toString(),
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
            Center(
                child: Text(appProvider.usermodel.email.toString(),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
            SizedBox(height: 10),
            Center(
              child: InkWell(
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 30),
            if (appProvider.usermodel.roll != 'admin')
              ListTile(
                onTap: () {
                  Routes.instance.push(MyCart(), context);
                },
                leading: Icon(Icons.shopping_cart),
                title: Text('My Cart'),
              ),
            ListTile(
              onTap: () {
                Routes.instance.push(FavScreenProduct(), context);
              },
              leading: Icon(Icons.favorite),
              title: Text('Favorite'),
            ),
            if (appProvider.usermodel.roll != 'admin')
              ListTile(
                onTap: () {
                  Routes.instance.push(OrderScreen(), context);
                },
                leading: Icon(Icons.online_prediction),
                title: Text('My Order'),
              ),
            if (appProvider.usermodel.roll == "admin")
              ListTile(
                onTap: () {
                  Routes.instance.push(MyDashBoard(), context);
                },
                leading: Icon(Icons.dashboard),
                title: Text('Dashboard'),
              ),
            ListTile(
              onTap: () {
                firebaseAuthHelper.instance.logoutuser(context);
              },
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
