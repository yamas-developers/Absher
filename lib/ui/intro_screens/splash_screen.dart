import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:absher/api/mj_api_service.dart';
import 'package:absher/helpers/constants.dart';
import 'package:absher/helpers/route_constants.dart';
import 'package:absher/helpers/session_helper.dart';
import 'package:absher/providers/settings/settings_provider.dart';
import 'package:absher/providers/user/user_provider.dart';
import 'package:absher/ui/common_widgets/build_slide_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../api/mj_apis.dart';
import '../../helpers/public_methods.dart';
import '../../models/user.dart';
import '../../providers/location/location_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/absher_title_video.mp4')
      ..initialize().then((_) {
        _controller.play();
        setState(() {});

        Future.delayed(Duration(seconds: 3)).then((value) => getData());
      });
    // getData();
    // Future.delayed(Duration(seconds: 5)).then((value) => Navigator.pushReplacementNamed(context, "language_screen"));
    super.initState();
  }

  getData() async {
    String? token = await getSession();
    UserProvider userProvider = context.read<UserProvider>();
    if(token != null){
    await userProvider.fetchUser();
    }

    if (userProvider.isLogin) {
      Navigator.pushNamedAndRemoveUntil(context, home_screen, (val)=>false);
    } else {
      Navigator.pushReplacementNamed(context, language_screen);
    }
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
        body: Container(
          height: getHeight(context),
          width: getWidth(context),
          decoration: BoxDecoration(
              color: mainColor,
              image: DecorationImage(
                  image: AssetImage("assets/images/splash_screen_gadient.png"),
                  fit: BoxFit.fill)),
          child: Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
            // Stack(
            //   children: [
            //     Align(
            //         alignment: Alignment.center,
            //         child: Image.asset(
            //           "assets/images/splash_screen_bg.png",
            //           width: getWidth(context),
            //           fit: BoxFit.fill,
            //         )),
            //     BuildSlideTransition(
            //       animationDuration: 1100,
            //       curve: Curves.elasticInOut,
            //       child: Center(
            //         child: Image.asset(
            //           'assets/images/app_logo.png',
            //           width: 180,
            //           // height: 140,
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       height: 50,
            //     )
            //   ],
            // ),
          ),
        ));
  }
}
