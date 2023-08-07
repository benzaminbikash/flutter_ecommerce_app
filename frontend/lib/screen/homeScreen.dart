import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/auth_screen/loginScreen.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:frontend/screen/productDetailScreen.dart';
import 'package:frontend/screen/welcomeScreen.dart';
import 'package:frontend/widgets/bottomWidget.dart';
import 'package:frontend/widgets/commonheader.dart';
import '../firebase/firebase_api.dart';
import '../model/Categories Model.dart';
import '../model/productModel.dart';
import 'categoryScreen.dart';
import 'package:provider/provider.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<CategoryModel> listcategoryproduct = [];
  List<PostsModal> productlistdata = [];
  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserData();
    getApi();
    super.initState();
  }

  void getApi() async {
    setState(() {
      isLoading = true;
    });
    listcategoryproduct = await FirebaseApi.instance.getCategories();
    productlistdata = await FirebaseApi.instance.getBestProduct();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(Icons.notes),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.black,
              child: Text(
                appProvider.usermodel.name!.substring(0, 1),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 1,
                      ),
                    ])
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Best Mobile \nin your hand.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 250, 249, 249),
                        ),
                        width: double.infinity,
                        height: 55,
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search_sharp),
                            hintText: 'Search',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 8),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: listcategoryproduct
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: InkWell(
                                      onTap: () {
                                        Routes.instance.push(
                                            MyCategoryPage(categoryModel: e),
                                            context);
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 15,
                                        child: SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: Image.network(
                                            e.image.toString(),
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList())),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'All Products',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // MyBestProduct()
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
                            elevation: 29,
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
//2.1
