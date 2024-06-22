import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modal.dart';
class getapi extends StatefulWidget {
  const getapi({super.key});

  @override
  State<getapi> createState() => _getapiState();
}

class _getapiState extends State<getapi> {

  Future<Catfact> fetch() async {
    var result = await http.get(Uri.parse("https://catfact.ninja/fact"));
    return Catfact.fromJson(jsonDecode(result.body));
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
                  return Column(
                    children: [
                      Text(snapshot.data!.fact.toString()),
                      Text(snapshot.data!.length.toString()),
                    ],
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
