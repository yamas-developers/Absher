import 'package:absher/helpers/public_methods.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

class RoundedCenterButtton extends StatelessWidget {
  const RoundedCenterButtton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.heightToMinus = 66,

  }) : super(key: key);

  final onPressed;
  final double heightToMinus;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: getWidth(context)-heightToMinus,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
                colors: [mainColor, mainColorLight.withOpacity(1)]
                ,begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            ),
            boxShadow: [
              BoxShadow(
                  color: darkGreyColor.withOpacity(0.2),
                  offset: Offset(0, 2),
                  blurRadius: 8)
            ]
        ),
        child: Text("${title}",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600
          ),),
      ),
    );
  }
}

class OutlinedRoundedCenterButtton extends StatelessWidget {
  const OutlinedRoundedCenterButtton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.heightToMinus = 66,

  }) : super(key: key);

  final onPressed;
  final double heightToMinus;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onPressed,
      child: Container(
        width: getWidth(context)-heightToMinus,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.grey),
            // gradient: LinearGradient(
            //     colors: [mainColor, mainColorLight.withOpacity(1)]
            //     ,begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter
            // ),
            boxShadow: [
              BoxShadow(
                  color: darkGreyColor.withOpacity(0.2),
                  offset: Offset(0, 2),
                  blurRadius: 8)
            ]
        ),
        child: Text("${title}",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: mainColor,
              fontSize: 15,
              fontWeight: FontWeight.w600
          ),),
      ),
    );
  }
}

class RoundedSocialMediaButtton extends StatelessWidget {
  const RoundedSocialMediaButtton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.imageIcon,
    required this.color,
  }) : super(key: key);

  final onPressed;
  final String imageIcon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: getWidth(context)-66,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(40),

            boxShadow: [
              BoxShadow(
                  color: darkGreyColor.withOpacity(0.2),
                  offset: Offset(0, 2),
                  blurRadius: 8)
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "${imageIcon}",
              height: 26,
            ),
            SizedBox(
              width: 10,
            ),
            Text("${title}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600
              ),),
          ],
        ),
      ),
    );
  }
}
