import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class post_task_api extends StatefulWidget {
  const post_task_api({super.key});

  @override
  State<post_task_api> createState() => _post_task_apiState();
}

class _post_task_apiState extends State<post_task_api> {

  Future<bool>? _sucess;

  Future<bool>addMessage(String name,String des)async{
    var res = await http.post(
        Uri.parse("http://catodotest.elevadosoftwares.com/Category/InsertCategory"),
        headers: <String,String>{
          'Content-Type':'application/json; charset=utf-8'
        },
        body: jsonEncode(<String,dynamic>{
          "categoryId": 0,
          "category": name,
          "description": des,
          "createdBy": 1
        })
    );
    return jsonDecode(res.body)["success"];
  }
  TextEditingController name = TextEditingController();
  TextEditingController des = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
              Container(
              child: (_sucess == null ? buildColumn() : buildFuturebuilder()),),

        ],
      ),

    );
  }

  Column buildColumn(){
    return Column(
      children: [
        TextFormField(controller: name,),
        TextFormField(controller: des,),
        ElevatedButton(
          onPressed: (){
            setState(() {
              _sucess = addMessage(name.text, des.text);
            });
          },
          child: Text("save"),
        )
      ],
    );
  }

  FutureBuilder buildFuturebuilder(){
    return FutureBuilder(
        future: _sucess,
        builder: (BuildContext context ,snapshot){
          if(snapshot.hasData){
            return Text("Added successfully");
          } else if(snapshot.hasError){
            return Text("error");
          } return CircularProgressIndicator();
        }
    );
  }
}
