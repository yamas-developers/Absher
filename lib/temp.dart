import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  String selected = "Best Selling";
  List categories = ["Best Selling", "Sushi", "Salad", "Pasta", "Fish"];
  List<GlobalKey>? _keys;
  GlobalKey myKey = GlobalKey();

  @override
  void initState() {
    _keys = List.generate(categories.length, (index) => GlobalKey());
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("myKey: ${myKey.currentContext}");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body:
      // CustomScrollView(
      //   slivers: [
      // SliverPersistentHeader(
      //   delegate: MySliverAppBar(expandedHeight: 200, data: myKey),
      //
      //   pinned: true,
      // ),
      // SliverList(
      //   delegate: SliverChildListDelegate([
      NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                delegate: MySliverAppBar(expandedHeight: 200, data: myKey),

                pinned: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 14.0, top: 18, right: 18),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Lorem ipsum dolor smit",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              Text("Bakery - Coffee Shop",
                                  style: TextStyle(
                                      fontSize: 14, color: darkGreyColor)),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 40,
                                // padding: EdgeInsets.symmetric(vertical: 10),

                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                      fontWeight:
                                                      FontWeight.w500),
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
                                                left: BorderSide(
                                                    color: mainColor, width: 1.5),
                                                right: BorderSide(
                                                    color: mainColor, width: 1.5),
                                              )),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                "Time",
                                                style: TextStyle(
                                                    color: darkGreyColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (myKey.currentContext !=
                                                    null) {
                                                  Scrollable.ensureVisible(
                                                      myKey.currentContext!);
                                                }
                                              },
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
                              SizedBox(height: 10),
                            ]),
                      ),
                      Container(
                        // color: mainColorLight.withOpacity(0.25),
                        padding: EdgeInsets.symmetric(horizontal: 10),

                        height: 50,
                        child: ListView(
                          key: myKey,
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...List.generate(
                              categories.length,
                                  (i) => GestureDetector(
                                onTap: () {
                                  if (_keys != null) if (_keys![i]
                                      .currentContext !=
                                      null) {
                                    Scrollable.ensureVisible(
                                      _keys![i].currentContext!,
                                      // duration: Duration(milliseconds: 200),
                                      // curve: Curves.ease,
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: categories[i] == selected
                                            ? mainColor
                                            : mainColorLight.withOpacity(0.25),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                            "${categories[i]}",
                                            style: TextStyle(
                                                color: categories[i] == selected
                                                    ? Colors.white
                                                    : Colors.black54),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ).toList(),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ]
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: 12),
              child: Column(
                children: [
                  ...List.generate(
                      categories.length,
                          (index) => Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text(
                              "${categories[index]}",
                              key: _keys != null
                                  ? _keys![index]
                                  : null,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: mainColor),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ...List.generate(
                              7,
                                  (index) => RestaurantFoodItem(
                                index: index,
                              )).toList()
                        ],
                      )).toList(),
                ],
              ),
            ),
          )
      ),
      // ]),
      // )
      // ],
      // ),
    );
  }
}

class RestaurantFoodItem extends StatelessWidget {
  const RestaurantFoodItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Image.asset(
                "assets/images/temp/temp${index < 11 ? index + 1 : 1}.jpg",
              )),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 12,),
                  Text(
                    "Duis Aute",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black54),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  // SizedBox(height: 12,),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "QAR 23",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: darkGreyColor),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: mainColor),
                        child: Text(
                          "+Add",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final data;

  MySliverAppBar({required this.expandedHeight, this.data});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Image.asset("assets/images/restaurant_bg.jpg", fit: BoxFit.cover),
        if (shrinkOffset / expandedHeight > 0.8)
          AnimatedOpacity(
            duration: Duration(milliseconds: 150),
            opacity: shrinkOffset / expandedHeight,
            child: Container(
              color: mainColor.withOpacity(0.9),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  restaurantLogo(),
                  // Text("${shrinkOffset / expandedHeight}")
                ],
              ),
            ),
          ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeIn,
          top: expandedHeight / 2 - shrinkOffset + 40,
          left: MediaQuery.of(context).size.width / 4 - 30,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: restaurantLogo(height: 70.0, width: 70.0),
          ),
        ),
        Positioned.fill(
            top: 12,
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Image.asset(
                        "assets/icons/back_arrow_icon.png",
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "${data}",
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Image.asset(
                            "assets/icons/favorite.png",
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Image.asset(
                            "assets/icons/exit_icon.png",
                            width: 24,
                            height: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),

      ],
    );
  }

  Widget restaurantLogo({height = 50.0, width = 50.0}) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: BorderRadius.circular(40)),
        // radius: 25,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/images/mac_logo.jpg",
              fit: BoxFit.cover,
              width: width,
              height: height,
            ),
          ),
        ));
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
