
import 'package:api/post_task/post/post1.dart';
import 'package:api/post_task/post/task%202.dart';
import 'package:api/task/Limit/Limit.dart';
import 'package:api/task/List(List).dart';
import 'package:api/task/Zippo%5Blist(list).dart';
import 'package:api/task/get/date/date.dart';
import 'package:api/task/randomUser(list).dart';
import 'package:flutter/material.dart';

import 'get/getapi.dart';
import 'get/getapi2.dart';
import 'get/getapi6.dart';
import 'getlist/getlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DatePage()
    );
  }
}

