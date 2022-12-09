import 'dart:developer';

import 'package:absher/helpers/route_constants.dart';
import 'package:absher/ui/common_widgets/build_slide_transition.dart';
import 'package:absher/ui/common_widgets/comon.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';

// import 'package:absher/ui/vendor/restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../helpers/app_loader.dart';
import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../common_widgets/nearest_restaurant_item.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  bool isDelivery = true;
  bool isSearchExpanded = false;
  bool isRestaurantSearchExpanded = false;
  String storeType = "restaurant";
  String storeSubType = "";

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) return;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      storeType = args["screen_type"];
      if (args["screen_sub_type"] != null) {
        storeSubType = args["screen_sub_type"];
      }
      print("arguments: ${storeType} | ${storeSubType}");
    }
    if (storeType == "store")
      tabController = TabController(length: 1, vsync: this);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int animationDuration = 0;
    double width = getWidth(context) * (isSearchExpanded? 1.0 : 0.3) ;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
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
                        child: TouchableOpacity(
                          onTap: (){
                            modalBottomSheetLocation(context);
                          },
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
                                  "assets/icons/location_pin.png",
                                  width: 20,
                                  height: 20,
                                  color: mainColor,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Flexible(
                                    child: Text(
                                  "Location",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: mainColor,
                                      fontWeight: FontWeight.w500),
                                )),
                              ],
                            ),
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
                                color: mainColor,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Center(
                  child: Visibility(
                      visible: storeType == "store" || isRestaurantSearchExpanded,
                      child: BuildSlideTransition(
                        animationDuration: 300,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TouchableOpacity(
                              onTap: (){
                                if(isSearchExpanded) return;
                                setState(() {
                                  isSearchExpanded = true;
                                });
                              },
                              child: AnimatedContainer(

                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                                width: getWidth(context) * (isSearchExpanded? 0.81 : 0.4),
                                duration: Duration(milliseconds: 200),
                                child: Row(
                                  mainAxisAlignment: isSearchExpanded? MainAxisAlignment.start : MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/icons/search_icon.png",
                                      width: 24,
                                      color: darkGreyColor,
                                      height: 24,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Search",
                                      style: TextStyle(
                                          color: darkGreyColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    if(isSearchExpanded)Spacer(),
                                    if(isSearchExpanded)BuildSlideTransition(

                                        animationDuration: 600,
                                        child: Image.asset("assets/icons/cross_rounded_filled.png", height: 18,color: mainColor,))
                                  ],
                                ),
                              ).marginSymmetric(horizontal: 14),
                            ),
                            if(isSearchExpanded)TouchableOpacity(
                                onTap: (){

                                  setState(() {
                                    isSearchExpanded = false;
                                    isRestaurantSearchExpanded = false;
                                  });
                                },
                                child: BuildSlideTransition(
                                    animationDuration: 1000,
                                    curve: Curves.easeInOut,
                                    child: Image.asset("assets/icons/back_arrow_icon.png", height: 18,)))
                          ],

                  ),
                      )),
                ),
                Visibility(
                  visible: storeType != "store" && !isRestaurantSearchExpanded,
                  child: BuildSlideTransition(
                    animationDuration: 300,
                    child: Container(
                      height: 40,
                      // padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: darkGreyColor)),
                      child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, filter_screen);
                                },
                                child: Container(
                                  width: getWidth(context) * .3,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    // left: BorderSide(color: darkGreyColor, width: 1),
                                    right: BorderSide(
                                        color: darkGreyColor, width: 1),
                                  )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/icons/filter_icon.png",
                                        width: 24,
                                        color: darkGreyColor,
                                        height: 24,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Filter",
                                        style: TextStyle(
                                            color: darkGreyColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: getWidth(context) * .3,
                                decoration: BoxDecoration(
                                    border: Border(
                                  // left: BorderSide(color: darkGreyColor, width: 1),
                                  right: BorderSide(color: darkGreyColor, width: 1),
                                )),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text( "Cousines",
                                      // (storeType != "store")
                                      //     ? "Cousines"
                                      //     : (storeSubType == "pharmacy")
                                      //         ? "Pharmacies"
                                      //         : "Stores",
                                      style: TextStyle(
                                          color: darkGreyColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TouchableOpacity(
                                onTap: (){
                                  setState(() {
                                    isRestaurantSearchExpanded = true;
                                    isSearchExpanded = true;
                                  });
                                },
                                child: SizedBox(
                                  width: getWidth(context) * .3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/icons/search_icon.png",
                                        width: 24,
                                        color: darkGreyColor,
                                        height: 24,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Search",
                                        style: TextStyle(
                                            color: darkGreyColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: storeType != "store",
                  child: Container(
                    color: mainColorLight.withOpacity(0.25),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                              child: Text(
                            "Pizza",
                            style: TextStyle(color: mainColor),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                              child: Text(
                            "Shawarma",
                            style: TextStyle(color: mainColor),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                              child: Text(
                            "Biryani",
                            style: TextStyle(color: mainColor),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                              child: Text(
                            "Fast Food",
                            style: TextStyle(color: mainColor),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                              child: Text(
                            "Thai Food",
                            style: TextStyle(color: mainColor),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: storeType != "store",
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: darkGreyColor.withOpacity(.35),
                              offset: Offset(0, 1),
                              blurRadius: 8,
                            )
                          ]
                          // border: Border.all(
                          //   color:  Color.fromRGBO(27, 189, 198, 1),
                          // ),
                          ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: TabBar(
                          controller: tabController,
                          indicator: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                colors: [
                                  mainColor,
                                  mainColorLight.withOpacity(0.8)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: darkGreyColor,
                          tabs: [
                            Tab(
                              text: 'Delivery',
                            ),
                            Tab(
                              text: 'Takeaway',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Center(
                //   child: Container(
                //       height: 35,
                //       width: 250,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(30),
                //           color: Colors.white,
                //           boxShadow: [
                //             BoxShadow(
                //               color: Colors.grey.withOpacity(0.25),
                //               blurRadius: 8,
                //               offset: Offset(0, 8), // Shadow position
                //             ),
                //           ]),
                //       child: Row(
                //         children: [
                //           GestureDetector(
                //             onTap: () {
                //               setState(() {
                //                 isDelivery = true;
                //               });
                //             },
                //             child: Container(
                //               height: 35,
                //               width: 125,
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(30),
                //                 // color: isDelivery?mainColor: Colors.white,
                //                 gradient: isDelivery
                //                     ? LinearGradient(
                //                   begin: Alignment.bottomCenter,
                //                   end: Alignment.bottomCenter,
                //                   colors: <Color>[
                //                     mainColor.withOpacity(0.8),
                //                     mainColorLight.withOpacity(0.9),
                //
                //                     // Colors.blue
                //                   ],
                //                   stops: [0.6, 0.1],
                //                 )
                //                     : null,
                //               ),
                //               child: Center(
                //                 child: Text(
                //                   "Delivery",
                //                   style: TextStyle(
                //                       color: isDelivery
                //                           ? Colors.white
                //                           : darkGreyColor,
                //                       fontWeight: FontWeight.w500),
                //                 ),
                //               ),
                //             ),
                //           ),
                //           GestureDetector(
                //             onTap: () {
                //               setState(() {
                //                 isDelivery = false;
                //               });
                //             },
                //             child: Container(
                //               height: 35,
                //               width: 125,
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(30),
                //                 // color: isDelivery?Colors.white: mainColor,
                //                 gradient: !isDelivery
                //                     ? LinearGradient(
                //                   begin: Alignment.bottomCenter,
                //                   end: Alignment.bottomCenter,
                //                   colors: <Color>[
                //                     mainColor.withOpacity(0.8),
                //                     mainColorLight.withOpacity(0.9),
                //
                //                     // Colors.blue
                //                   ],
                //                   stops: [0.6, 0.1],
                //                 )
                //                     : null,
                //               ),
                //               child: Center(
                //                 child: Text(
                //                   "Takeaway",
                //                   style: TextStyle(
                //                       color: isDelivery
                //                           ? darkGreyColor
                //                           : Colors.white,
                //                       fontWeight: FontWeight.w500),
                //                 ),
                //               ),
                //             ),
                //           )
                //         ],
                //       )),
                // ),
              ]),
            ),
          ];
        },
        body: SizedBox(
          // height: getHeight(context),
          child: TabBarView(controller: tabController, children: [
            Container(
              height: getHeight(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (storeType != "store") SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      "All ${(storeType != "store") ? "Restaurants" : (storeSubType == "pharmacy") ? "Pharmacies" : "Grocery Stores"}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: true
                        ? RestaurantArea(
                            storeType:
                                storeSubType != "" ? storeSubType : storeType)
                        : ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: [
                              ...List.generate(
                                10,
                                (index) => NearestResturentItem(
                                  onPress: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantDetailScreen()));
                                    Navigator.pushNamed(
                                        context, restaurant_detail_screen);
                                  },
                                  image: 'assets/images/home_img1.png',
                                  title: 'Lorem Ipsum',
                                  distance: "9.5",
                                  placeName: "Place Name",
                                  rating: "4.6",
                                  timeDuration: "40-50",
                                  price: "2",
                                  centerImageheight: 140,
                                  maxWidth: 320,
                                ),
                              ).toList()

                              // SizedBox(
                              //   width: 8,
                              // ),
                              // SizedBox(
                              //   width: 8,
                              // ),
                            ],
                          ),
                  ),

                  // SizedBox(
                  //   height: 40,
                  // ),
                  // HomeItemWidget(onPress: (){}, image: 'assets/images/type1.png', title: 'Restaurant'),
                ],
              ),
            ),
            if (storeType != "store")
              Container(
                height: getHeight(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        "All ${(storeType != "store") ? "Restaurants" : "Grocery Stores"}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: RestaurantArea(
                            storeType:
                                storeSubType != "" ? storeSubType : storeType)),

                    // SizedBox(
                    //   height: 40,
                    // ),
                    // HomeItemWidget(onPress: (){}, image: 'assets/images/type1.png', title: 'Restaurant'),
                  ],
                ),
              ),
          ]),
        ),
      ),
    );
  }
}

