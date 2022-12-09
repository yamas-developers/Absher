import 'package:absher/helpers/route_constants.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../common_widgets/rounded_center_button.dart';
import '../common_widgets/rounded_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                label: getString("auth__full_name"),
                icon: Icons.person,
              ),
              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                label: getString("auth__email_address"),
                icon: Icons.alternate_email,
              ),
              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                label: getString("auth__phone"),
                icon: Icons.phone,
              ),
              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                label: getString("language__address"),
                icon: Icons.pin_drop_outlined,
              ),
              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                label: getString("auth__password"),
                icon: Icons.lock,
              ),
              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                label: getString("auth__confirm_password"),
                icon: Icons.lock,
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
                      onTap: (){
                        Navigator.pushNamed(context, terms_and_condition_screen);
                      },
                      child: Text(
                        getString("auth__sign_up_agree_terms"),
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                            letterSpacing: 0.3,
                            color: darkGreyColor, fontWeight: FontWeight.w500),
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
                    Navigator.pushNamed(context, otp_screen);

                  },
                  title: getString("auth__sign_up")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getString("auth__already_have_account"),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
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
