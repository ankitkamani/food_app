// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CheckBoxTIle extends StatefulWidget {
//   final String sizeName;
//   final String depPrize;
//   final String Prize;
//   final Function(String value) onchange;
//
//   const CheckBoxTIle(
//       {super.key,
//       required this.sizeName,
//       required this.depPrize,
//       required this.Prize,
//       required this.CheckboxValue,
//       required this.onchange});
//
//   @override
//   State<CheckBoxTIle> createState() => _RadioTileState();
// }
//
// class _RadioTileState extends State<CheckBoxTIle> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 24,
//       child: Row(
//         children: [
//           Text(
//             widget.sizeName,
//             style: const TextStyle(fontSize: 14),
//           ),
//           const Spacer(),
//           Text(
//             widget.depPrize,
//             style: const TextStyle(
//               decoration: TextDecoration.lineThrough,
//               fontSize: 12,
//               color: Color(0xFF2C3131),
//             ),
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           Text(
//             widget.Prize,
//             style: const TextStyle( fontSize: 14),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
