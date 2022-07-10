import 'package:flutter/material.dart';

Container customToggleBtnWidget({
  required List<bool> isSelected,
  required Function(int) onClick,
}) {
  return Container(
    margin: const EdgeInsets.all(30),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: ToggleButtons(
      isSelected: isSelected,
      onPressed: (int index) {
        return onClick(index);
      },
      color: Colors.grey,
      disabledColor: Colors.white,
      renderBorder: false,
      borderWidth: 0,
      borderColor: Colors.white,
      selectedColor: Colors.black,
      borderRadius: BorderRadius.circular(10),
      fillColor: Colors.white,
      selectedBorderColor: Colors.white,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Text(
            '기록',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Text(
            '조회',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    ),
  );
}
