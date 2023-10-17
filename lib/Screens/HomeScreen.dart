import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Controllers/ApiHelper.dart';
import 'package:food_app/Controllers/OrderDataProvider.dart';
import 'package:food_app/Utils/Routes.dart';
import 'package:food_app/Widgets/foodDesign.dart';
import 'package:provider/provider.dart';

import '../Widgets/Cdivider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MacDonald'),
        actions: const [
          Icon(
            CupertinoIcons.search,
            size: 24,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.favorite_border_rounded,
              size: 24,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.info_outline,
              size: 24,
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 16),
                      width: 263,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text('4.5(120 Rating)'),
                                ),
                                Icon(
                                  Icons.info_outline,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 263,
                            child: CustomDivider(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 15,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    'Kalavad Road, Rajkot - 360005',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 263, child: CustomDivider()),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.grid_view,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 232,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      'South Indian, Intalian, Chinese, Punjabi, Gujrati',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset('assets/image 30.png'),
                  ],
                ),
              ),
              const CustomDivider(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.arrow_swap),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Takeaway'),
                    Spacer(),
                    SizedBox(height: 15, child: VerticalDivider()),
                    Spacer(),
                    Icon(Icons.restore),
                    SizedBox(
                      width: 8,
                    ),
                    Text('10 min'),
                    Spacer(),
                    SizedBox(height: 15, child: VerticalDivider()),
                    Spacer(),
                    Icon(Icons.location_on_outlined),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '04 Km',
                    )
                  ],
                ),
              ),
              const CustomDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                            width: 300,
                            height: 58,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.04),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Minimum Order \$20',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const Text(
                                  'Minimum Order \$20',
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const CustomDivider(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Recommended',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 18,
                    )
                  ],
                ),
              ),
              FutureBuilder(
                future: ApiHelper.apiHelper.getData(),
                builder: (context, snapshot) {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        endIndent: 16,
                        indent: 16,
                      );
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data?.foods?.length ?? 0,
                    itemBuilder: (context, index) {
                      return FoodDesign(
                        foodModal: snapshot.data!,
                        index: index,
                      );
                    },
                  );
                },
              )
            ]),
          ),
          Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, orderScreen);
                },
                child: Consumer<OrderDataProvider>(
                  builder: (context, value, child) {
                    return Visibility(
                      visible: value.orderDataList.isEmpty?false:true,
                      child: Container(
                      width: 343,
                      height: 52,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF00A949),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                              '${value.total} Items | \$${value.totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                height: 0.7,
                              ),
                                ),
                              const Text(
                                'Extra Charge May Apply',
                                style: TextStyle(
                                  color: Colors.white,
                                  height: 0.09,
                                ),
                              )
                            ],
                          ),
                          const Text(
                            'Proceed',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                  ),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
