import 'package:flutter/material.dart';

class CustomToggleBtnWidget extends StatefulWidget {
  final List<bool> isSelected;
  final Color? disabledColor;
  final bool? renderBorder;
  final double? borderWidth;
  final Color? borderColor;
  final Color? selectedBorderColor;
  final Color? fillColor;
  final Color? color;
  final Color? selectedColor;
  final BorderRadius? borderRadius;
  final List<Widget> children;
  final Function(int) onPressed;

  const CustomToggleBtnWidget({
    required this.children,
    required this.isSelected,
    required this.onPressed,
    this.disabledColor = Colors.white,
    this.renderBorder = false,
    this.borderWidth = 0,
    this.borderColor = Colors.white,
    this.color = Colors.grey,
    this.selectedColor = Colors.black,
    this.fillColor = Colors.white,
    this.selectedBorderColor = Colors.white,
    this.borderRadius,
  });

  @override
  CustomToggleBtnWidgetState createState() => CustomToggleBtnWidgetState();
}

class CustomToggleBtnWidgetState extends State<CustomToggleBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return (Container(
        margin: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ToggleButtons(
          children: [],
          isSelected: [],
        )));
  }
}
