import 'dart:developer';

import 'package:absher/helpers/route_constants.dart';
import 'package:absher/models/category.dart';
import 'package:absher/models/restaurant.dart';
import 'package:absher/providers/business/restaurant_provider.dart';
import 'package:absher/providers/business/takeaway_pharma_provider.dart';
import 'package:absher/ui/common_widgets/build_slide_transition.dart';
import 'package:absher/ui/common_widgets/comon.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';

// import 'package:absher/ui/vendor/restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../helpers/app_loader.dart';
import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../models/misc_models.dart';
import '../../providers/business/delivery_pharma_provider.dart';
import '../../providers/business/delivery_restaurant_provider.dart';
import '../../providers/business/grocery_store_provider.dart';
import '../../providers/business/takeaway_restaurant_provider.dart';
import '../../providers/location/location_provider.dart';
import '../common_widgets/misc_widgets.dart';
import '../common_widgets/nearest_restaurant_item.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen>
    with TickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  TabController? tabController;
  bool isDelivery = true;
  bool isSearchExpanded = false;
  bool isRestaurantSearchExpanded = false;
  String storeType = BUSINESS_TYPE_RESTAURANT;

  // String storeSubType = "";

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
      storeType = args["store_type"];
      logInfo("store_type: ${storeType}");
    }
    if (storeType == BUSINESS_TYPE_STORE) {
      tabController = TabController(length: 1, vsync: this);
    }
    if (storeType == BUSINESS_TYPE_RESTAURANT||storeType == BUSINESS_TYPE_PHARMACY) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<RestaurantProvider>().getData(type: storeType);
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // double width = getWidth(context) * (isSearchExpanded ? 1.0 : 0.3);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, resProvider, _) {
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 4,
                    ),
                    TopHeaderWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Visibility(
                          visible: storeType == BUSINESS_TYPE_STORE ||
                              isRestaurantSearchExpanded,
                          child: BuildSlideTransition(
                            animationDuration: 300,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TouchableOpacity(
                                  onTap: () {
                                    if (isSearchExpanded) return;
                                    setState(() {
                                      isSearchExpanded = true;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(15)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    width: getWidth(context) *
                                        (isSearchExpanded || storeType == BUSINESS_TYPE_STORE ? 0.81 : 0.4),
                                    duration: Duration(milliseconds: 200),
                                    child: Row(
                                      mainAxisAlignment: isSearchExpanded
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.center,
                                      children: [
                                        TouchableOpacity(
                                          onTap: (){
                                            showToast('Searching');
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            QueryParams params = resProvider.params;
                                            params.searchedText = _searchController.text;
                                            resProvider.params = params;
                                            getDataForReataurantsFilter(params, context);
                                          },
                                          child: Image.asset(
                                            "assets/icons/search_icon.png",
                                            width: 24,
                                            color: darkGreyColor,
                                            height: 24,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                              height: 30,
                                              child: TextField(
                                                controller: _searchController,
                                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.only(bottom: 12),
                                                    border: InputBorder.none,
                                                    labelText: "Search",
                                                    labelStyle: TextStyle(color: mainColor),
                                                    floatingLabelBehavior:
                                                    FloatingLabelBehavior.never),
                                              ),
                                            )),
                                        // Text(
                                        //   "Search",
                                        //   style: TextStyle(
                                        //       color: darkGreyColor,
                                        //       fontSize: 15,
                                        //       fontWeight: FontWeight.w500),
                                        // ),
                                        // if (isSearchExpanded) Spacer(),
                                        if (isSearchExpanded)
                                          BuildSlideTransition(
                                              animationDuration: 600,
                                              child: Image.asset(
                                                "assets/icons/cross_rounded_filled.png",
                                                height: 18,
                                                color: mainColor,
                                              ))
                                      ],
                                    ),
                                  ).marginSymmetric(horizontal: 14),
                                ),
                                if (isSearchExpanded)
                                  TouchableOpacity(
                                      onTap: () {
                                        setState(() {
                                          isSearchExpanded = false;
                                          isRestaurantSearchExpanded = false;
                                        });
                                      },
                                      child: BuildSlideTransition(
                                          animationDuration: 1000,
                                          curve: Curves.easeInOut,
                                          child: Image.asset(
                                            "assets/icons/back_arrow_icon.png",
                                            height: 18,
                                          )))
                              ],
                            ),
                          )),
                    ),
                    Visibility(
                      visible: storeType != BUSINESS_TYPE_STORE &&
                          !isRestaurantSearchExpanded,
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
                                        color: (resProvider.params.rating != null)? mainColor:null,
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
                                            color: (resProvider.params.rating != null)? Colors.white:darkGreyColor,
                                            height: 24,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "Filter",
                                            style: TextStyle(
                                                color: (resProvider.params.rating != null)? Colors.white:darkGreyColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: (){
                                      log("MJ: ${(resProvider.params.showTopRated)}");
                                        // setState(() {
                                        // });
                                          QueryParams params = resProvider.params;
                                          params.showTopRated = !(resProvider.params.showTopRated??false);
                                          resProvider.params = params;
                                          // resProvider.params.showTopRated = !(resProvider.params.showTopRated??false);
                                      log("MJ: ${(resProvider.params.showTopRated)}");
                                    },
                                    child: Container(
                                      width: getWidth(context) * .3,
                                      decoration: BoxDecoration(
                                        color: (resProvider.params.showTopRated??false)? mainColor:null,
                                          border: Border(
                                        // left: BorderSide(color: darkGreyColor, width: 1),
                                        right: BorderSide(
                                            color: darkGreyColor, width: 1),
                                      )),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Top Rated",
                                            // (storeType != "store")
                                            //     ? "Cousines"
                                            //     : (storeSubType == "pharmacy")
                                            //         ? "Pharmacies"
                                            //         : "Stores",
                                            style: TextStyle(
                                                color: (resProvider.params.showTopRated??false)? Colors.white:darkGreyColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TouchableOpacity(
                                    onTap: () {
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
                      visible: storeType != BUSINESS_TYPE_STORE,
                      child: Builder(
                          builder: (context) {
                        if (resProvider.restaurantCategories.isEmpty)
                          return SizedBox();
                        return Container(
                          color: mainColorLight.withOpacity(0.25),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          height: 44,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: resProvider.restaurantCategories.length,
                            itemBuilder: (context, i) {
                              Category category =
                                  resProvider.restaurantCategories[i];
                              String catId = resProvider.restaurantCategories[i].id??"";
                              bool isSelected = resProvider.selectedRestaurantCat == resProvider.restaurantCategories[i].id;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                                child: InkWell(
                                  onTap: (){
                                    if(isSelected)
                                      resProvider.selectedRestaurantCat = "";
                                    else{
                                      resProvider.selectedRestaurantCat = catId;
                                    }

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    color: isSelected?mainColor.withOpacity(0.8):null,
                                    ),
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                                    child: Center(
                                        child: Text(
                                      "${category.name}",
                                      style: TextStyle(
                                        color: isSelected? Colors.white : mainColor,
                                        fontWeight: isSelected?FontWeight.w600 : FontWeight.normal,
                                        fontSize: isSelected?15 : 14
                                      ),
                                    )),
                                  ),
                                ),
                              );
                            },
                            // children: [
                            //
                            //
                            //   // Padding(
                            //   //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //   //   child: Center(
                            //   //       child: Text(
                            //   //     "Shawarma",
                            //   //     style: TextStyle(color: mainColor),
                            //   //   )),
                            //   // ),
                            //   // Padding(
                            //   //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //   //   child: Center(
                            //   //       child: Text(
                            //   //     "Biryani",
                            //   //     style: TextStyle(color: mainColor),
                            //   //   )),
                            //   // ),
                            //   // Padding(
                            //   //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //   //   child: Center(
                            //   //       child: Text(
                            //   //     "Fast Food",
                            //   //     style: TextStyle(color: mainColor),
                            //   //   )),
                            //   // ),
                            //   // Padding(
                            //   //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //   //   child: Center(
                            //   //       child: Text(
                            //   //     "Thai Food",
                            //   //     style: TextStyle(color: mainColor),
                            //   //   )),
                            //   // ),
                            // ],
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: storeType != BUSINESS_TYPE_STORE,
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
                              ]),
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
                              unselectedLabelStyle: TextStyle(fontSize: 14),
                              labelStyle: TextStyle(fontSize: 16),
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
              child: TabBarView(controller: tabController, children: [
                Container(
                  height: getHeight(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (storeType != BUSINESS_TYPE_STORE) SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          "All ${(storeType == BUSINESS_TYPE_STORE) ? "Grocery Stores" : (storeType == BUSINESS_TYPE_PHARMACY) ? "Pharmacies" : "Restaurants"}",
                          style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (storeType == BUSINESS_TYPE_STORE)
                        Expanded(

                            child: Consumer<GroceryStoreProvider>(
                                builder: (context, pro, _) {
                          return RestaurantArea(
                            storeType: storeType,
                            resProvider: pro,
                            // params: QueryParams(),
                          );
                        }))
                      else if (storeType == BUSINESS_TYPE_PHARMACY)
                        Expanded(


                            child: Consumer<DeliveryPharmaProvider>(
                                builder: (context, pro, _) {
                          return RestaurantArea(
                            storeType: storeType,
                            resProvider: pro,params: resProvider.params,
                          );
                        }))
                      else
                        Expanded(child: Consumer<DeliveryRestaurantProvider>(
                            builder: (context, pro, _) {
                          return RestaurantArea(
                            storeType: storeType,
                            resProvider: pro,params: resProvider.params,
                          );
                        })),
                    ],
                  ),
                ),
                if (storeType != BUSINESS_TYPE_STORE)
                  Container(
                    height: getHeight(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Text(
                            "All ${(storeType == BUSINESS_TYPE_PHARMACY) ? "Pharmacy Stores" : "Restaurants"}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (storeType == BUSINESS_TYPE_PHARMACY)
                          Expanded(
                              child: Consumer<TakeawayPharmaProvider>(
                                  builder: (context, pro, _) {
                            return RestaurantArea(
                                storeType: storeType, resProvider: pro, params: resProvider.params,);
                          }))
                        else
                          Expanded(child: Consumer<TakeawayRestaurantProvider>(
                              builder: (context, pro, _) {
                            return RestaurantArea(
                                storeType: storeType, resProvider: pro, params: resProvider.params);
                          })),
                      ],
                    ),
                  ),
              ]),
            ),
          );
        }
      ),
    );
  }
}

