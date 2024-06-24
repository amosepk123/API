import 'dart:convert';
import 'package:api/task/randomUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class randomUser extends StatefulWidget {
  const randomUser({super.key});

  @override
  State<randomUser> createState() => _randomUserState();
}

class _randomUserState extends State<randomUser> {
  Future<Randomuser> fetchZippo() async {
    var res = await http.get(Uri.parse("https://randomuser.me/api/"));
    var data = jsonDecode(res.body);
    return Randomuser.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random User'),
      ),
      body: FutureBuilder<Randomuser>(
        future: fetchZippo(),
        builder: (BuildContext context, AsyncSnapshot<Randomuser> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Randomuser RandomUser = snapshot.data!;
            return ListView.builder(
              itemCount: RandomUser.results!.length,
              itemBuilder: (context, index) {
                var result = RandomUser.results![index];
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text('gender: ${result.gender.toString()}', style: TextStyle(fontSize: 16)),
                      Text('name\n title: ${result.name?.title!.toString()}', style: TextStyle(fontSize: 16)),
                      Text('name\n first: ${result.name?.first!.toString()}', style: TextStyle(fontSize: 16)),
                      Text('name\n last: ${result.name?.last!.toString()}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5,),
                      Text("Location\n street\n number:${result.location?.street?.number!.toString()}", style: TextStyle(fontSize: 16)),
                      Text("Location\n street\n name:${result.location?.street?.name!.toString()}", style: TextStyle(fontSize: 16)),
                      Text("Location\n city:${result.location?.city!.toString()}", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: randomUser(),
  ));
}
