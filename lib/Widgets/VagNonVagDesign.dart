import 'package:flutter/material.dart';

class VagNonVagDesign extends StatelessWidget {
  final bool isVegetarian;
  const VagNonVagDesign({super.key,required this.isVegetarian});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 16,
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(border: Border.all(color:isVegetarian?Colors.green:Colors.red),borderRadius: BorderRadius.circular(2)),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isVegetarian?Colors.green:Colors.red
        ),),
    );
  }
}
