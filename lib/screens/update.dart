import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';

class UpdateProduct extends StatefulWidget {
  final String id;
  const UpdateProduct({super.key, required this.id});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  GlobalKey<FormState> _muformkey = GlobalKey<FormState>();
  TextEditingController nameControl = TextEditingController();
  TextEditingController codecontroller = TextEditingController();
  TextEditingController quantitycontrol = TextEditingController();
  TextEditingController totalcontrol = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameControl.dispose();
    codecontroller.dispose();
    quantitycontrol.dispose();
    totalcontrol.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: myForm(),
      ),
    );
  }

  Widget myForm() {
    return Form(
      key: _muformkey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: "Product Name"),
            controller: nameControl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter a Valid Value";
              }
              return null;
            },
          ),
          Gap(10),
          TextFormField(
            decoration: InputDecoration(hintText: "Product Code"),
            controller: codecontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter a Valid Value";
              }
              return null;
            },
          ),
          Gap(10),
          TextFormField(
            decoration: InputDecoration(hintText: "Product Quantity"),
            controller: quantitycontrol,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  num.tryParse(value) == null) {
                return "Enter a Valid Value like number";
              }
              return null;
            },
          ),
          Gap(10),
          TextFormField(
            decoration: InputDecoration(hintText: "Product Price"),
            controller: totalcontrol,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  num.tryParse(value) == null) {
                return "Enter a Valid Value like number";
              }
              return null;
            },
          ),
          Gap(20),

          // button
          ElevatedButton(
            onPressed: () {
              if (_muformkey.currentState!.validate()) {
                UpdateProduct(widget.id);
                setState(() {});
                nameControl.clear();
                codecontroller.clear();
                quantitycontrol.clear();
                totalcontrol.clear();
              }
            },
            child: Text("UPDATE PRODUCT"),
            style: ElevatedButton.styleFrom(
                shape: ContinuousRectangleBorder(),
                backgroundColor: Colors.amberAccent),
          )
        ],
      ),
    );
  }

  Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
      UpdateProduct(String id) async {
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/UpdateProduct/$id');
    Map<String, dynamic> sendValue = {
      "ProductName": nameControl.text,
      "ProductCode": codecontroller.text,
      "Qty": quantitycontrol.text,
      "TotalPrice": totalcontrol.text,
    };

    Response response = await post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(sendValue));
    if (response.statusCode == 200) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PRODUCT UPDATED'),
          duration: Duration(seconds: 3), // how long the SnackBar will stay
          backgroundColor:
              Colors.blueAccent, // background color of the SnackBar
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.white,
            onPressed: () {
              // Code to execute when the action is pressed
              print('Undo clicked');
            },
          ),
        ),
      );
    }
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Something Happend please try again'),
        duration: Duration(seconds: 3), // how long the SnackBar will stay
        backgroundColor: Colors.blueAccent, // background color of the SnackBar
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            // Code to execute when the action is pressed
            print('Undo clicked');
          },
        ),
      ),
    );
  }
}
