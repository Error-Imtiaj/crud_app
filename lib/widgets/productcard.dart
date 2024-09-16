import 'package:crud_app/screens/Product_screen.dart';
import 'package:crud_app/screens/update.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Productcard extends StatefulWidget {
  final String ProductName;
  final String ProductCode;
  final String Qty;
  final String TotalPrice;
  final String id;

  const Productcard(
      {super.key,
      required this.ProductName,
      required this.ProductCode,
      required this.Qty,
      required this.TotalPrice,
      required this.id});

  @override
  State<Productcard> createState() => _ProductcardState();
}

class _ProductcardState extends State<Productcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10), // softer shadow
            blurRadius: 10, // higher blur for a smoother shadow
            spreadRadius: 2, // spreading the shadow a bit
            offset: Offset(0, 6), // position of the shadow
          ),
        ],
      ),
      //height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /* Container(
            width: 150,
            height: 150,
            child: Image.network(
              'https://plus.unsplash.com/premium_photo-1664392147011-2a720f214e01?q=80&w=2078&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              fit: BoxFit.cover,
            ),
          ), */
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.ProductName}",
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(
                    "CODE : ${widget.ProductCode}, QTY: ${widget.Qty}",
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.grey),
                  ),
                  Text(
                    "\$ ${widget.TotalPrice}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),

          // button
          Expanded(
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return UpdateProduct(
                          id: widget.id,
                        );
                      }));
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      delete(widget.id);
                      setState(() {
                        ProductScreen();
                      });
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>> delete(
      String id) async {
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/DeleteProduct/$id');
    print(uri);
    Response response = await get(uri);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product DELETED'),
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
        content: Text('Something happended'),
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
