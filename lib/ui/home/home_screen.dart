import 'package:absher/helpers/constants.dart';
import 'package:absher/helpers/route_constants.dart';
import 'package:absher/providers/location/location_provider.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../helpers/public_methods.dart';
import '../common_widgets/comon.dart';
import '../common_widgets/nearest_restaurant_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;

  getPageData() async {
    // FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void initState() {
    getPageData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   // DeviceOrientation.portraitDown,
    // ]);
    // EasyLocalization.of(context)!.setLocale(Locale('en', 'US'));
    // context.setLocale(Locale('en'));
    print("MK: localization: ${context.locale.toString()}");
    print("MK: localization2: ${Directionality.of(context).toString() == 'TextDirection.ltr'}");
    print("tr(): ${getString("app_name")}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 4,
            // ),
            Container(
              height: getLargestSide(context) * 0.08,
              padding: EdgeInsets.fromLTRB(18, 10, 18, 0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 6,
                    child: TouchableOpacity(
                      onTap: () {
                        modalBottomSheetLocation(context);
                      },
                      child: Container(
                        // height: 39,
                        padding: EdgeInsets.fromLTRB(8, 9, 4, 9),
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
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(120, 22, 145, 1),
                                  fontWeight: FontWeight.w600),
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
                            Navigator.pushNamed(context, notifications_screen);
                          },
                          child: Image.asset(
                            "assets/icons/notification.png",
                            width: 24,
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
              height: 8,
            ),
            Container(
              height:
                  getLargestSide(context) * (isPortrait(context) ? 0.18 : 0.2),
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height:
                          getSize(context, 0.6, getWidth(context) * .47, 120),
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
                        width: getSmallestSide(context),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Image.asset(
                                  'assets/images/banner1.jpeg',
                                  width: getSmallestSide(context),
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
                        width: getSmallestSide(context),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Image.asset(
                                  'assets/images/banner2.jpeg',
                                  width: getSmallestSide(context),
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
            SizedBox(
              height: 8,
            ),
            Container(
              height: getLargestSide(context) * 0.035,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                getString("home__welcome_to") + " " + getString("app_name"),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            Container(
              width: getWidth(context),
              height: getLargestSide(context) * 0.17,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: HomeItemWidget(
                        onPress: () {
                          Navigator.pushNamed(context, restaurant_screen);
                        },
                        image: 'assets/images/type1.png',
                        title: getString('home__restaurant')),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: HomeItemWidget(
                        onPress: () {
                          //go to store
                          Navigator.pushNamed(context, restaurant_screen,
                              arguments: {"screen_type": "store"});
                        },
                        image: 'assets/images/store.png',
                        title: getString('home__store')),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 16,),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //   child: Row(
            //       children: [
            //     Expanded(
            //       child: HomeItemBanner(
            //           onPress: () {
            //           },
            //           image: 'assets/images/express_delivery_image.jpg',
            //           title: 'Absher Express'),
            //     ),
            //   ]),
            // ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: getWidth(context),
              height: getLargestSide(context) * 0.17,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: HomeItemWidget(
                        onPress: () {
                          //go to store
                          Navigator.pushNamed(context, restaurant_screen,
                              arguments: {
                                "screen_type": "store",
                                "screen_sub_type": "pharmacy"
                              });
                        },
                        image: 'assets/images/pharmacy.png',
                        title: getString('home__pharmacy')),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: HomeItemWidget(
                        onPress: () {
                          Navigator.pushNamed(context, services_screen);
                        },
                        image: 'assets/images/service.png',
                        title: getString('home__services')),
                  ),
                ],
              ),
            ),
            // Container(
            //
            //   height: getLargestSide(context)(context)/getSmallestSide(context)*140,
            //   // constraints: BoxConstraints.expand(),
            //   // height: getLargestSide(context)(context),
            //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //   child: GridView.count(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 8,
            //     mainAxisSpacing: 10,
            //     childAspectRatio: getLargestSide(context)(context)/getSmallestSide(context)*0.6,
            //     // childAspectRatio: 1.2,
            //     children: [
            //
            //
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 14,
            ),
            Container(
              height: getLargestSide(context) * 0.03,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                getString('home__top_picks'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              padding: EdgeInsets.only(left: 6, right: 18),
              height: getLargestSide(context) * 0.19,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  HomeTopPickItems(
                      onPress: () {
                        Navigator.pushNamed(context, order_screen);
                      },
                      image: 'assets/icons/past_order.png',
                      title: getString("home__past_orders")),
                  // SizedBox(width: 8,),
                  HomeTopPickItems(
                      onPress: () {
                        Navigator.pushNamed(context, express_delivery_screen);
                      },
                      image: 'assets/icons/delivery_truck_icon.png',
                      color: mainColor,
                      title: getString("app_name") +
                          " " +
                          getString("home__express")),
                  HomeTopPickItems(
                      onPress: () {
                        Navigator.pushNamed(context, order_screen);
                      },
                      image: 'assets/icons/happy_hours.png',
                      title: getString("home__offers")),

                  // SizedBox(width: 8,),
                  HomeTopPickItems(
                      onPress: () {},
                      image: 'assets/icons/offers.png',
                      title: getString("home__happy_hour")),
                  // SizedBox(width: 8,),
                  HomeTopPickItems(
                      onPress: () {},
                      image: 'assets/icons/choices.png',
                      title: getString("home__choices")),
                  // SizedBox(width: 8,),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getString("home__restaurants_nearby"),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    getString("home__view_all"),
                    style: TextStyle(
                      color: Color.fromRGBO(155, 28, 187, 1),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              width: getLargestSide(context),
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  NearestResturentItem(
                    onPress: () {},
                    image: 'assets/images/home_img1.png',
                    title: 'Lorem Ipsum',
                    distance: "9.5",
                    placeName: "Place Name",
                    rating: "4.6",
                    timeDuration: "40-50",
                    price: "2",
                    centerImageheight: 110,
                    maxWidth: 300,
                    widthFraction: 0.7,
                    adjustOnLandscape: false,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  NearestResturentItem(
                    onPress: () {},
                    image: 'assets/images/home_img1.png',
                    title: 'Lorem Ipsum',
                    distance: "9.5",
                    placeName: "Place Name",
                    rating: "4.6",
                    timeDuration: "40-50",
                    price: "2",
                    centerImageheight: 110,
                    maxWidth: 300,
                    widthFraction: 0.7,
                    adjustOnLandscape: false,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // HomeItemWidget(onPress: (){}, image: 'assets/images/type1.png', title: 'Restaurant'),
          ],
        ),
      ),
    );
  }
}



class HomeItemWidget extends StatelessWidget {
  final onPress;
  final String image;
  final String title;

  const HomeItemWidget(
      {Key? key,
      required this.onPress,
      required this.image,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Container(
              width: getSmallestSide(context),
              height: 300,
              child: Image.asset(
                '${image}',
                // fit: BoxFit.cover,
              ),
            ),
            Container(
              width: getSmallestSide(context),
              height: 300,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors: [
                    Color.fromRGBO(188, 55, 222, 0),
                    Color.fromRGBO(188, 55, 222, 0),
                    Color.fromRGBO(120, 22, 145, 0.82),
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "${title}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeItemBanner extends StatelessWidget {
  final onPress;
  final String image;
  final String title;

  const HomeItemBanner(
      {Key? key,
      required this.onPress,
      required this.image,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Container(
              width: getWidth(context),
              height: isPortrait(context) ? 120 : 160,
              child: Image.asset(
                '${image}',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              width: getWidth(context),
              height: isPortrait(context) ? 120 : 160,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors: [
                    Color.fromRGBO(188, 55, 222, 0),
                    Color.fromRGBO(188, 55, 222, 0),
                    Color.fromRGBO(120, 22, 145, 0.82),
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "${title}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTopPickItems extends StatelessWidget {
  final onPress;
  final String image;
  final String title;
  final Color? color;

  const HomeTopPickItems(
      {Key? key,
      required this.onPress,
      required this.image,
      this.color = null,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = getSmallestSide(context) * 0.2;
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8, 0, 8),
        child: Column(
          children: [
            Container(
              width: width,
              height: getLargestSide(context) * 0.1,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      // rgba(155, 28, 187, 0.25)
                      color: Color.fromRGBO(155, 28, 187, 0.25),
                      spreadRadius: .4,
                      blurRadius: 4,
                    ),
                  ]),
              child: Image.asset(
                '$image',
                fit: BoxFit.fitWidth,
                color: color,
                // width: 40,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: width,
              child: Text(
                "$title",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(120, 22, 145, 1),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class NearestResturentItem1 extends StatelessWidget {
//   final Function onPress;
//   final String image;
//   final String title;
//
//   const NearestResturentItem1(
//       {Key? key,
//       required this.onPress,
//       required this.image,
//       required this.title})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(12.0, 8, 0, 8),
//       child: Column(
//         children: [
//           Container(
//             width: getSize(context, .7, 300, 0),
//             // height: 160,
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     // rgba(155, 28, 187, 0.25)
//                     color: Color.fromRGBO(0, 0, 0, 0.2),
//                     spreadRadius: .2,
//                     blurRadius: 2,
//                   ),
//                 ]),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       child: Text(
//                         "$title",
//                         maxLines: 1,
//                         style: TextStyle(
//                           overflow: TextOverflow.ellipsis,
//                           color: Color.fromRGBO(120, 22, 145, 1),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Image.asset(
//                           "assets/icons/location_pin_grey.png",
//                           width: 16,
//                           height: 16,
//                         ),
//                         Container(
//                           width: 80,
//                           child: Text(
//                             "Place Name",
//                             maxLines: 1,
//                             style: TextStyle(
//                               overflow: TextOverflow.ellipsis,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Stack(
//                     alignment: Alignment.bottomLeft,
//                     children: [
//                       Image.asset(
//                         '$image',
//                         width: getSmallestSide(context),
//                         height: 110,
//                         fit: BoxFit.cover,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8, bottom: 2.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
//                               decoration: BoxDecoration(
//                                 color: Color.fromRGBO(155, 28, 187, 0.85),
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Image.asset(
//                                     "assets/icons/star.png",
//                                     width: 14,
//                                     height: 14,
//                                   ),
//                                   SizedBox(
//                                     width: 2,
//                                   ),
//                                   Text(
//                                     "4.6",
//                                     style: TextStyle(
//                                         fontSize: 12, color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 6,
//                             ),
//                             Flex(
//                               direction: Axis.horizontal,
//                               children: [
//                                 Expanded(
//                                   flex: 3,
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Image.asset(
//                                         "assets/icons/time.png",
//                                         width: 16,
//                                         height: 16,
//                                       ),
//                                       SizedBox(
//                                         width: 2,
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                           "40-50 Mints",
//                                           maxLines: 1,
//                                           style: TextStyle(
//                                               overflow: TextOverflow.ellipsis,
//                                               fontSize: 12,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Image.asset(
//                                         "assets/icons/kilometer.png",
//                                         width: 16,
//                                         height: 16,
//                                       ),
//                                       SizedBox(
//                                         width: 2,
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                           "9.5 km",
//                                           maxLines: 1,
//                                           style: TextStyle(
//                                             overflow: TextOverflow.ellipsis,
//                                               fontSize: 12, color: Colors.white),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Image.asset(
//                                         "assets/icons/rider.png",
//                                         width: 22,
//                                         height: 22,
//                                       ),
//                                       SizedBox(
//                                         width: 2,
//                                       ),
//                                       Text(
//                                         "\$2",
//                                         style: TextStyle(
//                                             fontSize: 12, color: Colors.white),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // SizedBox(
//           //   height: 10,
//           // ),
//         ],
//       ),
//     );
//   }
// }
