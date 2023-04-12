import 'dart:math';
import 'dart:developer' as dev;

import 'package:absher/api/mj_apis.dart';
import 'package:absher/models/order_detail.dart';
import 'package:absher/ui/common_widgets/rounded_center_button.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../helpers/firebase/firebase_helper.dart';
import '../../helpers/public_methods.dart';
import '../../helpers/route_constants.dart';
import '../../providers/order/order_detail_provider.dart';
import '../../providers/settings/settings_provider.dart';
import '../common_widgets/avatar.dart';
import '../common_widgets/checkout_amount_row.dart';
import '../common_widgets/language_aware_widgets.dart';
import '../common_widgets/map_widget.dart';
import '../common_widgets/misc_widgets.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  List orderStatuses = [
    "",
    getString("order__received"),
    getString("order__processed"),
    getString("order__picked_up"),
    getString("order__delivered")
  ];
  String? orderId;

  getAssetPath(int status) {
    if (status == 2) return "assets/images/order_processed.png";
    if (status == 3) return "assets/images/order_picked_up.png";
    if (status == 4)
      return "assets/images/order_delivered.png";
    else
      return "assets/images/order_received.png";
  }

  @override
  void initState() {
    getPageData();
    super.initState();
  }

  int orderStatus = 0;
  int actualStatus = Random().nextInt(4) + 1;

  getPageData() async {
    OrderDetailProvider provider = context.read<OrderDetailProvider>();
    // actualStatus =
    //     provider.orderItem?.orderStatus == "pending" ? 1 : actualStatus;
    dev.log(
        'order status in getPageData(): ${provider.orderItem?.orderStatus}');
    if (provider.orderItem?.orderStatus == "pending") {
      actualStatus = 1;
    } else if (provider.orderItem?.orderStatus == "rider_accepted") {
      actualStatus = 1;
    } else if (provider.orderItem?.orderStatus == "arrived_at_vendor" ||
        provider.orderItem?.orderStatus == "handover") {
      actualStatus = 2;
    } else if (provider.orderItem?.orderStatus == "picked_up" ||
        provider.orderItem?.orderStatus == "arrived_at_customer") {
      actualStatus = 3;
    } else if (provider.orderItem?.orderStatus == "delivered") {
      actualStatus = 4;
    }
    for (int i = 0; i <= actualStatus; i++) {
      await Future.delayed(Duration(milliseconds: 300));
      setState(() {
        orderStatus = i;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) return;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      orderId = args["order_id"];
      logInfo("order_id: ${orderId}");
    }
    if (orderId != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        OrderDetailProvider provider = context.read<OrderDetailProvider>();
        provider.orderId = orderId;
        await provider.getData();
        context.read<FirebaseHelper>().initOrder(orderId,
            onSuccess: (DatabaseEvent event) async {
          Map data = event.snapshot.value as Map;
          if (data['status'] != null &&
              data['status'] != provider.orderItem?.orderStatus) {
            dev.log("MK: status: you have a changed order status");
            await provider.getData();
            getPageData();
          }
        }, onError: (error) {});
      });
    }

    super.didChangeDependencies();
  }

  double startPos = 2.0;
  double endPos = 0.0;
  Curve curve = Curves.elasticOut;
  int animationDuration = 300;

  buildSlideTransition(child) {
    animationDuration += 300;
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(startPos, 0), end: Offset(endPos, 0)),
      duration: Duration(milliseconds: animationDuration),
      curve: curve,
      builder: (context, Offset offset, child) {
        return FractionalTranslation(
          translation: offset,
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body:
          Consumer<OrderDetailProvider>(builder: (context, detailProvider, _) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 6,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 18, 0),
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
                              child: ReflectByLanguage(
                                child: Image.asset(
                                  "assets/icons/back_arrow_icon.png",
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Text(
                              "${splitAndCapitalize(detailProvider.orderItem?.orderStatus) ?? "N/A"}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: mainColor,
                                  fontWeight: FontWeight.w500),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 46,
                ),
                if (orderStatus == 3)
                  Container(
                    height: 210,
                    margin: EdgeInsets.all(0),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 4,
                      )
                    ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: MapWidget(
                        riderLocation: LatLng(
                            convertDouble(detailProvider
                                .orderItem?.deliveryMan?.currentLat),
                            convertDouble(detailProvider
                                .orderItem?.deliveryMan?.currentLng)),
                        key: UniqueKey(),
                      ),
                    ),
                  )
                else
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      getAssetPath(actualStatus),
                      height: 210,
                      fit: BoxFit.contain,
                    ),
                  ),
                Row(
                  mainAxisAlignment: actualStatus != 1
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (actualStatus != 1)
                      Text(
                        "${getString("order__order_id")} ${detailProvider.orderItem?.id ?? "N/A"}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                      decoration: BoxDecoration(
                        color: mainColorLight,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: darkGreyColor.withOpacity(.2),
                              offset: Offset(0, 1),
                              blurRadius: 28,
                              spreadRadius: 2),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            "${detailProvider.orderDetailItem?.processingTime ?? "--"}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            getString("order__mins"),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                    ),
                    OrderStatusIcon(
                        isActive: orderStatus >= 1,
                        assetPath: 'assets/icons/received_order_icon.png'),
                    Expanded(
                        child: Container(
                      color: orderStatus >= 2 ? mainColorLight : lightGreyColor,
                      height: 6,
                      width: 60,
                    )),
                    OrderStatusIcon(
                        isActive: orderStatus >= 2,
                        assetPath: 'assets/icons/processed_order_icon.png'),
                    Expanded(
                        child: Container(
                      color: orderStatus >= 3 ? mainColorLight : lightGreyColor,
                      height: 6,
                      width: 60,
                    )),
                    OrderStatusIcon(
                        isActive: orderStatus >= 3,
                        assetPath: 'assets/icons/pickedup_order_icon.png'),
                    Expanded(
                        child: Container(
                      color: orderStatus == 4 ? mainColorLight : lightGreyColor,
                      height: 6,
                      width: 60,
                    )),
                    OrderStatusIcon(
                        isActive: orderStatus == 4,
                        assetPath: 'assets/icons/delivered_order_icon.png'),
                    SizedBox(
                      width: 24,
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 14,
                    ),
                    Text(
                      orderStatuses[1],
                      style: TextStyle(
                          color: orderStatus >= 1
                              ? mainColorLight
                              : mediumGreyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      orderStatuses[2],
                      style: TextStyle(
                          color: orderStatus >= 2
                              ? mainColorLight
                              : mediumGreyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      orderStatuses[3],
                      style: TextStyle(
                          color: orderStatus >= 3
                              ? mainColorLight
                              : mediumGreyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      orderStatuses[4],
                      style: TextStyle(
                          color: orderStatus >= 4
                              ? mainColorLight
                              : mediumGreyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildSlideTransition(Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: darkGreyColor.withOpacity(.2),
                                  offset: Offset(0, 1),
                                  blurRadius: 28,
                                  spreadRadius: 2),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 6),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Image.asset(
                                    "assets/icons/distance.png",
                                    height: 40,
                                    color: mainColor,
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                flex: 9,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // SizedBox(height: 12,),
                                      Text(
                                        getString("order__delivery_address"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: mainFontColor),
                                      ),
                                      // SizedBox(
                                      //   height: 2,
                                      // ),
                                      // Text(
                                      //   'Home',
                                      //   style: TextStyle(
                                      //       fontSize: 13,
                                      //       color: Colors.black,
                                      //       fontWeight: FontWeight.w500),
                                      // ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "${detailProvider.orderDetailItem?.deliveryAddress?.address ?? 'Address not available'}",
                                        maxLines: 3,
                                        textDirection: TextDirection.ltr,
                                        textAlign: getTextAlignStart(context),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      ),
                                      // SizedBox(height: 12,),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      )),
                      // buildSlideTransition(Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 6.0, horizontal: 0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(12),
                      //       boxShadow: [
                      //         BoxShadow(
                      //             color: darkGreyColor.withOpacity(.2),
                      //             offset: Offset(0, 1),
                      //             blurRadius: 28,
                      //             spreadRadius: 2),
                      //       ],
                      //     ),
                      //     padding: EdgeInsets.symmetric(
                      //         vertical: 12.0, horizontal: 6),
                      //     child: Row(
                      //       children: [
                      //         SizedBox(
                      //           width: 6,
                      //         ),
                      //         Expanded(
                      //             flex: 3,
                      //             child: Image.asset(
                      //               "assets/icons/contact_person_icon.png",
                      //               height: 50,
                      //               color: mainColor,
                      //             )),
                      //         SizedBox(
                      //           width: 4,
                      //         ),
                      //         Expanded(
                      //           flex: 9,
                      //           child: Padding(
                      //             padding: const EdgeInsets.symmetric(
                      //                 horizontal: 4.0, vertical: 4),
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 // SizedBox(height: 12,),
                      //                 Text(
                      //                   getString("order__customer_service"),
                      //                   style: TextStyle(
                      //                       fontWeight: FontWeight.w600,
                      //                       fontSize: 14,
                      //                       color: mainFontColor),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 2,
                      //                 ),
                      //                 Row(
                      //                   children: [
                      //                     Text(
                      //                       "023 6526 5236",
                      //                       textDirection: TextDirection.ltr,
                      //                       style: TextStyle(
                      //                           fontSize: 13,
                      //                           color: Colors.black,
                      //                           fontWeight: FontWeight.w500),
                      //                     ),
                      //                     Spacer(),
                      //                     TouchableOpacity(
                      //                       onTap: () {
                      //                         // FlutterOpenWhatsapp.sendSingleMessage("923056860156", "Hello");
                      //                         openWhatsApp(
                      //                             '923056860156', 'Hello');
                      //                       },
                      //                       child: Image.asset(
                      //                         "assets/icons/whatsapp_icon.png",
                      //                         height: 24,
                      //                         // color: mainColor,
                      //                       ),
                      //                     )
                      //                   ],
                      //                 ),
                      //                 SizedBox(
                      //                   height: 6,
                      //                 ),
                      //                 Row(
                      //                   children: [
                      //                     Text(
                      //                       "256 5416 5416",
                      //                       textDirection: TextDirection.ltr,
                      //                       style: TextStyle(
                      //                           fontSize: 13,
                      //                           color: Colors.black,
                      //                           fontWeight: FontWeight.w500),
                      //                     ),
                      //                     Spacer(),
                      //                     Image.asset(
                      //                       "assets/icons/phone_rounded_filled.png",
                      //                       height: 24,
                      //                       // color: mainColor,
                      //                     )
                      //                   ],
                      //                 ),
                      //                 // SizedBox(height: 12,),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           width: 20,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )),
                      buildSlideTransition(Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: darkGreyColor.withOpacity(.2),
                                  offset: Offset(0, 1),
                                  blurRadius: 28,
                                  spreadRadius: 2),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 6),
                          child: detailProvider.orderDetailItem?.deliveryMan ==
                                  null
                              ? Center(
                                  child: Text('Delivery man not available'))
                              : Row(
                                  children: [
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RoundedNetworkAvatar(
                                              url: detailProvider
                                                  .orderDetailItem
                                                  ?.deliveryMan
                                                  ?.image,
                                              prefix: MJ_Apis.profileImgPath,
                                              height: 50,
                                              width: 50,
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      flex: 9,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(height: 12,),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              child: Text(
                                                getString(
                                                    "order__delivery_person_details"),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: darkGreyFontColor),
                                              ),
                                            ),
                                            Text(
                                              "${detailProvider.orderDetailItem?.deliveryMan?.fName} ${detailProvider.orderDetailItem?.deliveryMan?.lName}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: mainColor),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: [
                                                TouchableOpacity(
                                                  onTap: () {
                                                    makePhoneCall(detailProvider
                                                        .orderDetailItem
                                                        ?.deliveryMan
                                                        ?.phone);
                                                  },
                                                  child: Text(
                                                    "${detailProvider.orderDetailItem?.deliveryMan?.phone ?? 'Contact not available'}",
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context, chat_screen,
                                                        arguments: {
                                                          "other_user_id":
                                                              "${detailProvider.orderDetailItem?.deliveryMan?.id}",
                                                          "other_user_role":
                                                              "rider",
                                                          "other_user_name":
                                                              "${detailProvider.orderDetailItem?.deliveryMan?.fName} ${detailProvider.orderDetailItem?.deliveryMan?.lName}",
                                                          "order_id":
                                                              "${detailProvider.orderDetailItem?.id}",
                                                        });
                                                  },
                                                  child: Icon(
                                                    Icons.chat,
                                                    color: mainColorLight,
                                                  ),
                                                )
                                              ],
                                            ),
                                            // SizedBox(height: 12,),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                        ),
                      )),
                      buildSlideTransition(
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: darkGreyColor.withOpacity(.2),
                                    offset: Offset(0, 1),
                                    blurRadius: 28,
                                    spreadRadius: 2),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RoundedNetworkAvatar(
                                              url:
                                                  '${detailProvider.orderDetailItem?.business?.logo}',
                                              prefix: MJ_Apis.restaurantImgPath,
                                              // assetPath:
                                              //     "assets/images/mac_logo.png",
                                              height: 50,
                                              width: 50,
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      flex: 9,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(height: 12,),
                                            Text(
                                              "${detailProvider.orderDetailItem?.business?.name ?? "Store name not available"}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            if (detailProvider
                                                    .orderDetailItem
                                                    ?.business
                                                    ?.businessType
                                                    ?.type !=
                                                null)
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "${detailProvider.orderDetailItem?.business?.businessType?.type}",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              mediumGreyColor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            // SizedBox(height: 12,),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          TouchableOpacity(
                                            onTap: () {
                                              makePhoneCall(detailProvider
                                                  .orderDetailItem
                                                  ?.business
                                                  ?.phone);
                                            },
                                            child: Image.asset(
                                              "assets/icons/phone_rounded_filled.png",
                                              height: 24,
                                              // color: mainColor,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, chat_screen,
                                                  arguments: {
                                                    "other_user_id":
                                                    "${detailProvider.orderDetailItem?.business?.id}",
                                                    "other_user_role":
                                                    "vendor",
                                                    "other_user_name":
                                                    "${detailProvider.orderDetailItem?.business?.name}",
                                                    "order_id":
                                                    "${detailProvider.orderDetailItem?.id}",
                                                  });
                                            },
                                            child: Icon(
                                              Icons.chat,
                                              color: mainColorLight,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: mainColorLightest,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: darkGreyColor.withOpacity(.2),
                                  offset: Offset(0, 1),
                                  blurRadius: 28,
                                  spreadRadius: 2),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 25.0, horizontal: 6),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...List.generate(
                                          (detailProvider.orderDetailItem
                                                  ?.details?.length ??
                                              0),
                                          (index) => Column(
                                                children: [
                                                  OrderDetailOneItem(
                                                    item: detailProvider
                                                        .orderDetailItem
                                                        ?.details![index],
                                                  ),
                                                  Divider()
                                                ],
                                              )),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      // CheckoutAmountRow(
                                      //     title: getString("cart__sub_total"),
                                      //     amount: "${detailProvider.orderDetailItem?.orderAmount}"),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      CheckoutAmountRow(
                                          title: getString(
                                              "cart__delivery_charges"),
                                          amount:
                                              "${detailProvider.orderDetailItem?.deliveryCharge}"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CheckoutAmountRow(
                                          title: getString("cart__total"),
                                          amount:
                                              "${detailProvider.orderDetailItem?.orderAmount}"),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: isLtr(context)
                                        ? Radius.circular(12)
                                        : Radius.circular(0),
                                    bottomRight: isLtr(context)
                                        ? Radius.circular(12)
                                        : Radius.circular(0),
                                    topLeft: isLtr(context)
                                        ? Radius.circular(0)
                                        : Radius.circular(12),
                                    bottomLeft: isLtr(context)
                                        ? Radius.circular(0)
                                        : Radius.circular(12),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: darkGreyColor.withOpacity(.2),
                                        offset: Offset(0, 1),
                                        blurRadius: 28,
                                        spreadRadius: 2),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/icons/wallet.png",
                                      height: 26,
                                      // width: 26,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      getString("order__cod"),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      // if (actualStatus == 1)
                      //   RoundedCenterButtton(
                      //       onPressed: () {},
                      //       title: getString("order__cancel_order"))
                      // else if (actualStatus == 5)
                      //   RoundedCenterButtton(
                      //       onPressed: () {
                      //         _modalBottomSheetMenu(context);
                      //       },
                      //       title: getString("order__rate_order")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _modalBottomSheetMenu(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        context: context,
        backgroundColor: mainColorLightest,
        isScrollControlled: true,
        builder: (context) {
          TextStyle _sheetItemStyle =
              TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
          return RatingWidget();
        });
  }
}

