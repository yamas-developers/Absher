import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../common_widgets/avatar.dart';

class VendorInfoScreen extends StatefulWidget {
  const VendorInfoScreen({Key? key}) : super(key: key);

  @override
  State<VendorInfoScreen> createState() => _VendorInfoScreenState();
}

class _VendorInfoScreenState extends State<VendorInfoScreen> {
  @override
  Widget build(BuildContext context) {
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
                            "Vendor Info",
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
              RoundedAvatar(assetPath: "assets/images/mac_logo.jpg"),
              SizedBox(
                height: 16,
              ),
              Text(
                "Bob Burger",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "American - Burger - Pasta",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 36,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Info",
                      style: TextStyle(
                          color: mainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    VendorInfoItem(
                        title: 'Rating',
                        subTitle: '4.50',
                        imageIcon: "assets/icons/star_outline.png"),
                    VendorInfoItem(
                        title: 'Restaurant Area',
                        subTitle: 'Al Markhiya',
                        imageIcon: "assets/icons/location_pin.png"),
                    VendorInfoItem(
                        title: 'Opening Hours',
                        subTitle: '11.30am- 3.30am',
                        imageIcon: "assets/icons/time.png", iconHeight: 25),
                    VendorInfoItem(
                        title: 'Delivery Time',
                        subTitle: '30 - 40 Mins',
                        imageIcon: "assets/icons/delivery_bike.png"),
                    VendorInfoItem(
                        title: 'Distance',
                        subTitle: '4.2 KMs',
                        imageIcon: "assets/icons/distance_line.png", iconHeight: 30,),
                    VendorInfoItem(
                        title: 'Delvery Charge',
                        subTitle: 'QAE 10',
                        imageIcon: "assets/icons/credit_card.png"),
                    VendorInfoItem(
                        title: 'Payment Methods',
                        subTitle: 'Cash On Delivery',
                        imageIcon: "assets/icons/wallet.png"),
                  ],
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

class VendorInfoItem extends StatelessWidget {
  const VendorInfoItem({
    Key? key,
    required this.title,
    required this.imageIcon,
    required this.subTitle, this.iconHeight = 20,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String imageIcon;
  final double iconHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  "${imageIcon}",
                  color: Colors.black,
                  height: iconHeight,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: Text(
                  "${title}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
              // Spacer(),
              Expanded(
                flex: 5,
                child: Text(
                  "${subTitle}",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
