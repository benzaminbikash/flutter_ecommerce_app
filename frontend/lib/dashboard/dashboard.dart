// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:frontend/constants/routes.dart';
// import 'package:frontend/dashboard/category_dashboard.dart';
// import 'package:frontend/dashboard/product_dashboard.dart';
// import 'package:frontend/firebase/firebase_api.dart';
// import 'package:frontend/model/Categories%20Model.dart';
// import 'package:frontend/model/productModel.dart';

// class MyDashBoard extends StatefulWidget {
//   const MyDashBoard({super.key});

//   @override
//   State<MyDashBoard> createState() => _MyDashBoardState();
// }

// class _MyDashBoardState extends State<MyDashBoard> {
//   List<CategoryModel> listcategoryproduct = [];
//   List<PostsModal> productlistdata = [];

//   Future<void> getData() async {
//     listcategoryproduct = await FirebaseApi.instance.getCategories();
//     productlistdata = await FirebaseApi.instance.getBestProduct();
//   }

//   @override
//   void initState() {
//     getData().then((_) {
//       setState(() {});
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Dashboard",
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: FutureBuilder<void>(
//         future: getData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             List<Map<String, dynamic>> listdata = [
//               {
//                 "title": "Category",
//                 "data": listcategoryproduct.length,
//                 "id": 1
//               },
//               {"title": "Product", "data": productlistdata.length, "id": 2},
//               {"title": "User", "data": 3, "id": 3}
//             ];

//             return ListView(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: GridView.builder(
//                     physics: ScrollPhysics(),
//                     shrinkWrap: true,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         childAspectRatio: 1,
//                         crossAxisSpacing: 5,
//                         mainAxisSpacing: 5),
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {
//                           if (listdata[index]["id"] == 1) {
//                             Routes.instance.push(
//                                 DashboardCategory(
//                                     categoryData: listcategoryproduct),
//                                 context);
//                           } else if (listdata[index]["id"] == 2) {
//                             Routes.instance.push(DashboardProduct(), context);
//                           }
//                         },
//                         child: Card(
//                           elevation: 29,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 listdata[index]["data"].toString(),
//                                 style: TextStyle(
//                                     fontSize: 50, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 listdata[index]["title"],
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     itemCount: listdata.length,
//                   ),
//                 )
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/dashboard/category_dashboard.dart';
import 'package:frontend/dashboard/product_dashboard.dart';
import 'package:frontend/firebase/firebase_api.dart';
import 'package:frontend/model/Categories%20Model.dart';
import 'package:frontend/model/productModel.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:provider/provider.dart';

class MyDashBoard extends StatefulWidget {
  const MyDashBoard({super.key});

  @override
  State<MyDashBoard> createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  void getData() async {
    setState(() {});
    final productProvider = Provider.of<AppProvider>(context, listen: false);
    await productProvider.callBack();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<AppProvider>(context, listen: false);
    List<Map<String, dynamic>> listdata = [
      {
        "title": "Category",
        "data": productProvider.dashCategory.length.toString(),
        "id": 1
      },
      {
        "title": "Product",
        "data": productProvider.dashProduct.length.toString(),
        "id": 2
      },
      {"title": "User", "data": 3}
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (listdata[index]["id"] == 1) {
                      Routes.instance.push(DashboardCategory(), context);
                    } else if (listdata[index]["id"] == 2) {
                      Routes.instance.push(DashboardProduct(), context);
                    }
                  },
                  child: Card(
                    elevation: 29,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          listdata[index]["data"].toString(),
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          listdata[index]["title"],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: listdata.length,
            ),
          )
        ],
      ),
    );
  }
}
