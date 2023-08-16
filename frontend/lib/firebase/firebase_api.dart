import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/ToastMessage.dart';
import 'package:frontend/model/Categories%20Model.dart';
import 'package:frontend/model/OrderModel.dart';
import 'package:frontend/model/productModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/model/userModel.dart';

class FirebaseApi {
  static FirebaseApi instance = FirebaseApi();

  Future<List<CategoryModel>> getCategories() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('Category').get();
      final categoryList = querySnapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList();
      return categoryList;
    } catch (e) {
      throw Exception('No Category Data');
    }
  }

  Future<List<PostsModal>> getBestProduct() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collectionGroup('products').get();
      final productList = querySnapshot.docs
          .map((doc) => PostsModal.fromJson(doc.data()))
          .toList();
      return productList;
    } catch (e) {
      throw Exception('No Product Data');
    }
  }

  Future<List<PostsModal>> productOnCategory(String id) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Category')
          .doc(id)
          .collection("products")
          .get();
      final productList = querySnapshot.docs
          .map((doc) => PostsModal.fromJson(doc.data()))
          .toList();
      return productList;
    } catch (e) {
      throw Exception('No Product Data');
    }
  }

  Future<userModel> userData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      return userModel.fromJson(querySnapshot.data()!);
    } catch (e) {
      throw Exception('No user Data');
    }
  }

  //for dashboard:
  Future<String> deleteProduct(String id) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collectionGroup('products')
          .where('id', isEqualTo: id)
          .get();
      if (snapshot.size > 0) {
        final documentRef = snapshot.docs[0].reference;
        await documentRef.delete();
        debugPrint('delete');
        return 'Delete Successfully';
      } else {
        return 'Document with ID $id not found';
      }
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<String> UpdateProduct(PostsModal postsModal) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collectionGroup('products')
          .where('id', isEqualTo: postsModal.id)
          .get();
      if (snapshot.size > 0) {
        final documentRef = snapshot.docs[0].reference;
        await documentRef.update(postsModal.toJson());
        debugPrint('update');
        return 'update Successfully';
      } else {
        return 'Document with ID not found';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<PostsModal> addProduct(
    File image,
    String title,
    String description,
    String price,
    String categoryId,
  ) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection("Category")
        .doc(categoryId)
        .collection("products")
        .doc();
    String imageUrl = await uploadUserImage(reference.id, image);
    PostsModal addproduct = PostsModal(
        id: reference.id,
        image: imageUrl,
        description: description,
        isFavorite: false,
        price: price,
        title: title,
        qty: null);
    await reference.set(addproduct.toJson());
    return addproduct;
  }

  Future<String> uploadUserImage(String id, File image) async {
    final taskSnapshot = await FirebaseStorage.instance.ref(id).putFile(image);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<bool> userOrderProduct(List<PostsModal> list, String payment) async {
    try {
      DocumentReference reference = FirebaseFirestore.instance
          .collection("userOrder")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('order')
          .doc();
      // DocumentReference admin = FirebaseFirestore.instance
      //     .collection("userOrder")
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .collection('order')
      //     .doc();
      // admin.set({
      //   "id": reference.id,
      //   "product": list.map((e) => e.toJson()),
      //   "status": "pending",
      //   "payment": payment
      // });
      reference.set({
        "id": reference.id,
        "product": list.map((e) => e.toJson()),
        "status": "pending",
        "payment": payment
      });
      print('working ${payment}');
      utils().showToast("Order Successfully");
      return true;
    } catch (e) {
      utils().showToast(e.toString());
      print('not working');

      return false;
    }
  }

  Future<List<OrderModel>> getUserOrderList() async {
    try {
      final reference = await FirebaseFirestore.instance
          .collection('userOrder')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('order')
          .get();
      final data =
          reference.docs.map((e) => OrderModel.fromJson(e.data())).toList();
      return data;
    } catch (e) {
      throw Exception('Error In Order Fetch');
    }
  }
}
