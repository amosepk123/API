import 'package:flutter/material.dart';

import 'Limited_List_show_Page.dart';

class Limit extends StatefulWidget {
  const Limit({super.key});

  @override
  State<Limit> createState() => _LimitState();
}

class _LimitState extends State<Limit> {
  final TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: TextFormField(
              controller: ctrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter the number",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.isNotEmpty) {
                int limit = int.parse(ctrl.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Limited_list(id: limit),
                  ),
                );
              }
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
