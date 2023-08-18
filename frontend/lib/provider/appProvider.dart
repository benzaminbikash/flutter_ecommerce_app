import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/constants/ToastMessage.dart';
import 'package:frontend/firebase/firebase_api.dart';
import 'package:frontend/model/Categories%20Model.dart';
import 'package:frontend/model/OrderModel.dart';
import 'package:frontend/model/productModel.dart';
import 'package:frontend/model/userModel.dart';

class AppProvider with ChangeNotifier {
  List<PostsModal> _cartProductList = [];

  List<PostsModal> get getCartProduct => _cartProductList;

  void addCartProduct(PostsModal postsmodel) {
    _cartProductList.add(postsmodel);
    notifyListeners();
  }

  void removeCartProduct(PostsModal postsmodel) {
    _cartProductList.remove(postsmodel);
    notifyListeners();
  }

  List<PostsModal> _favProductList = [];
  List<PostsModal> get getFavProduct => _favProductList;

  void addFavProduct(PostsModal postsmodel) {
    _favProductList.add(postsmodel);
    notifyListeners();
  }

  void removeFavProduct(PostsModal postsmodel) {
    _favProductList.remove(postsmodel);
    notifyListeners();
  }

  userModel? _usermodel;
  userModel get usermodel => _usermodel!;
  void getUserData() async {
    _usermodel = await FirebaseApi.instance.userData();
    notifyListeners();
  }

  double totalPrice() {
    double totalPrice = 0.0;
    for (var i in _cartProductList) {
      totalPrice += double.parse(i.price!) * i.qty!.toDouble();
    }

    return totalPrice;
  }

  void updateQTY(PostsModal postsModal, int qty) {
    int index = _cartProductList.indexOf(postsModal);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  List<PostsModal> _buyProduct = [];
  List<PostsModal> get buyProduct => _buyProduct;
  void addBuy(PostsModal postsModal) {
    _buyProduct.add(postsModal);
    notifyListeners();
  }

  //for dashboard:
  List<CategoryModel> _dashCategory = [];

  Future<void> get_dashCategory() async {
    _dashCategory = await FirebaseApi.instance.getCategories();
  }

  List<CategoryModel> get dashCategory => _dashCategory;

  List<PostsModal> _dashProduct = [];

  Future<void> get_dashProduct() async {
    _dashProduct = await FirebaseApi.instance.getBestProduct();
  }

  List<PostsModal> get dashProduct => _dashProduct;

  Future<void> callBack() async {
    await get_dashCategory();
    await get_dashProduct();
    await getAllOrder();
  }

  Future<void> deleteProduct(PostsModal postsModal) async {
    String value =
        await FirebaseApi.instance.deleteProduct(postsModal.id.toString());
    if (value == 'Delete Successfully') {
      _dashProduct.remove(postsModal);
      utils().showToast('Delete Product');
      debugPrint('delete');
    }
    notifyListeners();
  }

  Future<void> updateProduct(int index, PostsModal postsModal) async {
    await FirebaseApi.instance.UpdateProduct(postsModal);
    _dashProduct[index] = postsModal;
    notifyListeners();
  }

  void addProductFunction(
    File image,
    String title,
    String description,
    String price,
    String categoryId,
  ) async {
    PostsModal postsModal = await FirebaseApi.instance
        .addProduct(image, title, description, price, categoryId);
    _dashProduct.add(postsModal);
    notifyListeners();
  }

  List<OrderModel> _orderAllProduct = [];
  List<OrderModel> get orderAllProduct => _orderAllProduct;

  Future<void> getAllOrder() async {
    _orderAllProduct = await FirebaseApi.instance.getAllOrderProduct();
    notifyListeners();
  }

  Future<void> updateOrderStatus(int index, OrderModel orderModel) async {
    await FirebaseApi.instance.updateOrder(orderModel);
    _orderAllProduct[index] = orderModel;
    notifyListeners();
  }
}
