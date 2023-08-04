import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/constants/ToastMessage.dart';
import 'package:frontend/firebase/firebase_api.dart';
import 'package:frontend/model/Categories%20Model.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:frontend/widgets/commonButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? image;
  void takeImage() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  CategoryModel? _selectCategory;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Product', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            InkWell(
              onTap: takeImage,
              child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.red,
                  child: image == null
                      ? Icon(Icons.camera_alt, size: 40)
                      : ClipOval(
                          child: Image.file(
                            image!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        )),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: title,
                decoration: InputDecoration(hintText: 'Product Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                maxLines: 6,
                controller: description,
                decoration: InputDecoration(hintText: 'Product Description'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: price,
                decoration: InputDecoration(hintText: 'Product Price'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: DropdownButtonFormField(
                value: _selectCategory,
                hint: Text(
                  'Category',
                ),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    _selectCategory = value;
                  });
                },
                items: appProvider.dashCategory.map((CategoryModel val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val.title.toString(),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyCustomButton(
                title: 'Add',
                voidCallback: () {
                  if (image == null ||
                      _selectCategory == null ||
                      title.text.isEmpty ||
                      description.text.isEmpty ||
                      price.text.isEmpty) {
                    ShowDialog(context, "Add All Field");
                  } else {
                    appProvider.addProductFunction(
                        image!,
                        title.text,
                        description.text,
                        price.text,
                        _selectCategory!.id.toString());
                    utils().showToast("Add Product Successfully");
                  }
                },
              ),
            )
          ],
        ));
  }
}
