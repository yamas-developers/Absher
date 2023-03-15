import 'package:absher/helpers/route_constants.dart';
import 'package:absher/ui/common_widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../providers/settings/settings_provider.dart';
import '../common_widgets/rounded_borders_button.dart';

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({Key? key}) : super(key: key);

  @override
  State<ThankyouScreen> createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {
  showDialogue(context) {
    showGeneralDialog(
        context: context,
        barrierLabel: "Barrier",
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 400),
        transitionBuilder: (_, anim, __, child) {
          var begin = 0.5;
          var end = 1.0;
          var curve = Curves.bounceOut;
          if (anim.status == AnimationStatus.reverse) {
            curve = Curves.fastLinearToSlowEaseIn;
          }
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return ScaleTransition(
            scale: anim.drive(tween),
            child: child,
          );
        },
        pageBuilder: (BuildContext alertContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Consumer<SettingsProvider>(
                builder: (context, settingsProvider, _) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(6),
                  // height: 400,
                  width: getSize(context, 0.9, 460, 300),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: darkGreyColor.withOpacity(0.3),
                          offset: Offset(0, 2),
                          blurRadius: 18,
                          spreadRadius: 8)
                    ],
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 55, horizontal: 6),
                            width: getWidth(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: mainColor,
                              gradient: LinearGradient(
                                  colors: [
                                    mainColor,
                                    mainColorLight.withOpacity(1)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                            ),
                            child: Column(
                              children: [
                                Text('Thank you for placing order',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'Lorem ipsum dolor sit amet',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  'Order# 25345251',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            left: 0,
                            top: -30,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: RoundedAvatar(
                                  assetPath:
                                      'assets/icons/tick_filled_icon.png',
                                  height: 60,
                                  width: 60,
                                  border: 4,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            left: 0,
                            bottom: -30,
                            child: Align(
                              alignment: Alignment.center,
                              child: RoundedAvatar(
                                assetPath: 'assets/images/mac_logo.jpg',
                                height: 60,
                                width: 60,
                                border: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Total Cost',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${settingsProvider.zone?.zoneData?.first.currency_symbol} 26',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: mainColorLight.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                                child: Row(
                              children: [
                                SizedBox(
                                  width: 6,
                                ),
                                Image.asset(
                                  "assets/icons/info_icon.png",
                                  height: 23,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: Text(
                                    "Please wait your order is processing",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: mainColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RoundBordersButton(
                            title: "Deliver Now",
                            onPressed: () {},
                            fontSize: 14,
                            verticalPadding: 8,
                            selected: true,
                            radius: 50,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          RoundBordersButton(
                            title: "Deliver Later",
                            onPressed: () {},
                            fontSize: 14,
                            verticalPadding: 8,
                            selected: false,
                            radius: 50,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Consumer<SettingsProvider>(builder: (context, settingsProvider, _) {
        return Container(
          height: getHeight(context),
          padding: EdgeInsets.only(top: isPortrait(context) ? 100 : 0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/icons/thankyou_bg.png"))),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    margin: EdgeInsets.only(top: 24),
                    // height: 400,
                    width: getSize(context, 0.9, 460, 300),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: darkGreyColor.withOpacity(0.3),
                            offset: Offset(0, 2),
                            blurRadius: 18,
                            spreadRadius: 8)
                      ],
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 55, horizontal: 6),
                              width: getWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: mainColor,
                                gradient: LinearGradient(
                                    colors: [
                                      mainColor,
                                      mainColorLight.withOpacity(1)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                              ),
                              child: Column(
                                children: [
                                  Text('Thank you for placing order',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Lorem ipsum dolor sit amet',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'Order# 25345251',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 0,
                              left: 0,
                              top: -30,
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: RoundedAvatar(
                                    assetPath:
                                        'assets/icons/tick_filled_icon.png',
                                    height: 60,
                                    width: 60,
                                    border: 4,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              left: 0,
                              bottom: -30,
                              child: Align(
                                alignment: Alignment.center,
                                child: RoundedAvatar(
                                  assetPath: 'assets/images/mac_logo.jpg',
                                  height: 60,
                                  width: 60,
                                  border: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Total Cost',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${settingsProvider.zone?.zoneData?.first.currency_symbol} 26',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: mainColorLight.withOpacity(0.20),
                                borderRadius: BorderRadius.circular(6)),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                  child: Row(
                                children: [
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Image.asset(
                                    "assets/icons/info_icon.png",
                                    height: 23,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Please wait your order is processing",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: mainColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RoundBordersButton(
                              title: "Track",
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, order_detail_screen);
                              },
                              fontSize: 16,
                              verticalPadding: 10,
                              selected: true,
                              radius: 50,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            RoundBordersButton(
                              title: "Home",
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, home_screen, (val) => false);
                              },
                              fontSize: 16,
                              verticalPadding: 10,
                              selected: false,
                              radius: 50,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     showAlertDialog(
          //       context,
          //       "Success",
          //       "Order Placed Successfully",
          //     );
          //   },
          //   child: Container(
          //     child: Text("Thankyou"),
          //   ),
          // )
        );
      }),
    );
  }
}
