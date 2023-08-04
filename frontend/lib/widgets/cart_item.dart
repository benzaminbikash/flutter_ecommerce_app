import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/constants/ToastMessage.dart';
import 'package:frontend/model/productModel.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:provider/provider.dart';

class CartItemOne extends StatefulWidget {
  final PostsModal singleProduct;
  const CartItemOne({super.key, required this.singleProduct});

  @override
  State<CartItemOne> createState() => _CartItemOneState();
}

class _CartItemOneState extends State<CartItemOne> {
  int quantity = 1;
  @override
  void initState() {
    quantity = widget.singleProduct.qty ?? 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider productProvider =
        Provider.of<AppProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.4, color: Colors.black)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 100,
              child: Image.network(widget.singleProduct.image.toString(),
                  width: 80, height: 80, fit: BoxFit.cover),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(widget.singleProduct.title.toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              SizedBox(height: 3),
              Text(
                'Rs ' + widget.singleProduct.price.toString(),
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: Row(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                              productProvider.updateQTY(
                                  widget.singleProduct, quantity);
                            } else {
                              quantity = 1;
                            }
                          },
                          child: Text(
                            '-',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 2),
                    Container(
                      width: 30,
                      height: 30,
                      child: Center(
                        child: Text(
                          quantity.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 2),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              quantity++;
                            });
                            productProvider.updateQTY(
                                widget.singleProduct, quantity);
                          },
                          child: Text(
                            '+',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 46),
                child: IconButton(
                    onPressed: () {
                      productProvider.removeCartProduct(widget.singleProduct);
                      utils().showToast('Remove Item');
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.red,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