class TopHeaderWidget extends StatelessWidget {
  const TopHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              onTap: () {
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
                          context.watch<LocationProvider>().address ??
                              getString("home__location"),
                      maxLines: 1,overflow: TextOverflow.ellipsis,
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
    );
  }
}


class RestaurantArea extends StatefulWidget {
  const RestaurantArea({
    Key? key,
    required this.storeType,
    required this.resProvider, this.catId = "", this.params,
  }) : super(key: key);
  final String storeType;
  final String catId;
  final dynamic resProvider;
  final QueryParams? params;

  @override
  State<RestaurantArea> createState() => _RestaurantAreaState();
}

class _RestaurantAreaState extends State<RestaurantArea> {
  bool initialized = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
     try{
       // QueryParams params = Provider.of<RestaurantProvider>(context).params;
       log("MJ: in init state: ");
       await widget.resProvider.reset(params: widget.params);
       initialized = true;
     }catch(e){
       log("error in initstate: $e");
     }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  RefreshController controller = widget.resProvider.refreshController;
  log("NJ: refresh ${controller.isRefresh}");
    return Consumer<RestaurantProvider>(
      builder: (context, provider, _) {
        return SizedBox(
          height: getHeight(context),
          child: SmartRefresher(
            controller: controller,
            // controller: widget.resProvider.refreshController,
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
                ],
              )),
              bezierColor: mainColor,
            ),
            footer: CustomFooter(
              height: 70,
              builder: smartRefreshFooter,
            ),
            onLoading: () async {
              log("MJ: loading in onLoading ${controller.isRefresh} ${controller.isLoading}");

              // _refreshController.load
              // bool res = await loadMoreData();
              if(!controller.isRefresh && initialized == true)
                // await widget.resProvider.reset();
              // else
              await widget.resProvider.getData(/*empty_list: false*/);
            },
            onRefresh: () async {
              log("MJ: loading in refresh ${controller.isRefresh}");
              await widget.resProvider.reset();
            },
            child: widget.resProvider.loading && widget.resProvider.list.isEmpty
                ? LoadingIndicator()
                : widget.resProvider.list.isEmpty ? ListView(
                  children: [
                    EmptyWidget(),
                  ],
                ) : ListView(
                    children: [
                      ...List.generate(widget.resProvider.list.length, (index) {
                        Business restaurant = widget.resProvider.list[index];
                        return SizedBox(
                          child: NearestResturentItem(
                            onPress: () {
                              if (widget.storeType == BUSINESS_TYPE_STORE)
                                Navigator.pushNamed(context, grocery_store_screen,
                                    arguments: {
                                      "store": widget.resProvider.list[index],
                                    });
                              else
                                Navigator.pushNamed(
                                    context, restaurant_detail_screen,
                                    arguments: {
                                      "store": widget.resProvider.list[index],
                                    });
                            },
                            resData: restaurant,
                            centerImageheight: 140,
                            maxWidth: 320,
                          ),
                        );
                      })
                    ],
                  ),
          ),
        );
      }
    );
  }
}


