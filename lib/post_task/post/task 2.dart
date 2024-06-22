import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class post_task_2 extends StatefulWidget {
  const post_task_2({super.key});

  @override
  State<post_task_2> createState() => _post_task_2State();
}

class _post_task_2State extends State<post_task_2> {

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController gst = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contactperson = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  Future<bool>? _success;
  Future<bool> addMessage(String name,phone,address,gst,website,email,contactperson,phoneNumber) async {
    var res = await http.post(
        Uri.parse("http://catodotest.elevadosoftwares.com/Client/InsertClient"),
        headers: <String,String>{
          'Content-Type':'application/json; charset=utf-8'
        },
        body: jsonEncode(<String,dynamic>{
          "clientId": 0,
          "clientName": name,
          "phone": phone,
          "address": address,
          "gst": gst,
          "website": website,
          "email": email,
          "contactPerson": contactperson,
          "phoneNumber": phoneNumber,
          "createdBy": 1
        })
    );
    return jsonDecode(res.body)["success"];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: (_success==null? buildColumn():buildFuturebuilder()),
          ),
        ],
      ),
    );
  }
  Column buildColumn(){
    return Column(
      children: [
        TextFormField(controller: name,decoration: InputDecoration(hintText: "name"),),
        TextFormField(controller: phone,decoration: InputDecoration(hintText: "phone"),),
        TextFormField(controller: address,decoration: InputDecoration(hintText: "address"),),
        TextFormField(controller: gst,decoration: InputDecoration(hintText: "gst"),),
        TextFormField(controller: website,decoration: InputDecoration(hintText: "website"),),
        TextFormField(controller: email,decoration: InputDecoration(hintText: "email"),),
        TextFormField(controller: contactperson,decoration: InputDecoration(hintText: "contactperson"),),
        TextFormField(controller: phoneNumber,decoration: InputDecoration(hintText: "PhoneNumber"),),


        ElevatedButton(
          onPressed: (){
            setState(() {
              _success = addMessage(name.text, phone.text,address.text,gst.text,website.text,email.text,contactperson.text,phoneNumber.text);
            });
          },
          child: Text("save"),
        )
      ],
    );
  }

  FutureBuilder buildFuturebuilder(){
    return FutureBuilder(
        future: _success,
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            return Text("Added successfully");
          } else if(snapshot.hasError){
            return Text("error");
          } return CircularProgressIndicator();
        }
    );
  }
}
