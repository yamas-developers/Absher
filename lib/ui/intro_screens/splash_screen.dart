import 'package:absher/helpers/constants.dart';
import 'package:absher/ui/common_widgets/build_slide_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helpers/public_methods.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((value) => Navigator.pushReplacementNamed(context, "language_screen"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   // DeviceOrientation.portraitDown,
    // ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/splash_screen_bg.png",
                width: getWidth(context),
                fit: BoxFit.fill,
              )),
          BuildSlideTransition(
            animationDuration: 1100,
            curve: Curves.elasticInOut,
            child: Center(
              child: Image.asset(
                'assets/images/app_logo.png',
                width: 180,
                // height: 140,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
