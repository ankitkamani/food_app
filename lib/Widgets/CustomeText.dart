import 'package:flutter/material.dart';

class CoustomTextBold extends StatelessWidget {
  final String name;
  const CoustomTextBold({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(name,style: const TextStyle(
      color: Color(0xFF363636),
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),);
  }
}
