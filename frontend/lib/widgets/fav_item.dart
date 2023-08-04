import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/constants/ToastMessage.dart';
import 'package:frontend/model/productModel.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:provider/provider.dart';

class MyFavItem extends StatelessWidget {
  final PostsModal singleProduct;
  MyFavItem({super.key, required this.singleProduct});

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
              child: Image.network(singleProduct.image.toString(),
                  width: 80, height: 80, fit: BoxFit.cover),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(singleProduct.title.toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              SizedBox(height: 3),
              Text(
                'Rs ' + singleProduct.price.toString(),
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 46),
                child: IconButton(
                    onPressed: () {
                      productProvider.removeFavProduct(singleProduct);
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
    ;
  }
}
