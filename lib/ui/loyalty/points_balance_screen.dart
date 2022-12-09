import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';

class PointsBalanceScreen extends StatefulWidget {
  const PointsBalanceScreen({Key? key}) : super(key: key);

  @override
  State<PointsBalanceScreen> createState() => _PointsBalanceScreenState();
}

class _PointsBalanceScreenState extends State<PointsBalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(177, 50, 210, 1),
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          // Container(
          //   width: getWidth(context),
          //   height: getHeight(context),
          //   // color: Colors.grey,
          // ),
          Container(
            color: mainColorLightest,
            height: getHeight(context),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: getWidth(context),
                        child: Image.asset(
                          "assets/images/cart_top_layout.png",
                          color: mainColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                        child: Center(
                          child: Image.asset(
                            'assets/images/app_logo.png',
                            color: Colors.white,
                            width: getSize(context, .22, 200, 60),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 14,),
                      GestureDetector(
                        onTap: (){
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
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Your Balance",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                5,
                              ),
                              decoration: BoxDecoration(
                                  color: mainColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: darkGreyColor.withOpacity(.3),
                                        offset: Offset(0, 1),
                                        blurRadius: 18,
                                        spreadRadius: 4),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  )),
                              child: Image.asset(
                                "assets/icons/points_star.png",
                                height: 28,
                                width: 28,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "9999+",
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BalanceScreenItem(
                    iconPath: 'assets/icons/paper_plane_icon.png',
                    title: 'Invite Your Friends',
                    subTitle: 'Get points by sharing with your friends',
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BalanceScreenItem(
                    iconPath: 'assets/icons/gift_icon.png',
                    title: 'Gift Cards',
                    subTitle: 'Get points by Lorem Ipsum',
                    points: 68,
                    showTrailing: true,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BalanceScreenItem(
                    iconPath: 'assets/icons/delivery_bus.png',
                    title: 'Free Delivery',
                    subTitle: 'Redeem Points and get it',
                    points: 30,
                    showTrailing: true,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BalanceScreenItem(
                    iconPath: 'assets/icons/itunes_icon.png',
                    title: 'Free iTunes Theme',
                    subTitle: 'Redeem Points and get it',
                    points: 150,
                    showTrailing: true,
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BalanceScreenItem extends StatelessWidget {
  final onPressed;
  final String title;
  final String subTitle;
  final String iconPath;
  final int points;
  final bool showTrailing;

  const BalanceScreenItem({
    Key? key,
    this.onPressed,
    required this.title,
    required this.subTitle,
    required this.iconPath,
    this.points = 0,
    this.showTrailing = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 6),
        child: Row(
          children: [
            SizedBox(width: 6,),
            Expanded(
                flex: 2,
                child: Image.asset(
                  "${iconPath}",
                  height: 50,
                )),
            SizedBox(width: 4,),
            Expanded(
              flex: 8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 12,),
                    Text(
                      "${title}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: darkGreyFontColor),
                    ),
                    SizedBox(height: 6,),
                    Text(
                      "${subTitle}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    // SizedBox(height: 12,),
                  ],
                ),
              ),
            ),
            if(showTrailing)Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(
                            2,
                          ),
                          decoration: BoxDecoration(
                              color: mainColor,
                              boxShadow: [
                                BoxShadow(
                                    color: darkGreyColor.withOpacity(.3),
                                    offset: Offset(0, 1),
                                    blurRadius: 18,
                                    spreadRadius: 4),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              )),
                          child: Image.asset(
                            "assets/icons/points_star.png",
                            height: 14,
                            // width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "${points}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: mainColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    GestureDetector(
                        onTap: onPressed,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: mainColor),
                          child: Text(
                            "Redeem",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
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
