import 'package:flutter/material.dart';

Future<void> showTextInputDialog({
  required BuildContext context,
  required String title,
  String? initialText,
  required TextInputType keyboardType,
  required Function(String) onSubmitted,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext ctxt) {
      final controller = TextEditingController(text: initialText);
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 43, 43, 43),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color.fromARGB(255, 4, 192, 60),
                  ),
                ),
              ],
            ),
            TextField(
              autofocus: true,
              controller: controller,
              keyboardType: keyboardType,
              textAlignVertical: TextAlignVertical.bottom,
              style: TextStyle(color: Colors.white),
              cursorColor:Color.fromARGB(255, 4, 192, 60),
              decoration: InputDecoration(
                hintText: 'Playlist Name',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 4, 192, 60)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 4, 192, 60)),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 4, 192, 60)),
                ),
              ),
              onSubmitted: (value) {
                onSubmitted(value);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Color.fromARGB(255, 4, 192, 60),
            ),
            onPressed: () {
              onSubmitted(controller.text.trim());
            },
            child: Text(
              'Ok',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      );
    },
  );
}
