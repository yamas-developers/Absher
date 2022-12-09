import 'package:absher/helpers/public_methods.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../common_widgets/language_aware_widgets.dart';
import '../common_widgets/rounded_center_button.dart';
import '../common_widgets/rounded_text_field_filled.dart';

class ExpressDetailsScreen extends StatefulWidget {
  const ExpressDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ExpressDetailsScreen> createState() => _ExpressDetailsScreenState();
}

class _ExpressDetailsScreenState extends State<ExpressDetailsScreen> {
  String pickupAddress = "Sinaa St. Doha, Qatar";
  String deliveryAddress = "7FJX*H Doha, Qatar";
  List categories = ["Documents", "Food", "Personal Stuff", "Clothes", "Sensitive Items"];
  String selected = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            getString("express__enter_details"),
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
                height: 15,
              ),
              ExpressDetailItem(address: pickupAddress, title: getString("express__pick_up")),
              SizedBox(
                height: 15,
              ),
              ExpressDetailItem(address: deliveryAddress, title: getString("express__delivery")),
              SizedBox(height: 15,),
              Text(
                getString('express__describe_item'),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10,),
              RoundedTextFieldFilled(label: getString("express__tell_more"), maxLines: 2,),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(
                      categories.length,
                          (i) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = categories[i];
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: categories[i] == selected
                                    ? mainColor
                                    : mainColorLight
                                    .withOpacity(0.15),
                                borderRadius:
                                BorderRadius.circular(6)),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                  child: Text(
                                    "${categories[i]}",
                                    style: TextStyle(
                                        color:
                                        categories[i] == selected
                                            ? Colors.white
                                            : darkGreyColor),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ).toList(),
                  ],
                ),
              ),
              // Spacer(),
              Divider(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getString("common__qar"),
                          style: TextStyle(
                              fontSize: 15,
                              color: mainColor,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "30",
                          style: TextStyle(
                              fontSize: 18,
                              color: mainColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${getString('express__pick_up_at')} 2:30 pm | ${getString('express__delivery_at')} 9:30 pm",
                      style: TextStyle(
                          fontSize: 13,
                          color: mediumGreyColor,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    RoundedCenterButtton(
                      title: getString("express__go_to_checkout"),
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: getString('express__clicking_checkout_agree_terms'),
                          style: TextStyle(
                              color: mediumGreyColor,
                              fontSize: 12,
                              // fontWeight: FontWeight.bold
                          ),
                          children: <TextSpan>[
                            TextSpan(text: getString('express__prohibited_items'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // open desired screen
                                  }
                            ),
                            TextSpan(
                                text: ' ${getString('common__and')} ',
                                style: TextStyle(color: mediumGreyColor,
                                    fontSize: 12,
                                    // fontWeight: FontWeight.bold
                                )
                            ),
                            TextSpan(
                                text: getString('express__terms_n_cond_,'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // open desired screen
                                  }
                            ),
                          ]
                      ),
                    )
                  ],
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

class ExpressDetailItem extends StatelessWidget {
  const ExpressDetailItem({
    Key? key,
    required this.address,
    required this.title,
  }) : super(key: key);

  final String address;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      Text(
        '${title}',
        style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(
        height: 2,
      ),
      Text(
        '${address}',
        style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        children: [
          Expanded(child: RoundedTextFieldFilled(label: getString("express__name"))),
          SizedBox(
            width: 6,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
                color: lightestGreyColor,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.perm_contact_calendar_sharp, color: mediumGreyColor.withOpacity(0.8),),
          )
        ],
      ),
      SizedBox(height: 10,),
      RoundedTextFieldFilled(label: getString("express__phone")),
      SizedBox(height: 10,),
      RoundedTextFieldFilled(label: getString("express__address_details"), maxLines: 3,),
    ],);
  }
}
