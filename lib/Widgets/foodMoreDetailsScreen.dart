import 'package:flutter/material.dart';
import 'package:food_app/Controllers/FoodProvider.dart';
import 'package:food_app/Controllers/OrderDataProvider.dart';
import 'package:food_app/Modals/FoodModal.dart';
import 'package:food_app/Modals/OrderDataModal.dart';
import 'package:food_app/Widgets/RadioTile.dart';
import 'package:food_app/Widgets/VagNonVagDesign.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class FoodMoreDetailsScreen extends StatefulWidget {
  final FoodModal foodModal;
  final int mainIndex;

  const FoodMoreDetailsScreen(
      {super.key, required this.foodModal, required this.mainIndex});

  @override
  State<FoodMoreDetailsScreen> createState() => _FoodMoreDetailsScreenState();
}

class _FoodMoreDetailsScreenState extends State<FoodMoreDetailsScreen> {

  @override
  void didChangeDependencies() {
    Provider
        .of<FoodProvider>(context, listen: false)
        .Options =
        widget.foodModal.foods?[widget.mainIndex].options?[0].name ?? '';
    Provider
        .of<FoodProvider>(context, listen: false)
        .size =
        widget.foodModal.foods?[widget.mainIndex].sizes?[0].name ?? '';
    List.generate(
        widget.foodModal.foods?[widget.mainIndex].toppings?.length ?? 0, (
        index) {
      Provider
          .of<FoodProvider>(context, listen: false)
          .toppings[index] = false;
      return;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      Provider.of<FoodProvider>(context, listen: false).addAmount(
          mainIndex: widget.mainIndex,
          foodModal: widget.foodModal,
          optionIndex: 0,
          sizeIndex: 0);
    },);
    Provider
        .of<FoodProvider>(context, listen: false)
        .itemCount = 1;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int tempIndex = 1;
    int tempSizeIndex = 0;
    int tempOptionIndex = 0;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(top: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                width: 78,
                height: 78,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        widget.foodModal.foods?[widget.mainIndex].img ?? ''),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                alignment: Alignment.topLeft,
                height: 78,
                width: 237,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        VagNonVagDesign(
                            isVegetarian: widget.foodModal
                                .foods?[widget.mainIndex].isVegetarian ??
                                false),
                        const SizedBox(
                          width: 16,
                        ),
                        const Text('Bestseller')
                      ],
                    ),
                    Text(
                      widget.foodModal.foods?[widget.mainIndex].name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                    ),
                    SizedBox(
                      height: 41,
                      // width: 200,
                      child: ReadMoreText(
                        widget.foodModal.foods?[widget.mainIndex].description ??
                            '',
                        trimLines: 2,
                        trimLength: 2,
                        colorClickableText: const Color(0xFF00A949),
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: const TextStyle(
                            color: Color(0xFF00A949),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Size',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: 95,
            constraints: const BoxConstraints(maxHeight: 95, minHeight: 50),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
              widget.foodModal.foods?[widget.mainIndex].sizes?.length ?? 0,
              itemBuilder: (context, index) {
                String sizeName = widget
                    .foodModal.foods?[widget.mainIndex].sizes?[index].name ??
                    '';
                String sizeOrgPrize = widget.foodModal.foods?[widget.mainIndex]
                    .sizes?[index].originalPrice
                    .toString() ??
                    '';
                String sizeDisPrize = widget.foodModal.foods?[widget.mainIndex]
                    .sizes?[index].discountedPrice
                    .toString() ??
                    '';
                return Consumer<FoodProvider>(
                  builder: (context, value, child) {
                    return RadioTile(
                      CheckboxValue: false,
                      isRadio: true,
                      sizeName: sizeName,
                      depPrize: sizeOrgPrize,
                      Prize: sizeDisPrize,
                      radioValue: sizeName,
                      radioGValue: value.size,
                      onchange: (val) {
                        value.sizeChange(val);
                        tempSizeIndex = index;
                        value.addAmount(mainIndex: widget.mainIndex,
                            foodModal: widget.foodModal,
                            sizeIndex: index,
                            optionIndex: tempOptionIndex);
                      },
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Option',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: 95,
            constraints: const BoxConstraints(maxHeight: 95, minHeight: 50),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
              widget.foodModal.foods?[widget.mainIndex].options?.length ?? 0,
              itemBuilder: (context, index) {
                String optionsName = widget.foodModal.foods?[widget.mainIndex]
                    .options?[index].name ??
                    '';
                String optionsOrgPrize = widget
                    .foodModal.foods?[widget.mainIndex].options?[index].price
                    .toString() ??
                    '';
                String optionsDisPrize = widget.foodModal.foods?[widget.mainIndex]
                    .options?[index].discountedPrice
                    .toString() ??
                    '';
                return Consumer<FoodProvider>(
                  builder: (context, value, child) {
                    return RadioTile(
                      CheckboxValue: false,
                      isRadio: true,
                      sizeName: optionsName,
                      depPrize: optionsOrgPrize,
                      Prize: optionsDisPrize,
                      radioValue: optionsName,
                      radioGValue: value.Options,
                      onchange: (val) {
                        value.optionsChange(val);
                        tempOptionIndex = index;
                        value.addAmount(mainIndex: widget.mainIndex,
                            foodModal: widget.foodModal,
                            sizeIndex: tempSizeIndex,
                            optionIndex: index);
                      },
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Topping',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: 95,
            constraints: const BoxConstraints(maxHeight: 95, minHeight: 50),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
              widget.foodModal.foods?[widget.mainIndex].toppings?.length ?? 0,
              itemBuilder: (context, index) {
                String toppingsName = widget.foodModal.foods?[widget.mainIndex]
                    .toppings?[index].name ??
                    '';
                String toppingsOrgPrize = widget
                    .foodModal.foods?[widget.mainIndex].toppings?[index].price
                    .toString() ??
                    '';
                String toppingsDisPrize = widget.foodModal
                    .foods?[widget.mainIndex].toppings?[index].discountedPrice
                    .toString() ??
                    '';
                return Consumer<FoodProvider>(
                  builder: (context, value, child) {
                    return RadioTile(
                      CheckboxValue: value.toppings[index],
                      isRadio: false,
                      sizeName: toppingsName,
                      depPrize: toppingsOrgPrize,
                      Prize: toppingsDisPrize,
                      radioValue: toppingsName,
                      radioGValue: '4',
                      onchange: (val) {
                        value.changecheck(index);
                        value.addAmount(mainIndex: widget.mainIndex,
                            foodModal: widget.foodModal,
                            sizeIndex: tempSizeIndex,
                            optionIndex: tempOptionIndex);
                      },
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: 145,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border:
                      Border.all(color: const Color(0xffFF00A949), width: 1)),
                  child: Consumer<FoodProvider>(
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (tempIndex > 1) {
                                value.decrement(--tempIndex);
                              }
                            },
                            child: const Icon(
                              Icons.remove,
                              size: 24,
                              color: Color(0xff626262),
                            ),
                          ),
                          Text(
                            value.itemCount.toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF00A949)),
                          ),
                          GestureDetector(
                            onTap: () {
                              value.increment(++tempIndex);
                            },
                            child: const Icon(
                              Icons.add,
                              size: 24,
                              color: Color(0xff00A949),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 13,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    var provider = Provider.of<FoodProvider>(
                        context, listen: false);
                    List<Options> toppingList = [];
                    for (int i = 0; i < provider.toppings.length; i++) {
                      if (provider.toppings[i] == true) {
                        toppingList.add(Options(
                            name: widget.foodModal.foods?[widget.mainIndex]
                                .toppings?[i].name ?? '',
                            price: widget.foodModal.foods?[widget.mainIndex]
                                .toppings?[i].price ?? 0.0,
                            discountedPrice: widget.foodModal.foods?[widget
                                .mainIndex].toppings?[i].discountedPrice ?? 0.0));
                      }
                    }
                    Provider.of<OrderDataProvider>(context,listen: false).addOrderData(
                      id: widget.foodModal.foods?[widget.mainIndex].id??0,
                        name: widget.foodModal.foods?[widget.mainIndex].name ??
                            '',
                        toppings:toppingList,
                        options: Options(name: widget.foodModal.foods?[widget.mainIndex].options?[tempOptionIndex].name??'', price: widget.foodModal.foods?[widget.mainIndex].options?[tempOptionIndex].price??0.0, discountedPrice: widget.foodModal.foods?[widget.mainIndex].options?[tempOptionIndex].discountedPrice??0.0),
                        sizes: Sizes(name: widget.foodModal.foods?[widget.mainIndex].sizes?[tempSizeIndex].name??'', originalPrice: widget.foodModal.foods?[widget.mainIndex].sizes?[tempSizeIndex].originalPrice??0.0, discountedPrice: widget.foodModal.foods?[widget.mainIndex].sizes?[tempSizeIndex].discountedPrice??0.0),
                        inStock: widget.foodModal.foods?[widget.mainIndex].inStock??false,
                        isVegetarian: widget.foodModal.foods?[widget.mainIndex].isVegetarian??false,
                        img: widget.foodModal.foods?[widget.mainIndex].img??'',
                        totalQuantity: tempIndex);

                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 145,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: const Color(0xffFF00A949), width: 1)),
                      child: Consumer<FoodProvider>(
                        builder: (context, value, child) {
                          return Text(
                            'Add item | \$${(value.total * value.itemCount)
                                .toStringAsFixed(1)}',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      )),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

void bottomSheet({required BuildContext context,
  required FoodModal foodModal,
  required int mainIndex}) {
  showModalBottomSheet(
    constraints:
    BoxConstraints(maxHeight: MediaQuery
        .of(context)
        .size
        .height * .85),
    useSafeArea: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    clipBehavior: Clip.antiAlias,
    isDismissible: true,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return FoodMoreDetailsScreen(foodModal: foodModal, mainIndex: mainIndex);
    },
  );
}
