import 'dart:convert';
import 'package:crud_app/models/product_models.dart';
import 'package:crud_app/screens/add_product.dart';
import 'package:crud_app/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<ProductModels> ProductList = [];
  bool isload = false;

  Future<void> getResponse() async {
    isload = true;
    ProductList.clear();
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
    Response response = await get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      for (var i in jsonResponse['data']) {
        ProductModels product = ProductModels(
          id: '${i['_id']}',
          ProductName: '${i['ProductName']}',
          ProductCode: '${i['ProductCode']}',
          Img: '${i['Img']}',
          Qty: '${i['Qty']}',
          TotalPrice: '${i['TotalPrice']}',
          CreatedDate: '${i['CreatedDate']}',
        );
        ProductList.add(product);
      }
      isload = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PRODUCTS"),
        actions: [
          IconButton(
              onPressed: () {
                getResponse();
              },
              icon: Icon(Icons.replay_outlined))
        ],
      ),
      body: isload
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemCount: ProductList.length,
                itemBuilder: (context, index) {
                  return Productcard(
                    ProductName: ProductList.elementAt(index).ProductName,
                    ProductCode: ProductList.elementAt(index).ProductCode,
                    Qty: ProductList.elementAt(index).Qty,
                    TotalPrice: ProductList.elementAt(index).TotalPrice,
                    id: ProductList.elementAt(index).id,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10,
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return AddProduct();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
