import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cart.dart';

class ShorttedByDate extends StatefulWidget {
  final String start;
  final String end;
  const ShorttedByDate({super.key, required this.start, required this.end});

  @override
  State<ShorttedByDate> createState() => _ShorttedByDateState();
}

class _ShorttedByDateState extends State<ShorttedByDate> {
  Future<List<Cart>> fetch() async {
    final String start = widget.start;
    final String end = widget.end;
    var res = await http.get(Uri.parse("https://fakestoreapi.com/carts?startdate=${start}&enddate=${end}"));
    var data = jsonDecode(res.body);
    return (data as List).map((e) => Cart.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<List<Cart>>(
            future: fetch(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                List<Cart> list = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(list);
                      return ListTile(
                        title: Text("Cart ID: ${list[index].id}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("User ID: ${list[index].userId}"),
                            Text("Date: ${list[index].date}"),
                            Text("Products:"), ...?list[index].products?.map((product) => Text("  Product ID: ${product.productId}, Quantity: ${product.quantity}")),
                          //   Text("product\n productId: ${list[index].products?[index].productId},"),
                          //   Text("product\n quantity: ${list[index].products?[index].quantity},"),
                          // Text("product\n productId: ${list[index].products?[index].productId},"),
                          //  Text("product\n quantity: ${list[index].products?[index].productId},"),
                          //   Text("product\n productId: ${list[index].products?[index].productId},"),
                            //Text("product\n quantity: ${list[index].products?[index].productId},"),

                           ],

                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}

// class Cart {
//   final int id;
//   final int userId;
//   final String date;
//   final List<Product> products;
//
//   Cart({required this.id, required this.userId, required this.date, required this.products});
//
//   factory Cart.fromJson(Map<String, dynamic> json) {
//     var productsFromJson = json['products'] as List;
//     List<Product> productList = productsFromJson.map((i) => Product.fromJson(i)).toList();
//     return Cart(
//       id: json['id'],
//       userId: json['userId'],
//       date: json['date'],
//       products: productList,
//     );
//   }
// }
//
// class Product {
//   final int productId;
//   final int quantity;
//
//   Product({required this.productId, required this.quantity});
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       productId: json['productId'],
//       quantity: json['quantity'],
//     );
//   }
// }
