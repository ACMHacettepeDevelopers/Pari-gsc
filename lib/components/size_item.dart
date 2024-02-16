import 'package:flutter/material.dart';

class SizeItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool selected;

  const SizeItem({
    required this.onPressed,
    required this.label,
    required this.selected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          border: Border.all(color: selected ? Colors.blue : Colors.black),
          borderRadius: BorderRadius.circular(8.0),
          color: selected ? Colors.blue : Colors.white,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
