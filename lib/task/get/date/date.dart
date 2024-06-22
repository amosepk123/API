import 'package:flutter/material.dart';
import 'package:api/task/get/date/shorted_by%20date.dart';

class DatePage extends StatefulWidget {
  const DatePage({super.key});

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0]; // format as yyyy-MM-dd
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: start,
            readOnly: true,
            onTap: () => _selectDate(context, start),
            decoration: InputDecoration(
              hintText: 'Select Start Date',
            ),
          ),
          TextFormField(
            controller: end,
            readOnly: true,
            onTap: () => _selectDate(context, end),
            decoration: InputDecoration(
              hintText: 'Select End Date',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (start.text.isNotEmpty && end.text.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShorttedByDate(start: start.text, end: end.text),
                  ),
                );
              }
            },
            child: Text("Result"),
          ),
        ],
      ),
    );
  }
}
