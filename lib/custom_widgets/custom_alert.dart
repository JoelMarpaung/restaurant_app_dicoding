import 'package:flutter/material.dart';

import '../enums/alert_enum.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String content;
  final AlertEnum status;
  const CustomAlert({Key? key, required this.title, required this.content, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Close"),
        )
      ],
    );
  }
}
