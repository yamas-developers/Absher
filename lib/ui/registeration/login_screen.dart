import 'dart:developer';

import 'package:absher/helpers/route_constants.dart';
import 'package:absher/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../config/mj_config.dart';
import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../helpers/session_helper.dart';
import '../../providers/user/user_provider.dart';
import '../common_widgets/rounded_center_button.dart';
import '../common_widgets/rounded_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checkBoxValue = false;

  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool isLoading = false;
  String emailErrorText = '';
  String passwordErrorText = '';

  bool customerSelected = true;
  bool shouldSubmit = true;

  void onBoxChanged(val) {
    setState(() {
      checkBoxValue = val;
    });
  }

  submit() async {
    log("in submit:");
    emailErrorText = '';
    passwordErrorText = '';
    shouldSubmit = true;

    if (phoneCtrl.text.isEmpty || phoneCtrl.text.trim() == '') {
      setState(() {
        emailErrorText = 'Please enter phone';
      });
      // shouldSubmit = false;
    }
    if (passwordCtrl.text.isEmpty) {
      setState(() {
        passwordErrorText = 'Password can not be empty';
      });
      // shouldSubmit = false;
    }

    if (passwordCtrl.text.isNotEmpty) {
      if (passwordCtrl.text.length < 8) {
        passwordErrorText = 'Your Password:';
        setState(() {
          passwordErrorText += '\n - Is not 8 characters long';
        });
        // shouldSubmit = false;
      }
    }

    if (shouldSubmit) {
      MjApiService apiService = MjApiService();
      dynamic payload = {
        "password": passwordCtrl.text,
        "phone": phoneCtrl.text,
      };
      log("payload here: ${payload}");
      try {
        await setSession(null); //////temporary
        showProgressDialog(context, MJConfig.please_wait, isDismissable: false);
        dynamic response = await apiService.postRequest(MJ_Apis.login, payload);
        if (response != null) {
          await setSession(response["response"]["token"]);
          showToast(response['message']);
          dynamic response2 =
              await apiService.getRequest(MJ_Apis.customer_info);
          if (response2 != null) {
            // print("userinfo responser${response2}");
            User user = User.fromJson(response2["response"]);
            context.read<UserProvider>().user = user;
            hideProgressDialog(context);
            Navigator.pushReplacementNamed(context, home_screen);
          } else {
            await setSession(null);
            hideProgressDialog(context);
            showToast(
                "Unable to fetch your data, please try consider trying again");
          }

          // Navigator.pushReplacementNamed(context, home_screen);
        } else {
          hideProgressDialog(context);
          showToast("Unable to fetch server response, please try later");
        }
      } catch (e) {
        hideProgressDialog(context);
        log("error in login screen: ${e}");
      } finally {
        // hideProgressDialog(context);
      }

      // User user = User.fromJson(response['response']["user"]);
      //   await context.read<UserProvider>().setUser(user);
      //     Navigator.pushReplacementNamed(context, home_screen);

    }
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
                errorText: emailErrorText,
                controller: phoneCtrl,
              ),
              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                controller: passwordCtrl,
                label: getString("auth__password"),
                icon: Icons.lock,
                errorText: passwordErrorText,
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
                    // Navigator.pushNamed(context, "home_screen");
                    submit();
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
                onPressed: () {},
                title: getString("auth__continue_fb"),
                imageIcon: "assets/icons/facebook_icon.png",
                color: facebookColor,
              ),
              SizedBox(
                height: 10,
              ),
              RoundedSocialMediaButtton(
                onPressed: () {},
                title: getString("auth__continue__google"),
                imageIcon: "assets/icons/google_icon.png",
                color: googleColor,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getString("auth__do_not_have_account"),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, "signup_screen");
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
