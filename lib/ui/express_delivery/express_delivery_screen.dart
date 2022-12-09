import 'package:absher/helpers/public_methods.dart';
import 'package:absher/ui/common_widgets/rounded_center_button.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/route_constants.dart';
import '../common_widgets/language_aware_widgets.dart';

class ExpressDeliveryScreen extends StatefulWidget {
  const ExpressDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<ExpressDeliveryScreen> createState() => _ExpressDeliveryScreenState();
}

class _ExpressDeliveryScreenState extends State<ExpressDeliveryScreen> {
  String pickupAddress = "";
  String deliveryAddress = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ReflectByLanguage(
                      child: Image.asset(
                        "assets/icons/back_arrow_icon.png",
                        width: 24,
                        height: 24,
                      ),
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
                        "${getString('app_name')} ${getString('express__express')}",
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
      Center(
        child: Text(
          getString('express__from_here_there'),
          style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w700),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        children: [
          // SizedBox(width: 20,),
          Column(
            children: [
              CircularPoint(),
              SizedBox(
                height: 4,
              ),
              Container(
                height: 30,
                width: 3,
                decoration: BoxDecoration(color: Colors.black),
              ),
              SizedBox(
                height: 4,
              ),
              CircularPoint(),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap:(){
                    setState(() {
                      pickupAddress = pickupAddress==""?"Sinaa St. Doha, Qatar":"";
                    });
                  },
                  child: DeliveryAddressItem(
                    title: pickupAddress == ""? getString("express__enter_pickup_address") : pickupAddress,
                    color: pickupAddress == ""? lightGreyFontColor : Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap:(){
                    setState(() {
                      deliveryAddress = deliveryAddress==""?"7FJX*H Doha, Qatar":"";
                    });
                  },
                  child: DeliveryAddressItem(
                    title: deliveryAddress == ""? getString("express__enter_delivery_address") : deliveryAddress,
                    color: deliveryAddress == ""? lightGreyFontColor : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Center(
        child: Image.asset("assets/images/absher_express.png", height: getSize(context, 0.3, 250, 200
        ),),
      ),
      SizedBox(
        height: 15,
      ),
      BulletList(
          [
        getString('express__maximum_size'),
        getString('express__maximum_weight'),
        '${getString('app_name')} ${getString('express__does_not_provide_package')}'
      ]),
      if(isPortrait(context)) Spacer(),
      Divider(),
      if(pickupAddress != "" && deliveryAddress != "")Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getString('common__qar'),
              style: TextStyle(
                  fontSize: 15, color: mainColor, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              "30",
              style: TextStyle(
                  fontSize: 18, color: mainColor, fontWeight: FontWeight.w600),
            ),
          ],),
        SizedBox(
          height: 8,
        ),
        Center(
          child: Text(
            "${getString('express__pick_up_at')} 2:30 pm | ${getString('express__delivery_at')} 9:30 pm",
            style: TextStyle(
                fontSize: 13, color: mediumGreyColor, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 8,
        ),

        Center(child: RoundedCenterButtton(title: getString("express__enter_details"),onPressed: (){
          Navigator.pushNamed(context, express_details_screen);
        },)),
      ],)
      else Padding(
        padding:
        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Text(
          getString("express__select_locations"),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
      ),
      SizedBox(
        height: 35,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: isPortrait(context) ? Column(children: children,) : ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

class DeliveryAddressItem extends StatelessWidget {
  const DeliveryAddressItem({
    Key? key,
    required this.title, required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
      width: getWidth(context),
      decoration: BoxDecoration(
        color: lightGreyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${title}", style: TextStyle(color: color),),
          ReflectByLanguage(
            child: Image.asset(
              "assets/icons/forward_arrow.png",
              color: darkGreyColor,
              height: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class CircularPoint extends StatelessWidget {
  const CircularPoint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.black, width: 4)),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> strings;

  BulletList(this.strings);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(4, 15, 4, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022',
                style: TextStyle(
                  fontSize: 20,
                  height: 1.2,
                  // color: lightGreyFontColor
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    str,
                    textAlign: getTextAlignStart(context),
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      // color: lightGreyFontColor,
                      height: 1.55,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
