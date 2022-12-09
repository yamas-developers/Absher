import 'package:flutter/material.dart';

import '../../helpers/public_methods.dart';
class NearestResturentItem extends StatelessWidget {
  final onPress;
  final String image;
  final String title;
  final String price;
  final String placeName;
  final String rating;
  final String distance;
  final String timeDuration;
  final double widthFraction;
  final double maxWidth;
  final double centerImageheight;
  final bool adjustOnLandscape;

  const NearestResturentItem(
      {Key? key,
        required this.onPress,
        required this.image,
        required this.title,
        required this.price,
        required this.placeName,
        required this.timeDuration,
        required this.rating,
        required this.distance,
        this.widthFraction = 1,
        this.maxWidth = 300,
        this.centerImageheight = 110, this.adjustOnLandscape = true,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: onPress,
            child: Container(
              width: isPortrait(context) || !adjustOnLandscape ? getSize(context, widthFraction, maxWidth, 0) : 600,
              // height: 160,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      // rgba(155, 28, 187, 0.25)
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      spreadRadius: .2,
                      blurRadius: 2,
                      offset: Offset(1, 3)
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "$title",
                          maxLines: 1,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Color.fromRGBO(120, 22, 145, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/location_pin_grey.png",
                            width: 16,
                            height: 16,
                          ),
                          Container(
                            width: 80,
                            child: Text(
                              placeName,
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image.asset(
                          '$image',
                          width: getWidth(context),
                          height: isPortrait(context) || !adjustOnLandscape? centerImageheight : 240,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(155, 28, 187, 0.85),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/icons/star.png",
                                      width: 14,
                                      height: 14,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "${rating}",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/icons/time.png",
                                          width: 16,
                                          height: 16,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "$timeDuration Mints",
                                            maxLines: 1,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/icons/kilometer.png",
                                          width: 16,
                                          height: 16,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "$distance km",
                                            maxLines: 1,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 12, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/icons/rider.png",
                                          width: 22,
                                          height: 22,
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          "\$$price",
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.white,
                                          fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
        ],
      ),
    );
  }
}
