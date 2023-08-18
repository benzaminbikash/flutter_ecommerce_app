import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/constants/ToastMessage.dart';
import 'package:frontend/model/OrderModel.dart';
import 'package:frontend/provider/appProvider.dart';
import 'package:frontend/widgets/commonButton.dart';
import 'package:provider/provider.dart';

class EditOrder extends StatefulWidget {
  final OrderModel orderModel;
  final int index;
  const EditOrder({super.key, required this.orderModel, required this.index});

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  TextEditingController status = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Order Status',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: status,
              decoration: InputDecoration(hintText: 'Status'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: MyCustomButton(
                title: 'Status Update',
                voidCallback: () {
                  if (status.text.isEmpty) {
                    utils().showToast("Please Add a Status");
                  } else {
                    OrderModel orderModel = OrderModel(
                        id: widget.orderModel.id,
                        status: status.text,
                        payment: widget.orderModel.payment,
                        product: widget.orderModel.product);
                    productProvider.updateOrderStatus(widget.index, orderModel);
                    utils().showToast("Update Status!");
                  }
                }),
          )
        ],
      ),
    );
  }
}
