import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Controllers/OrderDataProvider.dart';
import 'package:food_app/Modals/FoodModal.dart';
import 'package:food_app/Widgets/VagNonVagDesign.dart';
import 'package:food_app/Widgets/foodMoreDetailsScreen.dart';
import 'package:provider/provider.dart';

class FoodDesign extends StatefulWidget {
  final int index;
  final FoodModal foodModal;

  const FoodDesign({super.key, required this.foodModal, required this.index});

  @override
  State<FoodDesign> createState() => _FoodDesignState();
}

class _FoodDesignState extends State<FoodDesign> {
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    String img = widget.foodModal.foods?[index].img ?? '';
    String name = widget.foodModal.foods?[index].name ?? '';
    String disPrize =
        widget.foodModal.foods?[index].sizes?[0].discountedPrice.toString() ??
            '';
    String orgPrize =
        widget.foodModal.foods?[index].sizes?[0].originalPrice.toString() ?? '';
    bool inStack = widget.foodModal.foods?[index].inStock ?? false;
    bool isVegetarian = widget.foodModal.foods?[index].isVegetarian ?? false;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    inStack ? Colors.transparent : CupertinoColors.inactiveGray,
                    BlendMode.srcATop),
                child: SizedBox(
                  width: 215,
                  height: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          VagNonVagDesign(isVegetarian: isVegetarian),
                          const SizedBox(height: 8, child: VerticalDivider()),
                          const Text('Bestseller')
                        ],
                      ),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      SizedBox(
                        // width: 55,
                        height: 19,
                        child: Row(children: [
                          Text(
                            disPrize,
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xFF00A949)),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            orgPrize,
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                              color: Color(0xFF616161),
                            ),
                          )
                        ]),
                      ),
                      const SizedBox(height: 9),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'More Details',
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            CupertinoIcons.chevron_down,
                            size: 16,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 130,
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  inStack
                                      ? Colors.transparent
                                      : CupertinoColors.inactiveGray,
                                  BlendMode.saturation),
                              image: AssetImage(img),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Consumer<OrderDataProvider>(
                            builder: (context, value, child) => Column(
                              children: [
                                inStack
                                    ? value.getItemCount(widget.foodModal
                                                    .foods?[index].id ??
                                                0) ==
                                            0
                                        ? InkWell(
                                            onTap: () {
                                              inStack
                                                  ? bottomSheet(
                                                      context: context,
                                                      mainIndex: widget.index,
                                                      foodModal:
                                                          widget.foodModal)
                                                  : null;
                                            },
                                            child: Container(
                                              width: 82,
                                              height: 23,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 2),
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFF00A949),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: const Text(
                                                'Add+',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    height: 1.4),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: 82,
                                            height: 23,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xFF00A949)),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Provider.of<OrderDataProvider>(
                                                            context,
                                                            listen: false)
                                                        .decrement(widget
                                                                .foodModal
                                                                .foods?[index]
                                                                .id ??
                                                            0);
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    size: 15,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Consumer<OrderDataProvider>(
                                                  builder:
                                                      (context, value, child) =>
                                                          Text(
                                                    value
                                                        .getItemCount(widget
                                                                .foodModal
                                                                .foods?[index]
                                                                .id ??
                                                            0)
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF00A949),
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                    onTap: () {
                                                      Provider.of<OrderDataProvider>(
                                                              context,
                                                              listen: false)
                                                          .increment(widget
                                                                  .foodModal
                                                                  .foods?[index]
                                                                  .id ??
                                                              0);
                                                    },
                                                    child: const Icon(Icons.add,
                                                        size: 15)),
                                              ],
                                            ),
                                          )
                                    : Container(
                                        width: 82,
                                        height: 23,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 2),
                                        decoration: ShapeDecoration(
                                          color: CupertinoColors.inactiveGray,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                        child: const Text(
                                          'Add+',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              height: 1.4),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Customizable',
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: inStack
                                          ? Colors.black
                                          : CupertinoColors.inactiveGray),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          inStack
              ? const SizedBox()
              : Positioned(
                  right: 90,
                  top: 50,
                  child: Container(
                    width: 164,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                        color: CupertinoColors.inactiveGray,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Out of stock',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