class RestaurantArea2 extends StatefulWidget {
  const RestaurantArea2({
    Key? key,
    required this.storeType,
  }) : super(key: key);
  final String storeType;

  @override
  State<RestaurantArea2> createState() => _RestaurantArea2State();
}

class _RestaurantArea2State extends State<RestaurantArea2> {
  RefreshController _refreshController = RefreshController();

  bool loading = false;
  int currentPage = 0;
  int maxPages = 0;
  List itemList = [];

  reset() async {
    setState(() {
      currentPage = 0;
      maxPages = 0;
      // _listItems = [];
      loading = false;
    });
    bool res = await getRestaurantData();
    return res;
  }

  Future<bool> getRestaurantData() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
    _listItems = [];
    _loadItems(10);

    currentPage = currentPage + 1;
    maxPages = currentPage + 1;
    return true;
  }

  Future<bool> loadMoreData() async {
    log("in load more data");
    _refreshController.footerMode!.value = LoadStatus.loading;
    int page = currentPage + 1;
    if (page > maxPages) {
      _refreshController.footerMode!.value = LoadStatus.noMore;
      return false;
    }
    await Future.delayed(Duration(seconds: 5));

    _refreshController.footerMode!.value = LoadStatus.idle;
    _loadItems(10);
    return true;
  }

  var _listItems = <Widget>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  void _loadItems(length) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (_listKey.currentState == null) {
        await Future.delayed(Duration(milliseconds: 400));
        return _loadItems(length);
      }
      var future = Future(() {});
      for (var i = 0; i < length; i++) {
        future = future.then((_) {
          return Future.delayed(Duration(milliseconds: 100), () {
            _listItems.add(NearestResturentItem(
              onPress: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantDetailScreen()));
                if (widget.storeType == "store")
                  Navigator.pushNamed(context, grocery_store_screen);
                else
                  Navigator.pushNamed(context, restaurant_detail_screen);
              },
              image: 'assets/images/home_img1.png',
              title: 'Lorem Ipsum',
              distance: "9.5",
              placeName: "Place Name",
              rating: "4.6",
              timeDuration: "40-50",
              price: "2",
              centerImageheight: 140,
              maxWidth: 320,
            ));
            _listKey.currentState!.insertItem(_listItems.length - 1);
          });
        });
      }
    });
  }

  @override
  void initState() {
    getRestaurantData();
    // _loadItems(10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context),
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: BezierHeader(
          child: Center(
              child: Column(
            children: [
              AppLoader(
                size: 40.0,
                strock: 1,
              ),
              // Text("Loading")
            ],
          )),
          bezierColor: mainColor,
        ),
        footer: CustomFooter(
          height: 150,
          builder: smartRefreshFooter,
        ),
        onLoading: () async {
          print("loading");
          // _refreshController.load
          bool res = await loadMoreData();
        },
        onRefresh: () async {
          bool res = await reset();
          _refreshController.loadComplete();
        },
        child: loading
            ? Center(child: CircularProgressIndicator())
            : AnimatedList(
                key: _listKey,
                // physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 10),
                initialItemCount: _listItems.length,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: CurvedAnimation(
                      curve: Curves.easeOut,
                      parent: animation,
                    ).drive((Tween<Offset>(
                      begin: Offset(1, 0),
                      end: Offset(0, 0),
                    ))),
                    child: _listItems[index],
                  );
                },
              ),
      ),
    );
  }
}

