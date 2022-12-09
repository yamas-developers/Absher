import 'dart:math';

import 'package:absher/ui/common_widgets/build_slide_transition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../helpers/route_constants.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({Key? key}) : super(key: key);

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  int _current = 0;
  List<String> subCategories = ["Egg", "Chicken", "Mutton", "Beef", "Fish"];
  List<String> items = ["Chicken", "Wings", "Lorem ipsum dolor"];
  String selected = "Chicken";
  @override
  Widget build(BuildContext context) {
    int animationDuration = 0;
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
                Container(
                  color: mainColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                      color: Colors.white,
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
                                      color: mainColor,
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Flexible(
                                        child: Text(
                                          "Search for category",
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
                                    onTap: (){
                                      Navigator.pushNamed(context, cart_screen);
                                    },
                                    child: Image.asset(
                                      "assets/icons/cart.png",
                                      width: 24,
                                      color: Colors.white,
                                      height: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("Get Your Grocery", style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white
                        ),),
                      ),
                    ],),
                ),
                // SizedBox(
                //   height: 20,
                // ),
              ]),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          child: Column(
            children: [
              Container(
                // color: mainColorLight.withOpacity(0.25),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(
                      subCategories.length,
                          (i) => GestureDetector(
                        onTap: () {

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: subCategories[i] == selected
                                    ? mainColor
                                    : mainColorLight
                                    .withOpacity(0.25),
                                borderRadius:
                                BorderRadius.circular(6)),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                  child: Text(
                                    "${subCategories[i]}",
                                    style: TextStyle(
                                        color:
                                        subCategories[i] == selected
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
              Expanded(
                // height: getHeight(context)-200,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isPortrait(context)?2:4,
                      childAspectRatio: 0.75
                  ),
                  // itemCount: 16,
                  // itemBuilder: (context, i) => ),
                  children: [
                    ...List.generate(50, (index) {

                      if(index != 0){
                        animationDuration = ((animationDuration+=200)/index).round()+ 800;
                      }
                      return BuildSlideTransition(
                        startPos: index % 2 == 0 ? -1 : 1,
                      animationDuration: index == 0 ? 350 :animationDuration,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: lightGreyColor),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Stack(
                                  children: [
                                    Image.asset(
                                      "assets/images/temp/meat${index>5? Random().nextInt(5): index}.png",
                                      // width: 84,
                                      // color: Colors.white,
                                      height: 104,
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(color: darkGreyColor.withOpacity(0.3),blurRadius: 8,offset: Offset(1,4))
                                          ]
                                        ),
                                        child: Image.asset(
                                          "assets/icons/favorite.png",
                                          // width: 84,
                                          color: mainColor,
                                          height: 28,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "QAR 23",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: mainColor),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text("${items[index>2?2:index]}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: darkGreyColor,

                                  ),),
                                // SizedBox(
                                //   height: 14,
                                // ),
                                Spacer(),
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
                                        textAlign: TextAlign.center,

                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    )),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                    }).toList()
                  ],
                ),),
            ],
          ),
        ),
      ),
    );
  }
}
