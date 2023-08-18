import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/dashboard/EditOrder.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:provider/provider.dart';

class OrderProductList extends StatefulWidget {
  const OrderProductList({super.key});

  @override
  State<OrderProductList> createState() => _OrderProductListState();
}

class _OrderProductListState extends State<OrderProductList> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
          itemCount: productProvider.orderAllProduct.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Routes.instance.push(
                      EditOrder(
                        orderModel: productProvider.orderAllProduct[index],
                        index: index,
                      ),
                      context);
                },
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Image.network(productProvider
                          .orderAllProduct[index].product[0].image
                          .toString()),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            productProvider
                                .orderAllProduct[index].product[0].title
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 3),
                          Text(
                              'Rs ${productProvider.orderAllProduct[index].product[0].price.toString()}'),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          productProvider.orderAllProduct[index].status
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
