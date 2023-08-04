import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/model/productModel.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:frontend/screen/buy_screen.dart';
import 'package:frontend/widgets/cart_item.dart';
import 'package:frontend/widgets/commonButton.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<AppProvider>(context, listen: false);
    // bool hasItemsInCart = productProvider.getCartProduct.isNotEmpty;
    return Scaffold(
        appBar: AppBar(
          title: Text('My Cart', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Expanded(
              child: productProvider.getCartProduct.isEmpty
                  ? Center(
                      child: Text(
                      'No Items in Cart',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ))
                  : Consumer<AppProvider>(builder: (context, value, child) {
                      List<PostsModal> cartItems = value.getCartProduct;
                      return ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            return CartItemOne(
                              singleProduct: cartItems[index],
                            );
                          });
                    }),
            )
          ]),
        ));
    // bottomNavigationBar: hasItemsInCart
    //     ? Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: SizedBox(
    //           height: 100,
    //           child: Column(
    //             children: [
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     'Total',
    //                     style: TextStyle(
    //                         fontSize: 17,
    //                         color: Colors.black,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                   Text(
    //                     "Rs ${productProvider.totalPrice().toString()}",
    //                     style: TextStyle(
    //                         fontSize: 17,
    //                         color: Colors.black,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                 ],
    //               ),
    //               SizedBox(height: 30),
    //               MyCustomButton(
    //                 title: 'Checkout',
    //                 voidCallback: () {
    //                   // Routes.instance.push(BuyScreen(), context);
    //                 },
    //               )
    //             ],
    //           ),
    //         ),
    //       )
    //     : null);
  }
}
// 29