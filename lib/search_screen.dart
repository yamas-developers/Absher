import 'package:absher/ui/common_widgets/avatar.dart';
import 'package:absher/ui/common_widgets/build_slide_transition.dart';

// import 'package:absher/temp.dart';
import 'package:flutter/material.dart';

import 'helpers/constants.dart';
import 'helpers/public_methods.dart';
import 'helpers/route_constants.dart';
import 'ui/common_widgets/nearest_restaurant_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isDelivery = true;

  @override
  Widget build(BuildContext context) {
    int duration = 300;
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
              padding: EdgeInsets.fromLTRB(0, 10, 18, 0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Image.asset(
                        //   "assets/icons/back_arrow_icon.png",
                        //   width: 24,
                        //   height: 24,
                        // ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
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
                            "assets/icons/search_icon.png",
                            width: 20,
                            height: 20,
                            color: mainColor,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Flexible(
                              child: Text(
                            getString('common__search'),
                            style: TextStyle(
                                fontSize: 16,
                                color: mainColor,
                                fontWeight: FontWeight.w500),
                          )),
                        ],
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
                            color: mainColor,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,)
                ],
              ),
            ),
            ...safeguardConnectivityAndService(context: context, widgets: [Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
              child: Column(
                children: [
                  ...List.generate(
                      4,
                          (index) => BuildSlideTransition(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              children: [
                                RoundedAvatar(
                                  assetPath:
                                  "assets/images/temp/ellipse${index < 3 ? index : 1}.png",
                                  color: mainColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // SizedBox(height: 12,),
                                      Text(
                                        "BonTon",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        "4.4M Saved",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      ),
                                      // SizedBox(height: 12,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          animationDuration: duration += 300,
                          startPos: 1.0,
                          curve: Curves.elasticInOut))
                ],
              ),
            ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14, top: 18),
                child: Text(
                  getString("search__top_searched"),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: darkGreyColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 170,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(
                        4,
                            (index) => Container(
                          decoration: BoxDecoration(
                            // color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: lightGreyColor.withOpacity(0.35),
                                    blurRadius: 12,
                                    offset: Offset(2, 4))
                              ]),
                          padding: EdgeInsets.only(
                              left: index == 0 ? 14 : 4, right: 4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              "assets/images/temp/rectangle${index < 3 ? index : 1}.png",
                              height: 150,
                              width: 130,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),])
          ],
        ),
      ),
    );
  }
}
