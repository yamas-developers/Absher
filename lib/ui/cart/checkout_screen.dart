import 'package:absher/helpers/public_methods.dart';
import 'package:absher/ui/common_widgets/rounded_center_button.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/route_constants.dart';
import '../common_widgets/avatar.dart';
import '../common_widgets/checkout_amount_row.dart';
import '../common_widgets/rounded_borders_button.dart';

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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
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
                RoundedAvatar(assetPath: "assets/images/mac_logo.jpg"),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lorem ipsum dolor sit amet",
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
                                  "3.6",
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
                                "Delivery: 40 mins",
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
                      TextButton(onPressed: (){}, child: Text("Update Address", style: TextStyle(
                        decoration: TextDecoration.underline
                      ),))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                        fontSize: 16,
                        color: blackFontColor,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: getWidth(context) * 0.7,
                    child: Text(
                      "Home 251 west Road , London 2nd Floor, 215/52 , Flat 2G",
                      style: TextStyle(
                          fontSize: 16,
                          color: blackFontColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/images/temp/maps.png",
                    height: 140,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
                        CheckoutAmountRow(title: "Cart Total", amount: "600"),
                        SizedBox(
                          height: 10,
                        ),
                        CheckoutAmountRow(
                            title: "Delivery Charge", amount: "30"),
                        SizedBox(
                          height: 10,
                        ),
                        CheckoutAmountRow(title: "Total Amount", amount: "630"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RoundBordersButton(
                        title: "Deliver Now",
                        onPressed: () {
                          setState(() {
                            deliverNow = true;
                            selectedTimeIndex = -1;
                          });
                        },
                        fontSize: 16,
                        verticalPadding: 14,
                        selected: selectedTimeIndex == -1,
                        radius: 50,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      RoundBordersButton(
                        title: "Deliver Later",
                        onPressed: () {
                          _modalBottomSheetMenu(
                              context);
                          // setState(() {
                          //   deliverNow = false;
                          // });
                        },
                        fontSize: 16,
                        verticalPadding: 14,
                        selected: selectedTimeIndex != -1,
                        radius: 50,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
                        "QAR 630",
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
                      Navigator.pushReplacementNamed(context, thankyou_screen);
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
                        onTap: (){
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
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
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
                            onTap: (){
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
