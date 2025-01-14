import 'package:absher/helpers/public_methods.dart';
import 'package:absher/providers/cart/cart_provider.dart';
import 'package:absher/ui/common_widgets/rounded_center_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../../helpers/route_constants.dart';
import '../../providers/location/location_provider.dart';
import '../../providers/settings/settings_provider.dart';
import '../common_widgets/avatar.dart';
import '../common_widgets/build_slide_transition.dart';
import '../common_widgets/cart_item.dart';
import '../common_widgets/checkout_amount_row.dart';
import '../common_widgets/comon.dart';
import '../common_widgets/map_widget.dart';

class ChecoutScreen extends StatefulWidget {
  const ChecoutScreen({Key? key}) : super(key: key);

  @override
  State<ChecoutScreen> createState() => _ChecoutScreenState();
}

class _ChecoutScreenState extends State<ChecoutScreen> {
  bool deliverNow = true;
  List times = [
    '10:00 PM- 11:00 PM',
    '11:00 PM- 12:00 AM',
    '12:00 PM- 01:00 PM',
    '01:00 PM- 02:00 PM',
    '02:00 PM- 03:00 PM',
    '03:00 PM- 04:00 PM'
  ];
  int selectedTimeIndex = -1;

  changeIndex(index) {
    setState(() {
      selectedTimeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    int animationDuration = 300;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return Consumer<LocationProvider>(builder: (context, locProvider, _) {
            return Consumer<CartProvider>(builder: (context, provider, _) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            flex: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                    child: Text(
                                  "Check out",
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
                      height: 26,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        RoundedNetworkAvatar(
                            url:
                                "${MJ_Apis.restaurantImgPath}${provider.currentStore?.logo}"),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${provider.currentStore?.name ?? "Restaurant: N/A"}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: blackFontColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/star.png",
                                          height: 18,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          "${provider.currentStore?.ratingCount ?? "0.0"}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/time.png",
                                        height: 18,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "Delivery: ${provider.currentStore?.deliveryTime ?? "0-0"} mins",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: mainColor,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/pin.png",
                                color: mainColor,
                                height: 26,
                              ),
                              Text(
                                "Delivery Address",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: mainColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              TextButton(
                                  onPressed: () {
                                    modalBottomSheetLocation(context);
                                  },
                                  child: Text(
                                    "Update Address",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${locProvider.city}",
                            style: TextStyle(
                                fontSize: 16,
                                color: blackFontColor,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: getWidth(context) * 0.7,
                            child: Text(
                              "${locProvider.address}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: blackFontColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 160,
                            margin: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3, blurRadius: 4,)]
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: MapWidget(
                                  customerLocation: locProvider.currentLocation,key: UniqueKey(),),
                            ),
                          ),
                          // Image.asset(
                          //   "assets/images/temp/maps.png",
                          //   height: 140,
                          // ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Cart Products",
                            style: TextStyle(
                                fontSize: 16,
                                color: blackFontColor,
                                fontWeight: FontWeight.w600),
                          ).marginOnly(left: 10),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: mainColorLight,
                                  borderRadius: BorderRadius.circular(14)),
                              child: Column(
                                children: [
                                  ...List.generate(
                                      provider.list.length,
                                      (index) => BuildSlideTransition(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 6.0),
                                              child: CartItem(
                                                bgColor: mainColorLight,
                                                item: provider.list[index],
                                                onIncrease: () {
                                                  int q = convertNumber(provider
                                                          .list[index].qty) +
                                                      1;
                                                  provider
                                                      .updateProductCartQuantity(
                                                          provider.list[index].id!,
                                                          q);
                                                },
                                                onDecrease: () {
                                                  int q = convertNumber(provider
                                                          .list[index].qty) -
                                                      1;
                                                  provider
                                                      .updateProductCartQuantity(
                                                          provider.list[index].id!,
                                                          q);
                                                },
                                                onDelete: () {
                                                  provider.removeFromCart(
                                                      provider.list[index].id!);
                                                  showToast(
                                                      "Item removed from cart");
                                                },
                                              ),
                                            ),
                                            animationDuration: animationDuration +=
                                                300,
                                            curve: Curves.elasticInOut,
                                            startPos: index % 2 == 0 ? 4 : -4,
                                          )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: darkGreyColor.withOpacity(0.3),
                                      offset: Offset(0, 2),
                                      blurRadius: 8)
                                ],
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: Column(
                              children: [
                                CheckoutAmountRow(
                                    title: "Cart Total",
                                    amount: "${provider.cartTotal}"),
                                SizedBox(
                                  height: 10,
                                ),
                                CheckoutAmountRow(
                                    title: "Delivery Charge", amount: "0"),
                                SizedBox(
                                  height: 10,
                                ),
                                CheckoutAmountRow(
                                    title: "Total Amount",
                                    amount: "${provider.cartTotal}"),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     RoundBordersButton(
                          //       title: "Deliver Now",
                          //       onPressed: () {
                          //         setState(() {
                          //           deliverNow = true;
                          //           selectedTimeIndex = -1;
                          //         });
                          //       },
                          //       fontSize: 16,
                          //       verticalPadding: 14,
                          //       selected: selectedTimeIndex == -1,
                          //       radius: 50,
                          //     ),
                          //     SizedBox(
                          //       width: 12,
                          //     ),
                          //     RoundBordersButton(
                          //       title: "Deliver Later",
                          //       onPressed: () {
                          //         _modalBottomSheetMenu(
                          //             context);
                          //         // setState(() {
                          //         //   deliverNow = false;
                          //         // });
                          //       },
                          //       fontSize: 16,
                          //       verticalPadding: 14,
                          //       selected: selectedTimeIndex != -1,
                          //       radius: 50,
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: darkGreyColor.withOpacity(0.3),
                                      offset: Offset(0, 2),
                                      blurRadius: 8)
                                ],
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Add Promo Code",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: blackFontColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      "assets/icons/percentage_icon.png",
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: greyDividerColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                "assets/icons/wallet.png",
                                height: 22,
                                color: mainColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Cash On Delivery",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: mainColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Text(
                                "${settingsProvider.zone?.zoneData?.first.currency?.currencySymbol??'--'} ${provider.cartTotal}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: blackFontColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RoundedCenterButtton(
                            title: "Place Order",
                            onPressed: () {
                              if(!settingsProvider.operatingArea){
                                showToast("Selected address is not in the operating area");
                                return;
                              }
                              provider.placeOrder(context);
                              // Navigator.pushReplacementNamed(
                              //     context, thankyou_screen);
                            },
                            heightToMinus: 0,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              );
            });
          });
        }
      ),
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
        builder: (context) {
          TextStyle _sheetItemStyle =
              TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
          return Container(
            height: 398,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/icons/calendar_icon.png",
                        height: 30,
                      ),
                      Text('Choose Delivery Time',
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/icons/cross_rounded_filled.png",
                          height: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Container(
                      width: getWidth(context),
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        // border: Border.all(
                        //   color:  Color.fromRGBO(27, 189, 198, 1),
                        // ),
                      ),
                      child: Text(
                        'Wednesday Jun 22, 2022',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: mediumGreyColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    children: [
                      ...List.generate(
                        times.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              changeIndex(index);
                              Navigator.pop(context);
                            },
                            child: BottomSheetTimeItem(
                              time: times[index],
                              selected: index == selectedTimeIndex,
                            ),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class BottomSheetTimeItem extends StatelessWidget {
  const BottomSheetTimeItem(
      {Key? key, required this.time, required this.selected})
      : super(key: key);
  final String time;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: Container(
        width: getWidth(context) * 0.43,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selected ? mainColor : Colors.white,
          // border: Border.all(
          //   color:  Color.fromRGBO(27, 189, 198, 1),
          // ),
        ),
        child: Text(
          time,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: selected ? Colors.white : mediumGreyColor,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
