import 'package:flutter/material.dart';

class AlertNotification extends StatelessWidget {
  final String title;
  final String message;
  AlertNotification({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
      title: Text(title, style: TextStyle(color: Colors.white)),
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          child: Text(
            "OK",
            style: TextStyle(color: Color.fromARGB(255, 4, 192, 60)),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
