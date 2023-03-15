import 'package:absher/api/mj_apis.dart';
import 'package:absher/providers/settings/settings_provider.dart';
import 'package:absher/ui/common_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/public_methods.dart';
import '../../models/restaurant.dart';
class NearestResturentItem extends StatelessWidget {
  final onPress;
  final double widthFraction;
  final double maxWidth;
  final double centerImageheight;
  final bool adjustOnLandscape;
  final Business resData;

  const NearestResturentItem(
      {Key? key,
        required this.resData,
        required this.onPress,
        this.widthFraction = 1,
        this.maxWidth = 300,
        this.centerImageheight = 110, this.adjustOnLandscape = true,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, _) {
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
                              "${resData.name}",
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Color.fromRGBO(120, 22, 145, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/location_pin_grey.png",
                                  width: 16,
                                  height: 16,
                                ),
                                Expanded(
                                  child: Container(
                                    // width: 120,
                                    child: Text(
                                      "${resData.address}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                            if(resData.coverPhoto!=null)
                            ImageWithPlaceholder(
                              prefix: '${MJ_Apis.restaurantCoverImgPath}',
                              image: '${resData.coverPhoto}',
                              width: getWidth(context),
                              height: isPortrait(context) || !adjustOnLandscape? centerImageheight : 240,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              height: isPortrait(context) || !adjustOnLandscape? centerImageheight : 240,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      end: Alignment.bottomCenter,
                                      begin: Alignment.topCenter,
                                      colors: [
                                        Color.fromRGBO(188, 55, 222, 0),
                                        Color.fromRGBO(188, 55, 222, 0),
                                        Color.fromRGBO(
                                            120, 22, 145, 0.82),
                                      ])),
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
                                          "${resData.ratingCount??0}",
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
                                        flex: 2,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/icons/time.png",
                                              width: 16,
                                              height: 16,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Flexible(
                                              child: Text(
                                                "${resData.deliveryTime} Mints",
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
                                                "${"to do"} km",
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
                                            Flexible(
                                              child: Text(
                                                "${settingsProvider.zone?.zoneData?.first.currency_symbol} ${resData.minimumShippingCharge}+",
                                                maxLines: 1,
                                                style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    fontSize: 12, color: Colors.white,
                                                fontWeight: FontWeight.w600
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
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
    );
  }
}
