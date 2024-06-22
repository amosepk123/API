import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Agify.dart';

class getapi2 extends StatefulWidget {
  const getapi2({super.key});

  @override
  State<getapi2> createState() => _getapi2State();
}

class _getapi2State extends State<getapi2> {
  
  Future<Agify> fetch2() async{
    var result= await http.get(Uri.parse("https://api.agify.io?name=meelad"));
    return Agify.fromJson(jsonDecode(result.body));
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch2(),
              builder: (BuildContext context,snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.count.toString()),
                      Text(snapshot.data!.name.toString()),
                      Text(snapshot.data!.age.toString()),
                    ],
                  );
                }else if(snapshot.hasError){
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();

              }
          ),
        ],
      ),
    );
  }
}
