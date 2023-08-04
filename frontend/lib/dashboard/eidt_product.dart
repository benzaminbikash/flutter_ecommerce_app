import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/constants/ToastMessage.dart';
import 'package:frontend/firebase/firebase_api.dart';
import 'package:frontend/model/productModel.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:frontend/widgets/commonButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final PostsModal postsModal;
  final int index;
  const EditProduct({super.key, required this.postsModal, required this.index});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Edit Product',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(
          children: [
            InkWell(
              onTap: takeImage,
              child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: image == null
                      ? Image.network(
                          widget.postsModal.image.toString(),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : ClipOval(
                          child: Image.file(
                            image!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        )),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                    hintText: widget.postsModal.title.toString()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                maxLines: 4,
                controller: description,
                decoration: InputDecoration(
                    hintText: widget.postsModal.description.toString()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: price,
                decoration: InputDecoration(
                    hintText: 'Rs ${widget.postsModal.price.toString()}'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: MyCustomButton(
                title: "Update",
                voidCallback: () async {
                  if (image == null &&
                      title.text.isEmpty &&
                      description.text.isEmpty &&
                      price.text.isEmpty) {
                    Navigator.pop(context);
                  } else if (image != null) {
                    String imageUrl = await FirebaseApi.instance
                        .uploadUserImage(
                            widget.postsModal.id.toString(), image!);
                    PostsModal product = widget.postsModal.copyWith(
                        description: description.text.isEmpty
                            ? widget.postsModal.description.toString()
                            : description.text,
                        image: imageUrl,
                        title: title.text.isEmpty
                            ? widget.postsModal.title.toString()
                            : title.text,
                        price: price.text.isEmpty
                            ? widget.postsModal.price.toString()
                            : price.text);
                    appProvider.updateProduct(widget.index, product);
                    utils().showToast("Update Successfully!");
                  } else {
                    PostsModal product = widget.postsModal.copyWith(
                        description: description.text.isEmpty
                            ? widget.postsModal.description.toString()
                            : description.text,
                        title: title.text.isEmpty
                            ? widget.postsModal.title.toString()
                            : title.text,
                        price: price.text.isEmpty
                            ? widget.postsModal.price.toString()
                            : price.text);
                    appProvider.updateProduct(widget.index, product);
                    utils().showToast("Update Successfully!");
                  }
                },
              ),
            )
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: MyCustomButton(
            //     title: "Update",
            //     voidCallback: () async {
            //       if (image == null &&
            //           title.text.isEmpty &&
            //           description.text.isEmpty &&
            //           price.text.isEmpty) {
            //         Navigator.pop(context);
            //       } else if (image != null) {
            //         String imageUrl =
            //             await FirebaseApi.instance.uploadUserImage(
            //           widget.postsModal.id.toString(),
            //           image!,
            //         );
            //         PostsModal product = widget.postsModal.copyWith(
            //           description:
            //               description.text.isEmpty ? null : description.text,
            //           image: imageUrl,
            //           title: title.text.isEmpty ? null : title.text,
            //           price: price.text.isEmpty ? null : price.text,
            //         );
            //         appProvider.updateProduct(widget.index,
            //             product); // Use 'product' instead of 'widget.postsModal'
            //         utils().showToast("Update Successfully!");
            //       } else {
            //         PostsModal product = widget.postsModal.copyWith(
            //           description:
            //               description.text.isEmpty ? null : description.text,
            //           title: title.text.isEmpty ? null : title.text,
            //           price: price.text.isEmpty ? null : price.text,
            //         );
            //         appProvider.updateProduct(widget.index,
            //             product); // Use 'product' instead of 'widget.postsModal'
            //         utils().showToast("Update Successfully!");
            //       }
            //     },
            //   ),
            // ),
          ],
        ));
  }
}
