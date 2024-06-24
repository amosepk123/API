import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'List(list)Json.dart';

class Getlist extends StatefulWidget {
  const Getlist({super.key});

  @override
  State<Getlist> createState() => _GetlistState();
}

class _GetlistState extends State<Getlist> {


  Future<List<University>> fetchUniversities() async {
    var res = await http.get(Uri.parse("http://universities.hipolabs.com/search?country=United+States"));
    var data = jsonDecode(res.body);
    return (data as List).map((e) => University.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: fetchUniversities(),
            builder: (BuildContext context, AsyncSnapshot<List<University>> snapshot) {
              if (snapshot.hasData) {
                List<University> universities = snapshot.data!;
                return Container(
                  height: 800,
                  child: ListView.builder(
                    itemCount: universities.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(universities[index].name.toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Country: ${universities[index].country.toString()}"),
                          Text("Alpha Two Code: ${universities[index].alphaTwoCode.toString()}"),
                            Text("Web Pages: ${universities[index].webPages?.join(', ') .toString()}"),
                            Text("Domains: ${universities[index].domains?.join(', ') .toString()}"),
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
