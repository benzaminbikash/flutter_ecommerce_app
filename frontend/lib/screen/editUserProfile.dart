import 'package:flutter/material.dart';
import 'package:frontend/provider/appProvider.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../widgets/commonButton.dart';

class UserEditProfile extends StatefulWidget {
  const UserEditProfile({super.key});

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  File? image;
  void takeImage() async {
    XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.4,
          title: Text(
            'Update Profile',
            style: TextStyle(color: Colors.black),
          )),
      body: ListView(
        children: [
          SizedBox(height: 20),
          InkWell(
            onTap: takeImage,
            child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.red,
                child: image == null
                    ? Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 35,
                      )
                    : ClipOval(
                        child: Image.file(
                          image!,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      )),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(labelText: "Subscription"),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MyCustomButton(
              title: "Update",
              voidCallback: () {},
            ),
          )
        ],
      ),
    );
  }
}
