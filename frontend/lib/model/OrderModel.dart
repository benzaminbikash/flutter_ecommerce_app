import 'dart:convert';

import 'package:frontend/model/productModel.dart';

class OrderModel {
  String? id;
  String? payment;
  String? status;
  List<PostsModal> product;

  OrderModel(
      {required this.id,
      required this.status,
      required this.payment,
      required this.product});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productlist = json['product'];
    return OrderModel(
        id: json["id"],
        status: json["status"],
        payment: json["payment"],
        product: productlist.map((e) => PostsModal.fromJson(e)).toList());
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "status": status,
      "payment": payment,
      "product": product.map((e) => e.toJson()).toList(),
    };
  }
}
