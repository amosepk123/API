import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Zippo[List(list)]json.dart';


class Zippo extends StatefulWidget {
  const Zippo({super.key});

  @override
  State<Zippo> createState() => _ZippoState();
}

class _ZippoState extends State<Zippo> {
  Future<Zippopotam> fetchZippo() async {
    var res = await http.get(Uri.parse("https://api.zippopotam.us/us/33162"));
    var data = jsonDecode(res.body);
    return Zippopotam.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zippopotam Data'),
      ),
      body: FutureBuilder<Zippopotam>(
        future: fetchZippo(),
        builder: (BuildContext context, AsyncSnapshot<Zippopotam> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Zippopotam zippopotam = snapshot.data!;
            return ListView.builder(
              itemCount: zippopotam.places!.length,
              itemBuilder: (context, index) {
                var place = zippopotam.places![index];
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Country: ${zippopotam.country ?? 'N/A'}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Post Code: ${zippopotam.postCode ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                      Text('Country Abbreviation: ${zippopotam.countryAbbreviation ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      Text('Place Name: ${place.placeName.toString()}', style: TextStyle(fontSize: 16)),
                      Text('State: ${place.state.toString()}', style: TextStyle(fontSize: 16)),
                      Text('State Abbreviation: ${place.stateAbbreviation.toString()}', style: TextStyle(fontSize: 16)),
                      Text('Latitude: ${place.latitude.toString()}', style: TextStyle(fontSize: 16)),
                      Text('Longitude: ${place.longitude.toString()}', style: TextStyle(fontSize: 16)),
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