class RatingWidget extends StatefulWidget {
  const RatingWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget>
    with SingleTickerProviderStateMixin {
  int rating = 0;
  List responses = [
    "",
    getString("order__very_poor"),
    getString("order__bad"),
    getString("order__average"),
    getString("order__good"),
    getString("order__excellent")
  ];
  List orderQualities = [
    "Temperature",
    "Ingredients",
    "Taste",
    "Packaging",
    "Recipee"
  ];
  List deliveryQualities = [
    "Delivery Time",
    "Rider Behavior",
    "Rider Hygiene",
    "Food Handling"
  ];
  String selected = "";
  bool showFullSheet = false;
  bool showDetailedWidget = false;
  String modeRating = "order";

  // Offset offset = Offset(1, 1);
  double startPos = -1.0;
  double endPos = 0.0;
  dynamic curve = Curves.easeIn;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      height: showFullSheet
          ? getHeight(context)
          : modeRating == "thanks"
              ? 500
              : 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: buildRatingColumn(context, modeRating),
      ),
    );
  }

  Widget buildRatingColumn(BuildContext context, String mode) {
    String ratingHeading = "";
    if (mode == "order" && rating == 0)
      ratingHeading =
          "${getString('order__how_was_order')} ${getString('app_name')}${getString('common__?')}";
    else if (mode == "delivery" && rating == 0)
      ratingHeading =
          "${getString('order__how_was_delivery')} ${getString('app_name')}${getString('common__?')}";
    else if (mode == "thanks")
      ratingHeading = getString('order__thanks_for_feedback');
    else
      ratingHeading = getString('order__what_you_liked');
    List qualities = mode == "order" ? orderQualities : deliveryQualities;
    List<Widget> children = [
      SizedBox(
        height: showFullSheet ? 40 : 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/icons/cross_rounded_filled.png",
              height: 25,
              color: mainColor,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 36,
      ),
      Text(
        "${ratingHeading}",
        style: TextStyle(
            fontSize: mode == "thanks" ? 22 : 18,
            color: darkGreyFontColor,
            fontWeight: FontWeight.w600),
      ),
      SizedBox(
        height: 36,
      ),
      if (mode != "thanks")
        StarRating(
          rating: rating,
          color: mainColor,
          onRatingChanged: (rating) {
            setState(() {
              this.rating = rating;
              showFullSheet = true;
            });
            Future.delayed(Duration(milliseconds: 500)).then((value) {
              setState(() {
                showDetailedWidget = true;
              });
            });
          },
        )
      else
        Image.asset(
          "assets/images/star_illustration.png",
          height: 240,
          // color: mainColor,
        ),
      SizedBox(
        height: 36,
      ),
      if (showDetailedWidget)
        Expanded(
            child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                curve: Curves.ease,
                duration: const Duration(milliseconds: 500),
                builder: (BuildContext context, double opacity, Widget? child) {
                  return Opacity(
                      opacity: opacity,
                      child: Column(
                        children: [
                          Text("${responses[rating]}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: mainColor)),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            // height: 50,
                            child: Wrap(
                              // scrollDirection: Axis.horizontal,
                              children: [
                                ...List.generate(
                                  qualities.length,
                                  (i) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = qualities[i];
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 4),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: qualities[i] == selected
                                                ? mainColor
                                                : mainColorLight
                                                    .withOpacity(0.15),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            "${qualities[i]}",
                                            style: TextStyle(
                                                color: qualities[i] == selected
                                                    ? Colors.white
                                                    : darkGreyFontColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ).toList(),
                              ],
                            ),
                          ),
                          if (isPortrait(context)) Spacer(),
                          Text(
                            getString("order__anymore_notes"),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: mainColor,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          RoundedCenterButtton(
                              onPressed: () {
                                if (mode == "delivery") {
                                  setState(() {
                                    modeRating = "thanks";
                                    showFullSheet = false;
                                    showDetailedWidget = false;
                                  });
                                  // Navigator.pop(context);
                                } else if (mode == "order")
                                  setState(() {
                                    modeRating = "delivery";
                                    showFullSheet = false;
                                    showDetailedWidget = false;
                                    rating = 0;
                                  });
                                else {
                                  Navigator.pop(context);
                                }
                              },
                              title: mode == "order"
                                  ? getString("common__next")
                                  : getString("common__finish")),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ));
                }))
      // if(showFullSheet) ...[
      //
      // ].toList(),
    ];
    if (isPortrait(context))
      return Column(
        children: children,
      );
    else
      return ListView(
        children: children,
      );
  }

  showSuccessfulScreen() {}
}

