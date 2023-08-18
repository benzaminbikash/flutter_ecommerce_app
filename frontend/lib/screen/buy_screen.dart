import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/constants/ToastMessage.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/firebase/firebase_api.dart';
import 'package:frontend/model/productModel.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:frontend/widgets/bottomWidget.dart';
import 'package:frontend/widgets/commonButton.dart';
import 'package:provider/provider.dart';

class BuyScreen extends StatefulWidget {
  final PostsModal singleProduct;
  const BuyScreen({super.key, required this.singleProduct});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  String _paymentMethod = "cash on delivery";
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          RadioListTile(
            title: Text("Cash On Delivery"),
            value: "cash on delivery",
            groupValue: _paymentMethod,
            onChanged: (value) {
              setState(() {
                _paymentMethod = value.toString();
              });
            },
            activeColor: Colors.black,
          ),
          RadioListTile(
            title: Text("Online Payment"),
            value: "online",
            groupValue: _paymentMethod,
            onChanged: (value) {
              setState(() {
                _paymentMethod = value.toString();
              });
            },
            activeColor: Colors.black,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: MyCustomButton(
              title: "Order",
              voidCallback: () async {
                if (_paymentMethod == 'cash on delivery') {
                  productProvider.buyProduct.clear();
                  productProvider.addBuy(widget.singleProduct);
                  bool value = await FirebaseApi.instance.userOrderProduct(
                      productProvider.buyProduct, _paymentMethod);
                } else {
                  utils()
                      .showToast("We don't provide online payment right now!");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
