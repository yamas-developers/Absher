import 'dart:developer';

import 'package:absher/api/mj_apis.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../helpers/route_constants.dart';
import '../../models/category.dart';
import '../../models/restaurant.dart';
import '../../providers/business/store_detail_provider.dart';
import '../common_widgets/misc_widgets.dart';

class GroceryStoreScreen extends StatefulWidget {
  const GroceryStoreScreen({Key? key}) : super(key: key);

  @override
  State<GroceryStoreScreen> createState() => _GroceryStoreScreenState();
}

class _GroceryStoreScreenState extends State<GroceryStoreScreen> {
  int _current = 0;
  List<String> categories = [
    "Deals",
    "Egg, Meat & Fish",
    "Snacks",
    "Brightfields",
    "Frozen Snacks",
    "Dairy",
    "Fruits & Vegetables",
    "Ice Cream",
    "Hygiene Essentials",
    "Daily Cooking",
    "Toys",
    "Edibile Oil",
    "Breakfast",
    "Chocolate",
    "Cleaning Needs",
    "Bevereges"
  ];
  Business? businessItem;

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) return;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      setState(() {
        businessItem = args["store"];
      });
      log("arguments: ${businessItem?.toJson()}");
      if (businessItem is Business) {
        StoreDetailProvider provider = context.read<StoreDetailProvider>();
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          provider.business = businessItem;
          await provider.getData();
        });
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("heightt: ${getLargestSide(context)}");
    print("widthh: ${getWidth(context)}");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Consumer<StoreDetailProvider>(builder: (context, provider, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: mainColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 18, 0),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    "assets/icons/back_arrow_icon.png",
                                    width: 24,
                                    height: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              // height: 39,
                              padding: EdgeInsets.fromLTRB(4, 9, 4, 9),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.15),
                                      blurRadius: 6,
                                      spreadRadius: .1,
                                    ),
                                  ]),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Image.asset(
                                    "assets/icons/search_icon.png",
                                    color: mainColor,
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Flexible(
                                      child: Text(
                                    "Search for category",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: mainColor,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, cart_screen);
                                  },
                                  child: Image.asset(
                                    "assets/icons/cart.png",
                                    width: 24,
                                    color: Colors.white,
                                    height: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Get Your Grocery",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                // padding: EdgeInsets.symmetric(vertical: 10),

                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/star.png",
                                  width: 16,
                                  color: mainColor,
                                  height: 16,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "3.66",
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Text(
                              "Rating",
                              style: TextStyle(
                                  color: darkGreyColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          // width: getWidth(context) * .3,
                          decoration: BoxDecoration(
                              border: Border(
                            left: BorderSide(color: mainColor, width: 1.5),
                            right: BorderSide(color: mainColor, width: 1.5),
                          )),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/time.png",
                                    width: 16,
                                    color: mainColor,
                                    height: 16,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "30 - 40 mins",
                                    style: TextStyle(
                                        color: mainColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Text(
                                "Time",
                                style: TextStyle(
                                    color: darkGreyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                "assets/icons/info_icon.png",
                                width: 24,
                                color: mainColor,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: getSize(
                            context, 0.30, getWidth(context) * .40, 120),
                        // aspectRatio: 16/9,
                        viewportFraction: .8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (int i, a) {
                          _current = i;
                          setState(() {});
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                      items: [
                        Container(
                          width: getWidth(context),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Image.asset(
                                    'assets/images/banner_grocery.jpg',
                                    width: getWidth(context),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            end: Alignment.bottomCenter,
                                            begin: Alignment.topCenter,
                                            colors: [
                                          Color.fromRGBO(188, 55, 222, 0),
                                          Color.fromRGBO(188, 55, 222, 0),
                                          Color.fromRGBO(120, 22, 145, 0.82),
                                        ])),
                                  )
                                ],
                              )),
                        ),
                        Container(
                          width: getWidth(context),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Image.asset(
                                    'assets/images/banner1.jpeg',
                                    width: getWidth(context),
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            end: Alignment.bottomCenter,
                                            begin: Alignment.topCenter,
                                            colors: [
                                          Color.fromRGBO(188, 55, 222, 0),
                                          Color.fromRGBO(188, 55, 222, 0),
                                          Color.fromRGBO(120, 22, 145, 0.82),
                                        ])),
                                  )
                                ],
                              )),
                        ),
                        Container(
                          width: getWidth(context),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Image.asset(
                                    'assets/images/banner2.jpeg',
                                    width: getWidth(context),
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            end: Alignment.bottomCenter,
                                            begin: Alignment.topCenter,
                                            colors: [
                                          Color.fromRGBO(188, 55, 222, 0),
                                          Color.fromRGBO(188, 55, 222, 0),
                                          Color.fromRGBO(120, 22, 145, 0.82),
                                        ])),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [0, 1, 2].map(
                        (index) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color.fromRGBO(239, 0, 255, 1.0)
                                    : Color.fromRGBO(252, 227, 255, 1.0)),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                child: SizedBox(
                  height: getLargestSide(context) - 300,
                  child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isPortrait(context) ? 4 : 6,
                        childAspectRatio: 0.7),
                    // itemCount: 16,
                    // itemBuilder: (context, i) => ),
                    children: [
                      ...List.generate(
                          provider.storeCategories.length,
                          (i) => StoreCategoryItem(
                              item: provider.storeCategories[i])).toList()
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class StoreCategoryItem extends StatelessWidget {
  const StoreCategoryItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Category item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.read<StoreDetailProvider>().selectedRestaurantCat = item;
          StoreDetailProvider provider = context.read<StoreDetailProvider>();
          provider.getSubCatData(item);
        Navigator.pushNamed(context, category_detail_screen);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: mainColor)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: ImageWithPlaceholder(
                prefix: MJ_Apis.categoryImgPath,
                image: '${item.image}',
                width: 84,
                // color: Colors.white,
                height: 84,
              ),
            ),
          ),
          Text(
            "${item.name}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: darkGreyColor,
            ),
          )
        ],
      ),
    );
  }
}
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Image.asset(
//       "assets/icons/expand_down_double.png",
//       width: 24,
//       color: mainColor,
//       height: 24,
//     ),
//     Text(
//       "View All",
//       style: TextStyle(
//         color: mainColor,
//         fontWeight: FontWeight.w500,
//         fontSize: 16,
//       ),
//     )
//   ],
// )
