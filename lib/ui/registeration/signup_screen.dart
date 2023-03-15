import 'dart:developer';

import 'package:absher/helpers/route_constants.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';
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

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  bool isLoading = false;
  bool checkBoxValue = false;
  bool customerSelected = true;
  bool shouldSubmit = true;

  String firstNameErrorText = '';
  String lastNameErrorText = '';
  String emailErrorText = '';
  String phoneErrorText = '';
  String passwordErrorText = '';
  String confirmPasswordErrorText = '';

  // String phonePrefixText = "+1";
  String completePhoneNumber = "";

  submit() async {
    setState(() {
      completePhoneNumber = /*phonePrefixText + */ phoneCtrl.text;
      firstNameErrorText = '';
      emailErrorText = '';
      lastNameErrorText = '';
      phoneErrorText = '';
      passwordErrorText = '';
      confirmPasswordErrorText = '';
    });

    shouldSubmit = true;

    print('phoneNumber: ${completePhoneNumber}');

    if (!RegExp(r"^[A-Za-z' ]{3,}$").hasMatch(firstNameCtrl.text)) {
      if (firstNameCtrl.text.isEmpty) {
        setState(() {
          firstNameErrorText = 'Please enter first name';
        });
      } else {
        setState(() {
          firstNameErrorText = 'First name is not valid';
        });
      }
      shouldSubmit = false;
    }
    if (!RegExp(r"^[A-Za-z' ]{3,}$").hasMatch(lastNameCtrl.text)) {
      if (lastNameCtrl.text.isEmpty) {
        setState(() {
          lastNameErrorText = 'Please enter last name';
        });
      } else {
        setState(() {
          lastNameErrorText = 'Last name is not valid';
        });
      }
      shouldSubmit = false;
    }

    if (!(RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailCtrl.text))) {
      if (emailCtrl.text.isEmpty) {
        emailErrorText = 'Please enter email';
      } else {
        setState(() {
          emailErrorText = 'Email is not valid';
        });
      }

      shouldSubmit = false;
    }
    // if (!RegExp(r'((\+[0-9]{1,3}))[ -]?3([0-9]{2})[ -]?[0-9]{4}[ -]?[0-9]{3}$')
    if (!RegExp(r'^[+0-9]{10,13}$').hasMatch(phoneCtrl.text)) {
      if (phoneCtrl.text.isEmpty) {
        setState(() {
          phoneErrorText = 'Please enter phone';
        });
      } else {
        setState(() {
          phoneErrorText = 'Please enter valid phone';
        });
      }
      shouldSubmit = false;
    }

    if (passwordCtrl.text.isEmpty) {
      setState(() {
        passwordErrorText = 'Password can not be empty';
      });
      shouldSubmit = false;
    }
    if (passwordCtrl.text.isNotEmpty) {
      if (passwordCtrl.text.length < 8) {
        passwordErrorText = 'Password:';
        setState(() {
          passwordErrorText += '\n - Must be at least 8 characters long';
        });
        shouldSubmit = false;
      }
      if (RegExp(r"[ ]+").hasMatch(passwordCtrl.text)) {
        passwordErrorText == '' ? 'Password:' : '';
        setState(() {
          passwordErrorText += '\n - Must not contain white spaces';
        });
        shouldSubmit = false;
      }
      if (!(RegExp(r"[a-zA-Z]+[A-Za-z]+").hasMatch(passwordCtrl.text))) {
        passwordErrorText == '' ? 'Password:' : '';
        setState(() {
          passwordErrorText +=
              '\n - Must contain upper and lower case characters';
        });
        shouldSubmit = false;
      }
      if (!(RegExp(r"[.!#$%&'*@+-/=?^_`{|}~]+").hasMatch(passwordCtrl.text))) {
        passwordErrorText == '' ? 'Password:' : '';
        print('in symbol if');
        setState(() {
          passwordErrorText += '\n - Must contain at least one special symbol';
        });
        shouldSubmit = false;
      }
    }
    if (confirmPasswordCtrl.text.isEmpty) {
      setState(() {
        confirmPasswordErrorText = 'Please confirm your password';
      });
      shouldSubmit = false;
    }
    if (passwordCtrl.text != confirmPasswordCtrl.text) {
      setState(() {
        confirmPasswordErrorText = 'Password doesn\'t match';
      });
      shouldSubmit = false;
    }

    if (shouldSubmit) {
      if (!checkBoxValue) {
        showToast(
            "Before proceeding please verify that you have read the terms and conditions");
        return;
      }
      MjApiService apiService = MjApiService();
      dynamic payload = {
        "f_name": firstNameCtrl.text,
        "l_name": lastNameCtrl.text,
        "email": emailCtrl.text,
        "phone": completePhoneNumber,
        "password": passwordCtrl.text
      };
      try {
        await setSession(null); //////temporary
        showProgressDialog(context, MJConfig.please_wait, isDismissable: false);
        dynamic response =
            await apiService.postRequest(MJ_Apis.signup, payload);
        if (response != null) {
          await setSession(response["response"]["token"]);
          showToast(response['message']);
          UserProvider userProvider = context.read<UserProvider>();
          await userProvider.fetchUser();
          hideProgressDialog(context);
          if (userProvider.isLogin)
            Navigator.pushNamedAndRemoveUntil(
                context, home_screen, (val) => false);
          else {
            Navigator.pushReplacementNamed(context, login_screen);
          }
        } else {
          hideProgressDialog(context);
          // showToast("Unable to fetch server response, please try later");
        }
      } catch (e) {
        hideProgressDialog(context);
        log("error in signup screen: ${e}");
      } finally {}
    }
  }

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
                getString("auth__sign_up"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: mediumGreyFontColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              RoundedTextField(
                label: getString("auth__first_name"),
                icon: Icons.person,
                controller: firstNameCtrl,
                errorText: firstNameErrorText,
              ),
              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                label: getString("auth__last_name"),
                icon: Icons.person,
                controller: lastNameCtrl,
                errorText: lastNameErrorText,
              ),
              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                label: getString("auth__email_address"),
                icon: Icons.alternate_email,
                controller: emailCtrl,
                errorText: emailErrorText,
              ),
              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                label: getString("auth__phone"),
                icon: Icons.phone,
                controller: phoneCtrl,
                errorText: phoneErrorText,
              ),

              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                label: getString("auth__password"),
                icon: Icons.lock,
                controller: passwordCtrl,
                errorText: passwordErrorText,
              ),
              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                label: getString("auth__confirm_password"),
                icon: Icons.lock,
                controller: confirmPasswordCtrl,
                errorText: confirmPasswordErrorText,
              ),
              SizedBox(
                height: 2,
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
                  Expanded(
                    child: TouchableOpacity(
                      onTap: () {
                        Navigator.pushNamed(
                            context, terms_and_condition_screen);
                      },
                      child: Text(
                        getString("auth__sign_up_agree_terms"),
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            letterSpacing: 0.3,
                            color: darkGreyColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 26,
                  ),
                ],
              ),
              RoundedCenterButtton(
                  onPressed: () {
                    // Navigator.pushNamed(context, otp_screen);
                    submit();
                  },
                  title: getString("auth__sign_up")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getString("auth__already_have_account"),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "login_screen");
                      },
                      child: Text(
                        getString("auth__login"),
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
