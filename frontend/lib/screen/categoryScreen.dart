import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/model/Categories%20Model.dart';
import 'package:frontend/model/productModel.dart';
import 'package:frontend/screen/productDetailScreen.dart';

import '../constants/routes.dart';
import '../firebase/firebase_api.dart';

class MyCategoryPage extends StatefulWidget {
  final CategoryModel categoryModel;
  const MyCategoryPage({super.key, required this.categoryModel});

  @override
  State<MyCategoryPage> createState() => _MyCategoryPageState();
}

class _MyCategoryPageState extends State<MyCategoryPage> {
  List<PostsModal> productlistdata = [];
  bool loading = false;

  void getFetchApi() async {
    setState(() {
      loading = true;
    });
    productlistdata = await FirebaseApi.instance
        .productOnCategory(widget.categoryModel.id.toString());
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getFetchApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.categoryModel.title.toString(),
            style: TextStyle(color: Colors.black),
          )),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 3,
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        PostsModal product = productlistdata[index];
                        return Card(
                          elevation: 60,
                          child: Column(
                            children: [
                              Image.network(
                                product.image.toString(),
                                width: 120,
                                height: 120,
                              ),
                              Text(
                                product.title.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Price'),
                                  SizedBox(width: 6),
                                  Text('Rs'),
                                  SizedBox(width: 1),
                                  Text(product.price.toString())
                                ],
                              ),
                              SizedBox(height: 5),
                              OutlinedButton(
                                  onPressed: () {
                                    Routes.instance.push(
                                        MyDetailProduct(
                                          singleProduct: product,
                                        ),
                                        context);
                                  },
                                  child: Text('Buy'),
                                  style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        width: 1.7,
                                        color: Colors.black,
                                      ),
                                      foregroundColor: Colors.black,
                                      fixedSize: Size(100, 30)))
                            ],
                          ),
                        );
                      },
                      itemCount: productlistdata.length,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
