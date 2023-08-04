import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/model/Categories%20Model.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:provider/provider.dart';

class DashboardCategory extends StatefulWidget {
  DashboardCategory({super.key});

  @override
  State<DashboardCategory> createState() => _DashboardCategoryState();
}

class _DashboardCategoryState extends State<DashboardCategory> {
  @override
  Widget build(BuildContext context) {
    // print(widget.categoryData);
    final productProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Category Product',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<AppProvider>(
        builder: (context, child, value) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: productProvider.dashCategory.length,
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
                        // Positioned(
                        //   right: 10,
                        //   top: 5,
                        //   child: Row(
                        //     children: [
                        //       InkWell(child: Icon(Icons.edit)),
                        //       SizedBox(width: 5),
                        //       InkWell(
                        //         child: Icon(
                        //           Icons.delete,
                        //           color: Colors.red,
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.network(
                                productProvider.dashCategory[index].image
                                    .toString(),
                                width: 70,
                                height: 70,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              productProvider.dashCategory[index].title
                                  .toString(),
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
