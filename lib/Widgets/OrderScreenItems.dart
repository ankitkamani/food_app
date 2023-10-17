import 'package:flutter/material.dart';
import 'package:food_app/Controllers/OrderDataProvider.dart';
import 'package:food_app/Widgets/VagNonVagDesign.dart';
import 'package:provider/provider.dart';

import 'CustomeText.dart';

class OrderScreenItem extends StatefulWidget {
  final String itemName;
  final String itemType;
  final String itemPrize;
  final bool isVag;
  final String itemsCount;
  final int id;

  const OrderScreenItem(
      {super.key,
      required this.itemPrize,
      required this.itemName,
      required this.itemType,
      required this.isVag,
      required this.itemsCount,
      required this.id});

  @override
  State<OrderScreenItem> createState() => _OrderScreenItemState();
}

class _OrderScreenItemState extends State<OrderScreenItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      VagNonVagDesign(isVegetarian: widget.isVag),
                      const SizedBox(
                        width: 6,
                      ),
                      CoustomTextBold(
                        name: widget.itemName,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.itemType,
                    style: const TextStyle(fontSize: 14),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CoustomTextBold(
                    name: '\$${widget.itemPrize}',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 70,
                    height: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: const Color(0xffFF00A949), width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Provider.of<OrderDataProvider>(context,listen: false).decrement(widget.id);
                          },
                          child: Icon(
                            Icons.remove,
                            size: 16,
                            color: Color(0xff626262),
                          ),
                        ),
                        Text(
                          widget.itemsCount,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF00A949)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<OrderDataProvider>(context,listen: false).increment(widget.id);
                          },
                          child: Icon(
                            Icons.add,
                            size: 16,
                            color: Color(0xff00A949),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
