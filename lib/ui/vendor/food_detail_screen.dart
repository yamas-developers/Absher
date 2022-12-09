import 'package:absher/helpers/public_methods.dart';
import 'package:absher/ui/common_widgets/rounded_center_button.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  String image = "assets/images/placeholder_image.png";
  String title = "Food Name";
  String type = "restaurant";
  String id = "";

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) return;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      image = args["image"];
      title = args["title"];
      id = args["id"];
      type = args["type"];
      print("arguments: ${image}, ${title}");
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                    tag: ValueKey("${id}"),
                    child: Image.asset(
                      "${image}",
                      height: 200,
                      fit: BoxFit.cover,
                      width: getWidth(context),
                    )),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "55 ₪",
                        style: TextStyle(
                            color: priceGreenColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 6,),
                      Text(
                        "${title}",
                        style: TextStyle(
                            color: blackFontColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 6,),

                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do e",
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Add Ons",
                        style: TextStyle(
                            color: blackFontColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Wrap(children: [
                    for (int i = 0; i < 4; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Container(
                          width: getWidth(context) / 2 - 16,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                              color: mainColorLightest,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "2 QAR",
                                      style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "${type == "pharmacy"? "${(i+1)*10} mg":"Extra Sauce"}",
                                      style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      "assets/icons/plus_filled.png",
                                      height: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${i}",
                                      style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      "assets/icons/minus_filled.png",
                                      height: 18,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    "Add Comment",
                    style: TextStyle(
                        color: blackFontColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    decoration:
                    BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: darkGreyColor.withOpacity(0.3),
                              offset: Offset(0, 2),
                              blurRadius: 8)
                        ],
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white
                    ),
                    child: TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: "Add your comment",
                          border: InputBorder.none
                        // OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "Quantity",
                    style: TextStyle(
                        color: blackFontColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    // width: 270,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    decoration: BoxDecoration(
                        border: Border.all(color: lightGreyFontColor),
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,

                        boxShadow: [
                          BoxShadow(
                              color: darkGreyColor.withOpacity(0.2),
                              offset: Offset(0, 2),
                              blurRadius: 8)
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset("assets/icons/angle_left.png", height: 30,color: lightGreyFontColor,),
                        ),
                        Text("0",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: lightGreyFontColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset("assets/icons/angle_right.png", height: 30,color: lightGreyFontColor,),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: RoundedCenterButtton(onPressed: (){}, title: "Add to Cart", heightToMinus: 0),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
          Positioned.fill(
              top: 12,
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Image.asset(
                          "assets/icons/back_arrow_icon.png",
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Image.asset(
                              "assets/icons/bookmark.png",
                              width: 20,
                              // height: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Image.asset(
                              "assets/icons/exit_icon.png",
                              width: 24,
                              height: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
