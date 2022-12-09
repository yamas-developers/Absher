import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../helpers/route_constants.dart';
import '../common_widgets/avatar.dart';
import '../common_widgets/build_slide_transition.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen>
    with TickerProviderStateMixin<RestaurantDetailScreen> {
  String selected = "Best Selling";
  List categories = ["Best Selling", "Sushi", "Salad", "Pasta", "Fish"];
  List<GlobalKey>? _keys;
  GlobalKey<State> myKey = GlobalKey();
  double top = 40;
  bool showOnTop = false;
  String storeType = "";

  AnimationController? _controller;
  RenderObject? _prevRenderObject;
  double _offsetToRevealBottom = double.infinity;
  double _offsetToRevealTop = double.negativeInfinity;

  setTop(val) {
    // if(val == top) return;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   setState(() {
    //     top = val;
    //   });
    // });
  }

  setShowOnTop(val) {
    // if(showOnTop == val) return;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   setState(() {
    //     showOnTop = val;
    //   });
    //
    // });
  }

  @override
  void initState() {
    _keys = List.generate(categories.length, (index) => GlobalKey());
    setState(() {});
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    _controller!.addStatusListener((val) {
      if (val == AnimationStatus.dismissed) {
        setState(() => showOnTop = true);
        print("showOnTop: ${showOnTop}");
      }
      print("value: ${val}");
      print("controller: ${_controller!.value}");
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) return;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      storeType = args["store_type"];

      print("arguments: ${storeType}");
    }
    if (storeType == "pharmacy") {
      setState(() {
        categories = ["All", "Men", "Women", "Kids", "Pain Killers"];
        selected = "All";
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: MySliverAppBar(
                      expandedHeight: 200,
                      setTop: setTop,
                      setShowOnTop: setShowOnTop),
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    SingleChildScrollView(
                      child: Column(
                        children: [
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
                                  Text('${storeType != "pharmacy" ? "Bakery - Coffee Shop" : "Pharmacy - Medicine Store"}',
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
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                                    color: mainColor,
                                                    width: 1.5),
                                                right: BorderSide(
                                                    color: mainColor,
                                                    width: 1.5),
                                              )),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                                FontWeight
                                                                    .w500),
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
                                                    Navigator.pushNamed(context, vendor_info_screen);
                                                    // if (myKey.currentContext !=
                                                    //     null) {
                                                    //   Scrollable.ensureVisible(
                                                    //       myKey
                                                    //           .currentContext!);
                                                    // }
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
                          // if(!showOnTop)
                          Container(
                            key: myKey,
                            // color: mainColorLight.withOpacity(0.25),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            child: Visibility(
                              visible: !showOnTop,
                              child: ListView(
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
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.ease,
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
                                                  : mainColorLight
                                                      .withOpacity(0.25),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Center(
                                                child: Text(
                                              "${categories[i]}",
                                              style: TextStyle(
                                                  color:
                                                      categories[i] == selected
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
                          ),
                          // SizedBox(height: 20),
                          Padding(
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
                                              height: 30,
                                              key: _keys != null
                                                  ? _keys![index]
                                                  : null,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 18.0),
                                              child: Text(
                                                "${categories[index]}",
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
                                                (index) {
                                                  int i = index < 11 ? index + 1 : Random().nextInt(11) + 1;
                                                  return BuildSlideTransition(child: RestaurantFoodItem(
                                                  index: storeType != "pharmacy" ? i: i + 11,
                                                    type: storeType,
                                                ),animationDuration: (index+1) * 500, curve: Curves.elasticInOut, startPos:2.0);
                                                }).toList()
                                          ],
                                        )).toList(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                )
              ],
            ),
            onNotification: (ScrollNotification scroll) {
              var currentContext = myKey.currentContext;
              if (currentContext == null) return false;

              var renderObject = currentContext.findRenderObject();
              print(
                  "in onNotification: ${RenderAbstractViewport.of(renderObject)}");

              if (renderObject != null) {
                final double yPosition = (renderObject as RenderBox)
                    .localToGlobal(Offset.zero)
                    .dy; // !
                print(
                    'Widget is visible in the viewport at position: $yPosition');
                if (yPosition <= 85) {
                  if (!showOnTop) {
                    setState(() {
                      showOnTop = true;
                      top = 55;
                    });
                    if (_controller!.status != AnimationStatus.forward) {
                      _controller!.forward();
                      print('forward animation');
                    } else {
                      _controller!.reverse();
                      print('reverse animation');
                    }
                  }
                } else {
                  if (showOnTop)
                    setState(() {
                      showOnTop = false;
                      top = 40;
                    });
                }
                // do stuff...
              } else {
                print('Widget is not visible.');
                // do stuff...
              }

              return false;

              if (renderObject != _prevRenderObject) {
                RenderAbstractViewport? viewport =
                    RenderAbstractViewport.of(renderObject);
                if (viewport != null) {
                  _offsetToRevealBottom =
                      viewport.getOffsetToReveal(renderObject!, 1.0).offset;
                  _offsetToRevealTop =
                      viewport.getOffsetToReveal(renderObject, 0.0).offset;
                }
              }
              print("offsets: $_offsetToRevealBottom and $_offsetToRevealTop");

              final offset = scroll.metrics.pixels;

              if (_offsetToRevealBottom < offset &&
                  offset < _offsetToRevealTop) {
                if (!showOnTop) setState(() => showOnTop = true);

                if (_controller!.status != AnimationStatus.forward) {
                  _controller!.forward();
                }
              } else {
                if (_controller!.status != AnimationStatus.reverse) {
                  _controller!.reverse();
                }
              }
              return false;
            },
          ),
          // if (showOnTop)
            AnimatedPositioned(
              // key: myKey,
              duration: Duration(milliseconds: 600),
              top: top,
              child: Visibility(
                visible: showOnTop,
                child: AnimatedBuilder(
                  builder: (BuildContext context, Widget? child) =>
                      Opacity(opacity: _controller!.value, child: child),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: getWidth(context),
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...List.generate(
                          categories.length,
                          (i) => GestureDetector(
                            onTap: () {
                              if (_keys != null) if (_keys![i].currentContext !=
                                  null) {
                                Scrollable.ensureVisible(
                                  _keys![i].currentContext!,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.ease,
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
                  animation: this._controller!,
                ),
              ),
            )
        ],
      ),
    );
  }
}

class RestaurantFoodItem extends StatelessWidget {
  RestaurantFoodItem({
    Key? key,
    required this.index,
    required this.type,

  }) : super(key: key);

  final int index;
  final String type;

  @override
  Widget build(BuildContext context) {
    String image = "assets/images/temp/temp${index}.jpg";
    String title = "Duis Aute";
    String id = "${Random().nextInt(1000) + (index * pi)}";
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, food_detail_screen, arguments: {"image": image, "title": title, "id": id, "type": type});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Hero(
                  tag: ValueKey("${id}"),
                  child: Image.asset(
                    image,
                    // "assets/images/temp/temp${index < 11 ? index + 1 : 1}.jpg",
                  ),
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
                      title,
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
                          color: labelGreenColor),
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
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String text;
  final setTop;
  final setShowOnTop;

  MySliverAppBar(
      {required this.expandedHeight,
      required this.setTop,
        this.text = '',
        required this.setShowOnTop
      });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double top = 0;
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Image.asset("assets/images/restaurant_bg.jpg", fit: BoxFit.cover),
        if (shrinkOffset / expandedHeight > 0.5)
          Builder(builder: (context) {
            print("in builder");
            double t = expandedHeight / 2 - shrinkOffset + 40;
            setTop(t);
            setShowOnTop(shrinkOffset / expandedHeight == 1);

            return AnimatedOpacity(
              duration: Duration(milliseconds: 150),
              opacity: shrinkOffset / expandedHeight,
              child: Container(
                // duration: Duration(seconds: 1),
                color:
                    mainColor.withOpacity(shrinkOffset / expandedHeight - 0.1),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    RoundedAvatar(assetPath: "assets/images/mac_logo.jpg"),
                    // Text("${shrinkOffset / expandedHeight}")
                  ],
                ),
              ),
            );
          }),
        AnimatedPositioned(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeIn,
          top: expandedHeight / 2 - shrinkOffset + 40,
          left: MediaQuery.of(context).size.width / 4 - 75,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: RoundedAvatar(
                assetPath: "assets/images/mac_logo.jpg",
                height: 70.0,
                width: 70.0),
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
                  Row(
                    children: [
                      Text("${text}"),
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

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
