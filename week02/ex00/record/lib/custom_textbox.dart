import 'package:flutter/material.dart';

Container customTextBox({
  required String title,
  required String content,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    margin: const EdgeInsets.all(15),
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: content,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
              ),
            ),
            const WidgetSpan(
              child: SizedBox(
                width: 25,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
