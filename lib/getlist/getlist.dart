import 'dart:convert';

import 'package:api/getlist/getSingle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../task/task1_id.dart';
import 'modal.dart';
class getlist extends StatefulWidget {
  const getlist({super.key});

  @override
  State<getlist> createState() => _getlistState();
}

class _getlistState extends State<getlist> {


  Future<List<Products>> fetch() async {
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data = jsonDecode(res.body);
    return (data as List).map((e) => Products.fromJson(e)).toList();
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
                  List<Products> list = snapshot.data!;
                  return Container(
                    height: 800,
                    child: ListView.builder(
                      itemCount: list.length,
                        itemBuilder: (BuildContext context, int index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => getSingleSSSS(id: list[index].id!,)));
                          },
                          child: ListTile(
                            leading: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(list[index].image!),fit: BoxFit.fill
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
                          ),
                        );
                        }
                    ),
                  );
                } else if(snapshot.hasError){
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
