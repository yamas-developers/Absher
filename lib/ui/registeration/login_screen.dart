import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../common_widgets/rounded_center_button.dart';
import '../common_widgets/rounded_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                height: 15,
              ),
              Text(
                getString("auth_sign_in_continue"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: mediumGreyFontColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              RoundedTextField(
                label: getString("auth__phone"),
                icon: Icons.phone,
              ),
              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                label: getString("auth__password"),
                icon: Icons.lock,
              ),
              SizedBox(
                height: 0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 26,
                  ),
                  Checkbox(
                    shape: CircleBorder(),
                    value: checkBoxValue,
                    onChanged: onBoxChanged,
                    checkColor: mainColor,
                  ),
                  Text(
                    getString("auth__remember_me"),
                    style: TextStyle(
                        color: darkGreyColor, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                height: 0,
              ),
              // Spacer(),

              RoundedCenterButtton(
                  onPressed: () {
                    Navigator.pushNamed(context, "home_screen");
                  },
                  title: getString("auth__login")),
              SizedBox(
                height: 10,
              ),
              OutlinedRoundedCenterButtton(
                  onPressed: () {
                    Navigator.pushNamed(context, "home_screen");
                  },
                  title: getString('auth__login_as_guest')),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    getString("auth__forgot_password"),
                    style: TextStyle(
                        color: mainColor, fontWeight: FontWeight.w500),
                  )),

              Text(
                getString("auth__login_with"),
                style: TextStyle(
                    color: mediumGreyColor, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              RoundedSocialMediaButtton(
                  onPressed: () {
                  },
                  title: getString("auth__continue_fb"), imageIcon: "assets/icons/facebook_icon.png", color: facebookColor,),
              SizedBox(
                height: 10,
              ),
              RoundedSocialMediaButtton(
                onPressed: () {
                },
                title: getString("auth__continue__google"), imageIcon: "assets/icons/google_icon.png", color: googleColor,),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getString("auth__do_not_have_account"),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "signup_screen");
                      },
                      child: Text(
                        getString("auth__sign_up"),
                        style: TextStyle(
                            color: mainColor, fontWeight: FontWeight.w500),
                      )),
                ],
              ),

              // SizedBox(
              //   height: getHeight(context) * 0.15,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
