import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Controllers/OrderDataProvider.dart';
import 'package:food_app/Widgets/OrderScreenItems.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController tipsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MacDonald'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 16, bottom: 8, left: 16),
              child: const Row(
                children: [
                  Icon(Icons.access_time_outlined),
                  Text(
                    ' Deliver in 20 Mins',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            Consumer<OrderDataProvider>(
              builder: (context, value, child) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.orderDataList.length,
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(),
                    );
                  },
                  itemBuilder: (context, index) {
                    return OrderScreenItem(
                      itemName: value.orderDataList[index].food.name,
                      itemPrize: value
                          .totalPrizeWithIngredient(
                              value.orderDataList[index].id)
                          .toStringAsFixed(2),
                      itemType: value.orderDataList[index].food.sizes.name,
                      isVag: value.orderDataList[index].food.isVegetarian,
                      itemsCount: value
                          .getItemCount(value.orderDataList[index].id)
                          .toString(),
                      id: value.orderDataList[index].id,
                    );
                  },
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add more items',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Icon(
                      Icons.cancel_outlined,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Instruction',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Icon(
                    Icons.edit,
                    size: 18,
                  )
                ],
              ),
            ),
            const Divider(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Apply Promocode',
                      style: TextStyle(fontSize: 14),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    )
                  ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: ShapeDecoration(
                color: const Color(0xFFE6F7ED),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.qrcode),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'HUNGRY50',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.cancel_outlined,
                      size: 16,
                    )
                  ]),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0)
                  .copyWith(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tip Your Provider',
                    style: TextStyle(fontSize: 14),
                  ),
                  Consumer<OrderDataProvider>(
                    builder: (context, value, child) {
                      return Text(
                        '\$${value.tips}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Consumer<OrderDataProvider>(
                builder: (context, value, child) {
                  return Row(
                      children: List.generate(4, (index) {
                    return InkWell(
                      onTap: () {
                        value.selectTipsType(index);
                        if (index != 3) {
                          value.tips = (index + 1) * 10;
                        } else {
                          value.tips = 0;
                        }
                      },
                      child: Container(
                        width: 78,
                        height: 30,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                            color: value.tipsType == index
                                ? const Color(0xFF00A949)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Color(0xFFE8E8E8),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            )),
                        child: index != 3
                            ? Row(mainAxisSize: MainAxisSize.min, children: [
                                Text(
                                  '\$${10 * (index + 1)}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: value.tipsType == index
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                SizedBox(
                                  width: value.tipsType == index ? 8 : 0,
                                ),
                                value.tipsType == index
                                    ? const Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : const SizedBox()
                              ])
                            : Text(
                                'Other',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: value.tipsType == index
                                        ? Colors.white
                                        : Colors.black),
                              ),
                      ),
                    );
                  }));
                },
              ),
            ),
            Consumer<OrderDataProvider>(
              builder: (context, value, child) {
                return Visibility(
                  visible: value.tipsType == 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0)
                        .copyWith(bottom: 4),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                                controller: tipsController,
                                keyboardType: TextInputType.number)),
                        Consumer<OrderDataProvider>(
                          builder: (context, value, child) => ElevatedButton(
                            onPressed: () {
                              value.addTips(double.parse(tipsController.text));
                            },
                            style: const ButtonStyle(
                                maximumSize:
                                    MaterialStatePropertyAll(Size(78, 30)),
                                minimumSize:
                                    MaterialStatePropertyAll(Size(78, 30)),
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0xFF00A949))),
                            child: const Text('APPLY'),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Item',
                        style: TextStyle(fontSize: 12),
                      ),
                      Consumer<OrderDataProvider>(
                        builder: (context, value, child) {
                          return Text(
                            value.total.toString(),
                            style: const TextStyle(fontSize: 14),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SubTotal',
                        style: TextStyle(fontSize: 12),
                      ),
                      Consumer<OrderDataProvider>(
                        builder: (context, value, child) {
                          return Text(
                            '\$ ${value.totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 14),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tip',
                        style: TextStyle(fontSize: 12),
                      ),
                      Consumer<OrderDataProvider>(
                        builder: (context, value, child) => Text(
                          '\$ ${value.tips.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Pay',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Consumer<OrderDataProvider>(
                          builder: (context, value, child) {
                        return Text(
                            '\$ ${(value.totalAmount + value.tips).toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold));
                      }),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 163.50,
                  height: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: ShapeDecoration(
                      color: const Color(0xFFE8E8E8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        size: 18,
                      ),
                      Text(
                        'Schedule Order',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 163.50,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                      color: const Color(0xFF00A949),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    'Order Now',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
