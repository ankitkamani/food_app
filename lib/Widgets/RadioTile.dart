import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioTile extends StatefulWidget {
  final bool isRadio;
  final String sizeName;
  final String depPrize;
  final String Prize;
  final String? radioValue;
  final bool CheckboxValue;
  final String? radioGValue;
  final Function(String value) onchange;

  const RadioTile({super.key,
    required this.isRadio,
    required this.sizeName,
    required this.depPrize,
    required this.Prize,
    this.radioValue,
    required this.CheckboxValue,
    this.radioGValue,
    required this.onchange});

  @override
  State<RadioTile> createState() => _RadioTileState();
}

class _RadioTileState extends State<RadioTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 24,
      // width: 343,
      child: Row(
        children: [
          Text(widget.sizeName, style: const TextStyle(fontSize: 14),),
          const Spacer(),
          Text(
            '\$${widget.depPrize}',
            style: const TextStyle(decoration: TextDecoration.lineThrough,
              fontSize: 12,
              color: Color(0xFF2C3131),),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            '\$${widget.Prize}',
            style: const TextStyle(fontSize: 14),
          ),
          widget.isRadio?Radio(
            value: widget.radioValue,
            focusColor: const Color(0xffA9A9A9),
            groupValue: widget.radioGValue,
            activeColor: Colors.green,
            onChanged: (value) {
              widget.onchange.call(value.toString());
            },
          ): Checkbox.adaptive(
            tristate: true,
            // side: const BorderSide(color: ,width: 2),
            focusColor: const Color(0xffA9A9A9),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3))),
            value: widget.CheckboxValue,
            activeColor: Colors.green,
            onChanged: (value) {
                widget.onchange.call(value.toString());
            },
          ),
        ],
      ),
    );
  }
}
