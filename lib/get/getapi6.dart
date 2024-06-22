import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../class6.dart';

class getapi6 extends StatefulWidget {
  const getapi6({super.key});

  @override
  State<getapi6> createState() => _getapi6State();
}

class _getapi6State extends State<getapi6> {
  
  Future<Class6> fetch()async{
    var result=await http.get(Uri.parse("https://api.genderize.io?name=luc"));
    return Class6.fromJson(jsonDecode(result.body));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext context,snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.count.toString()),
                      Text(snapshot.data!.name.toString()),
                      Text(snapshot.data!.probability.toString()),
                      Text(snapshot.data!.gender.toString()),
                    ],
                  );
                }
                else if(snapshot.hasError){
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
