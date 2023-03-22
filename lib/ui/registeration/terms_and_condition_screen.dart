import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../common_widgets/rounded_center_button.dart';
import '../common_widgets/rounded_text_field.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  bool checkBoxValue = false;

  void onBoxChanged(val) {
    setState(() {
      checkBoxValue = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: getWidth(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getHeight(context) * 0.05,
                ),
                Image.asset(
                  'assets/images/app_logo.png',
                  width: 110,

                  // height: 140,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  getString("auth__terms_and_conditions"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: mediumGreyFontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque mattis '
                      'imperdiet ligula. Nunc congue odio ac condimentum lacinia. Nunc viverra '
                      'purus vel magna suscipit pretium. Fusce non risus vitae orci dignissim consectetur. ',
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                      color: mediumGreyFontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Sed eu vestibulum erat. Sed lobortis porta lectus, eget '
                      'sagittis urna dignissim nec. Duis efficitur eros vehicula lectus '
                      'vestibulum, id rutrum nisl ultrices. Sed ut massa vitae velit sodales '
                      'interdum. Nam augue sem, ullamcorper ac auctor ut, placerat at leo'

                      ,
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                      color: mediumGreyFontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Morbi accumsan lectus ut tincidunt vehicula. Donec eget commodo augue,'
                      ' eu tristique velit. Sed non leo sit amet diam finibus commodo. Vestibulum'
                      'vulputate ex in tincidunt tincidunt. Lorem ipsum dolor sit amet, consectetur'
                      'adipiscing elit. Sed nulla ipsum, dapibus ut viverra vel, consequat tempus '
                      'nunc. Morbi ut porta arcu. Cras sodales fermentum massa quis tempor.'

                      ,
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                      color: mediumGreyFontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                // SizedBox(
                //   height: getHeight(context) * 0.15,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
