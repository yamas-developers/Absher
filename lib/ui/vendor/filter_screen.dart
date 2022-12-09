import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../common_widgets/build_slide_transition.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double distanceSliderValue = 100;
  double ratingSliderValue = 4;
  bool isFreeDelivery = true;
  bool isDeliveryByVendor = true;

  @override
  Widget build(BuildContext context) {
    int animationDuration = 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
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
                            "Filter",
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
                height: 36,
              ),
              BuildSlideTransition(
                animationDuration: animationDuration+=300,
                child: FilterSliderItem(
                  title: 'Distance',
                  imageIcon: "assets/icons/distance.png",
                  sliderCounts: 100,
                  sliderMax: 500,
                  sliderMin: 5,
                  sliderUnit: "km",
                  sliderValue: distanceSliderValue,
                  onSliderChanged: (double value) {
                    setState(() {
                      distanceSliderValue = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              BuildSlideTransition(
                animationDuration: animationDuration += 300,
                child: FilterRadioItem(
                  checkBoxValue: isFreeDelivery,
                  title: 'Free Delivery',
                  imageIcon: "assets/icons/delivery_van.png",
                  onBoxChanged: ( value) {
                      print("value of check bocx is: ${value}");
                    setState(() {
                      isFreeDelivery = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              BuildSlideTransition(
                animationDuration: animationDuration+=300,
                child: FilterRadioItem(
                  checkBoxValue: isDeliveryByVendor,
                  title: 'Delivery By Vendor',
                  imageIcon: "assets/icons/box_with_tick.png",
                  onBoxChanged: ( value) {
                    print("value of check bocx is: ${value}");
                    setState(() {
                      isDeliveryByVendor = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              BuildSlideTransition(
                animationDuration: animationDuration+=300,
                child: FilterSliderItem(
                  title: 'Rating',
                  imageIcon: "assets/icons/star_outline.png",
                  sliderCounts: 5,
                  sliderMax: 5,
                  sliderMin: 1,
                  sliderUnit: "Stars",
                  sliderValue: ratingSliderValue,
                  onSliderChanged: (double value) {
                    setState(() {
                      ratingSliderValue = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  width: 270,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                  BoxShadow(
                  color: darkGreyColor.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 8)
                  ]
                  ),
                  child: Text("Show All Restaurants",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),),
                ),
              ),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterSliderItem extends StatelessWidget {
  const FilterSliderItem({
    Key? key,
    required this.sliderValue,
    required this.sliderMin,
    required this.sliderMax,
    required this.sliderCounts,
    required this.title,
    required this.imageIcon,
    required this.sliderUnit,
    this.onSliderChanged,
  }) : super(key: key);
  final double sliderValue;
  final double sliderMin;
  final double sliderMax;
  final int sliderCounts;
  final String sliderUnit;
  final String title;
  final String imageIcon;
  final onSliderChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: darkGreyColor.withOpacity(0.2),
                offset: Offset(0, 2),
                blurRadius: 8)
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                "${imageIcon}",
                color: darkGreyColor,
                height: 26,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${title}",
                style: TextStyle(color: darkGreyColor, fontSize: 16),
              )
            ],
          ),
          Slider(
            value: sliderValue,
            min: sliderMin,
            max: sliderMax,
            divisions: sliderCounts,
            label: "$title: ${sliderValue.round().toString()} $sliderUnit",
            onChanged: onSliderChanged,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${sliderMin.round()} $sliderUnit"),
                Text("${sliderMax.round()} $sliderUnit"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FilterRadioItem extends StatelessWidget {
  const FilterRadioItem({
    Key? key,
    required this.title,
    required this.checkBoxValue,
    required this.imageIcon,
    this.onBoxChanged,
  }) : super(key: key);
  final String title;
  final bool checkBoxValue;
  final String imageIcon;
  final onBoxChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: darkGreyColor.withOpacity(0.2),
                offset: Offset(0, 2),
                blurRadius: 8)
          ]),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                "${imageIcon}",
                height: 26,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${title}",
                style: TextStyle(color: darkGreyColor, fontSize: 16),
              ),
              Spacer(),
              Checkbox(
                shape: CircleBorder(),
                value: checkBoxValue,
                onChanged: onBoxChanged,checkColor: mainColor,
              )
            ],
          ),

        ],
      ),
    );
  }
}
