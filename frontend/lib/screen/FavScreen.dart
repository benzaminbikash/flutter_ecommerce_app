import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/model/productModel.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:frontend/widgets/fav_item.dart';
import 'package:provider/provider.dart';

class FavScreenProduct extends StatefulWidget {
  const FavScreenProduct({super.key});

  @override
  State<FavScreenProduct> createState() => _FavScreenProductState();
}

class _FavScreenProductState extends State<FavScreenProduct> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<AppProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorite Items',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Expanded(
            child: productProvider.getFavProduct.isEmpty
                ? Center(
                    child: Text(
                    'No Favorite Items',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ))
                : Consumer<AppProvider>(builder: (context, value, child) {
                    List<PostsModal> favItem = value.getFavProduct;
                    return ListView.builder(
                        itemCount: favItem.length,
                        itemBuilder: (context, index) {
                          return MyFavItem(
                            singleProduct: favItem[index],
                          );
                        });
                  }),
          )
        ]),
      ),
    );
  }
}