typedef void RatingChangeCallback(int rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final int rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating(
      {this.starCount = 5,
      this.rating = 0,
      required this.onRatingChanged,
      required this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    double size = 50;
    Color unfilledColor = Colors.blueGrey.withOpacity(0.6);
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        color: unfilledColor,
        size: size,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        color: color,
        size: size,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: color,
        size: size,
      );
    }
    return InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}

class OrderStatusIcon extends StatelessWidget {
  const OrderStatusIcon({
    Key? key,
    required this.isActive,
    required this.assetPath,
  }) : super(key: key);
  final bool isActive;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: isActive ? mainColorLight : lightGreyColor,
          borderRadius: BorderRadius.circular(50)),
      child: Image.asset(
        assetPath,
        height: 24,
        width: 24,
        color: isActive ? Colors.white : darkGreyColor,
      ),
    );
  }
}

class OrderDetailOneItem extends StatelessWidget {
  OrderDetailOneItem({Key? key, required this.item}) : super(key: key);

  // final int index;
  Details? item;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, settingsProvider, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: true
            ? Column(
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ImageWithPlaceholder(
                              image: item?.foodDetails?.image,
                              prefix: MJ_Apis.productImgPath,
                              height: 70,
                              fit: BoxFit.contain,
                            ),
                          )),
                      Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${settingsProvider.zone?.zoneData?.first.currency?.currencySymbol ?? '--'} ${item?.price ?? '__'} ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("${item?.foodDetails?.name}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12)),
                                SizedBox(
                                  height: 6,
                                ),
                                if (item?.variation != null)
                                  Text(
                                      "Variant: ${item?.variation?.first.type}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 11)),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                getString("common__qty"),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${item?.quantity}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                  if ((item?.addOns?.length ?? 0) > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 3),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "AddOns:",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Expanded(
                            flex: 9,
                            child: Column(
                              children: [
                                ...List.generate(
                                    (item?.addOns?.length ?? 0),
                                    (index) => Column(
                                          children: [
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "${capitalizeFirstLetter(item?.addOns?[index].name ?? '')}:  ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "${item?.addOns?[index].qty} x ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  "${settingsProvider.zone?.zoneData?.first.currency?.currencySymbol ?? '--'} ${item?.addOns?[index].price}",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                if (!(item?.addOns?[index]
                                                        .available ??
                                                    true))
                                                  Text(
                                                    " (Unavailable)",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 11),
                                                  ),
                                              ],
                                            )
                                          ],
                                        ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/temp/order_item${1}.png",
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ],
                      )),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 12,),
                          Text(
                            "${settingsProvider.zone?.zoneData?.first.currency?.currencySymbol ?? '--'} 2.99",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet  et dolore",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),

                          // SizedBox(height: 12,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            getString("common__qty"),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${1}",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
      );
    });
  }
}

class VendorInfoItem extends StatelessWidget {
  const VendorInfoItem({
    Key? key,
    required this.title,
    required this.imageIcon,
    required this.subTitle,
    this.iconHeight = 20,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String imageIcon;
  final double iconHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  "${imageIcon}",
                  color: Colors.black,
                  height: iconHeight,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: Text(
                  "${title}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
              // Spacer(),
              Expanded(
                flex: 5,
                child: Text(
                  "${subTitle}",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
