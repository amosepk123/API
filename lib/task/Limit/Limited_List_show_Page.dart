import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../getlist/modal.dart';

class Limited_list extends StatefulWidget {
  final int id;
  const Limited_list({super.key, required this.id});

  @override
  State<Limited_list> createState() => _Limited_listState();
}

class _Limited_listState extends State<Limited_list> {
  Future<List<Products>> fetch() async {
    final int id = widget.id;
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products?limit=$id"));
    var data = jsonDecode(res.body);
    return (data as List).map((e) => Products.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<List<Products>>(
            future: fetch(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                List<Products> list = snapshot.data!;
                return Container(
                  height: 800,
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(list[index].image!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        title: Column(
                          children: [
                            Text(list[index].id!.toString()),
                            Text(list[index].title!.toString()),
                            Text(list[index].category!.toString()),
                            Text(list[index].description!.toString()),
                            Text(list[index].price!.toString()),
                            Text(list[index].rating!.count.toString()),
                            Text(list[index].rating!.rate.toString()),
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
