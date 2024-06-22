import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../getlist/modal.dart';

class getSingleSSSS extends StatefulWidget {
  final int id;
  const getSingleSSSS({super.key, required this.id});

  @override
  State<getSingleSSSS> createState() => _getSingleSSSSState();
}

class _getSingleSSSSState extends State<getSingleSSSS> {
  Future<Products> fetch() async {
    final int id = widget.id;
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products/$id"));
    return Products.fromJson(jsonDecode(res.body));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  return ListTile(
                    leading: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(snapshot.data!.image!),fit: BoxFit.fill)
                      ),

                    ),
                    title: Column(
                      children: [
                        Text(snapshot.data!.id!.toString()),
                        Text(snapshot.data!.title!.toString()),
                        Text(snapshot.data!.category!.toString()),
                        Text(snapshot.data!.description!.toString()),
                        Text(snapshot.data!.price!.toString()),
                        Text(snapshot.data!.rating!.count.toString()),
                        Text(snapshot.data!.rating!.rate.toString()),
                      ],
                    ),
                  );
                } else if(snapshot.hasError){
                  return Text("error");
                }
                return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
