import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  TextEditingController _dateController = TextEditingController();
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second page"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: IconButton(
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      String formattedDate =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                      _dateController.text = formattedDate;
                    }
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              prefix: checkBox(),
              filled: true,
              fillColor: isChecked ? Colors.grey : Colors.white,
            ),
          ),
          Center(
            child: checkBox(),
          ),
        ],
      ),
    );
  }

  Widget checkBox() {
    return Checkbox(
      focusColor: Colors.yellow,
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
