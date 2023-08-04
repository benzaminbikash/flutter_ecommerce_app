import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/dashboard/AddProduct.dart';
import 'package:frontend/dashboard/eidt_product.dart';
import 'package:frontend/model/Categories%20Model.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:provider/provider.dart';

class DashboardProduct extends StatefulWidget {
  DashboardProduct({super.key});

  @override
  State<DashboardProduct> createState() => _DashboardProductState();
}

class _DashboardProductState extends State<DashboardProduct> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Routes.instance.push(AddProduct(), context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Product List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<AppProvider>(
        builder: (context, child, value) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: productProvider.dashProduct.length,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                return InkWell(
                  child: Card(
                    elevation: 29,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 10,
                          top: 5,
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Routes.instance.push(
                                        EditProduct(
                                          postsModal: productProvider
                                              .dashProduct[index],
                                          index: index,
                                        ),
                                        context);
                                  },
                                  child: Icon(Icons.edit)),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  setState(() {});
                                  productProvider.deleteProduct(
                                      productProvider.dashProduct[index]);
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.network(
                                productProvider.dashProduct[index].image
                                    .toString(),
                                width: 70,
                                height: 70,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              productProvider.dashProduct[index].title
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Rs ${productProvider.dashProduct[index].price.toString()}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
