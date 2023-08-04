import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/constants/ToastMessage.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/model/productModel.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:frontend/screen/FavScreen.dart';
import 'package:frontend/screen/buy_screen.dart';
import 'package:frontend/screen/cartScreen.dart';
import 'package:provider/provider.dart';

class MyDetailProduct extends StatefulWidget {
  final PostsModal singleProduct;
  const MyDetailProduct({super.key, required this.singleProduct});

  @override
  State<MyDetailProduct> createState() => _MyDetailProductState();
}

class _MyDetailProductState extends State<MyDetailProduct> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(actions: [
        if (productProvider.usermodel.roll != 'admin')
          IconButton(
              onPressed: () {
                Routes.instance.push(MyCart(), context);
              },
              icon: Icon(Icons.shopping_cart
                  //
                  )),
      ]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 260,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  widget.singleProduct.image.toString(),
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.singleProduct.title.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        widget.singleProduct.isFavorite =
                            !widget.singleProduct.isFavorite!;
                      });
                      if (widget.singleProduct.isFavorite!) {
                        productProvider.addFavProduct(widget.singleProduct);
                        utils().showToast('Add Favorite Product');
                      } else {
                        productProvider.removeFavProduct(widget.singleProduct);
                        utils().showToast('Remove from Favorite Product');
                      }
                    },
                    icon: Icon(productProvider.getFavProduct
                            .contains(widget.singleProduct)
                        ? Icons.favorite
                        : Icons.favorite_border))
              ],
            ),
            Container(
              width: double.infinity,
              height: 240,
              child: Text(
                widget.singleProduct.description.toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            if (productProvider.usermodel.roll != 'admin')
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 170,
                    height: 50,
                    child: OutlinedButton(
                        onPressed: () {
                          if (productProvider.getCartProduct
                              .contains(widget.singleProduct)) {
                            productProvider
                                .removeCartProduct(widget.singleProduct);
                            utils().showToast('Remove to Cart');
                          } else {
                            productProvider
                                .addCartProduct(widget.singleProduct);
                            utils().showToast('Add to Cart');
                          }
                          setState(() {});
                        },
                        child: Text(
                          productProvider.getCartProduct
                                  .contains(widget.singleProduct)
                              ? 'Remove to cart'
                              : 'Add to cart',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 170,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Routes.instance.push(
                            BuyScreen(
                                singleProduct: widget.singleProduct
                                    .copyWith(qty: quantity)),
                            context);
                      },
                      child: Text('Buy'),
                    ),
                  )
                ],
              ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