class RestaurantArea extends StatefulWidget {
  const RestaurantArea({
    Key? key,
    required this.storeType,
  }) : super(key: key);
  final String storeType;

  @override
  State<RestaurantArea> createState() => _RestaurantAreaState();
}

class _RestaurantAreaState extends State<RestaurantArea> {
  RefreshController _refreshController = RefreshController();

  bool loading = false;
  int currentPage = 0;
  int maxPages = 0;
  List itemList = [];

  reset() async {
    setState(() {
      currentPage = 0;
      maxPages = 0;
      // _listItems = [];
      loading = false;
    });
    bool res = await getRestaurantData();
    return res;
  }

  Future<bool> getRestaurantData() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
    _listItems = [];
    _loadItems(10);

    currentPage = currentPage + 1;
    maxPages = currentPage + 1;
    return true;
  }

  Future<bool> loadMoreData() async {
    log("in load more data");
    _refreshController.footerMode!.value = LoadStatus.loading;
    int page = currentPage + 1;
    if (page > maxPages) {
      _refreshController.footerMode!.value = LoadStatus.noMore;
      return false;
    }
    await Future.delayed(Duration(seconds: 2));

    _refreshController.footerMode!.value = LoadStatus.idle;
    _loadItems(10);
    return true;
  }

  var _listItems = <Widget>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  void _loadItems(length) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // if (_listKey.currentState == null) {
      //   await Future.delayed(Duration(milliseconds: 400));
      //   return _loadItems(length);
      // }
      // var future = Future(() {});
      List<Widget> list = [];
      for (var i = 0; i < length; i++) {
        list.add(NearestResturentItem(
          onPress: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantDetailScreen()));
            if (widget.storeType == "store")
              Navigator.pushNamed(context, grocery_store_screen);
            else
              Navigator.pushNamed(context, restaurant_detail_screen,
                  arguments: {
                    "store_type": widget.storeType,
                  });
          },
          image: 'assets/images/home_img1.png',
          title: 'Lorem Ipsum',
          distance: "9.5",
          placeName: "Place Name",
          rating: "4.6",
          timeDuration: "40-50",
          price: "2",
          centerImageheight: 140,
          maxWidth: 320,
        ));
      }
      setState(() {
        _listItems.addAll(list);
      });
    });
  }

  @override
  void initState() {
    getRestaurantData();
    // _loadItems(10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int animationDuration = 0;
    return SizedBox(
      height: getHeight(context),
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: BezierHeader(
          child: Center(
              child: Column(
            children: [
              AppLoader(
                size: 40.0,
                strock: 1,
              ),
              // Text("Loading")
            ],
          )),
          bezierColor: mainColor,
        ),
        footer: CustomFooter(
          height: 70,
          builder: smartRefreshFooter,
        ),
        onLoading: () async {
          print("loading");
          // _refreshController.load
          bool res = await loadMoreData();
        },
        onRefresh: () async {
          bool res = await reset();
          _refreshController.loadComplete();
        },
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  ...List.generate(_listItems.length, (index) {
                    if (index != 0) {
                      animationDuration =
                          ((animationDuration += 200) / index).round() + 800;
                    }
                    // print("print:$index  ${animationDuration}");
                    return BuildSlideTransition(
                      curve: Curves.elasticInOut,
                      animationDuration: index == 0 ? 350 : animationDuration,
                      // animationDuration: index * 300,
                      child: _listItems[index],
                    );
                  })
                ],
              ),
      ),
    );
  }
}
