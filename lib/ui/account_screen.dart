import 'package:absher/helpers/session_helper.dart';
import 'package:absher/providers/user/user_provider.dart';
import 'package:absher/ui/common_widgets/build_slide_transition.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';
import 'package:dotted_border/dotted_border.dart';

// import 'package:absher/ui/components/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/mj_apis.dart';
import '../helpers/constants.dart';
import '../helpers/public_methods.dart';
import '../helpers/route_constants.dart';
import 'common_widgets/language_aware_widgets.dart';
import 'common_widgets/misc_widgets.dart';
import 'common_widgets/rounded_borders_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    int animationDuration = 0;
    Curve curve = Curves.easeInSine;
    return Scaffold(
      // backgroundColor: Color.fromRGBO(177, 50, 210, 1),

      body: Consumer<UserProvider>(builder: (context, userProvider, _) {
        return Stack(
          children: [
            Container(
              width: getWidth(context),
              height: getHeight(context),
              // color: Colors.grey,
            ),
            Container(
              height: getHeight(context),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: getWidth(context),
                          child: Image.asset(
                            "assets/images/cart_top_layout.png",
                            color: mainColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                          child: Center(
                            child: Image.asset(
                              'assets/images/app_logo.png',
                              color: Colors.white,
                              width: getSize(context, .22, 200, 60),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, points_balance_screen);
                          },
                          child: SizedBox(
                            width: 99,
                            height: 70,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    getString("profile__points"),
                                    style: TextStyle(
                                        color: mainColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 100,
                                    padding: EdgeInsets.fromLTRB(8, 4, 6, 4),
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  darkGreyColor.withOpacity(.3),
                                              offset: Offset(0, 1),
                                              blurRadius: 18,
                                              spreadRadius: 4),
                                        ],
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 3,
                                        )),
                                    child: Text(
                                      "0",
                                      textAlign: isLtr(context)
                                          ? TextAlign.start
                                          : TextAlign.end,
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: ReflectByLanguage(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: EdgeInsets.all(
                                          3,
                                        ),
                                        decoration: BoxDecoration(
                                            color: mainColor,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: darkGreyColor
                                                      .withOpacity(.3),
                                                  offset: Offset(0, 1),
                                                  blurRadius: 18,
                                                  spreadRadius: 4),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 3,
                                            )),
                                        child: Image.asset(
                                          "assets/icons/points_star.png",
                                          height: 29,
                                          width: 29,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 14,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: mainColor.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                width: getSize(context, .27, 100, 0),
                                height: getSize(context, .27, 100, 0),
                                child: ClipOval(
                                  child: ImageWithPlaceholder(
                                    width: 100,
                                    height: 100,
                                    image: userProvider.currentUser?.image,
                                    prefix: MJ_Apis.profileImgPath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: getWidth(context) * .65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${userProvider.currentUser?.fName ?? ""} ${userProvider.currentUser?.lName ?? ""}",
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, edit_profile_screen);
                                          },
                                          child: Image.asset(
                                            "assets/icons/edit_icon.png",
                                            height: 22,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Text(
                                      "SYDNEY, AUS 🇦🇺",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: darkGreyColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 13,
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${getString("profile__email")}: ",
                                            style: TextStyle(
                                              color: darkGreyColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: LangText(
                                            "${userProvider.currentUser?.email ?? ""}",
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: darkGreyColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${getString("profile__phone")}: ",
                                            style: TextStyle(
                                              color: darkGreyColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: LangText(
                                              "${userProvider.currentUser?.phone ?? ""}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: darkGreyColor,
                                                fontWeight: FontWeight.w500,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 13,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${getString("profile__address")}: ",
                                style: TextStyle(
                                    color: darkGreyColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DottedBorder(
                                  color: darkGreyColor,
                                  radius: Radius.circular(6),
                                  borderType: BorderType.RRect,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${"Address Not Available"}",
                                    style: TextStyle(
                                        color: darkGreyColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                getString("profile__update_address"),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RoundBordersButton(
                                  title: getString("profile__favorites"),
                                  onPressed: () {}),
                              SizedBox(
                                width: 16,
                              ),
                              RoundBordersButton(
                                  title: getString("profile__my_orders"),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "order_screen");
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BuildSlideTransition(
                            child: ProfilePoliciesItem(
                              title: getString("profile__about_us"),
                              onPressed: () {},
                            ),
                            animationDuration: animationDuration += 100,
                            curve: curve,
                          ),
                          Divider(thickness: 1),
                          BuildSlideTransition(
                            child: ProfilePoliciesItem(
                                title: getString("profile__language"),
                                onPressed: () async {
                                  await Navigator.pushNamed(
                                      context, language_screen,
                                      arguments: {"isInitialScreen": false});
                                  setState(() {});
                                }),
                            animationDuration: animationDuration += 100,
                            curve: curve,
                          ),
                          Divider(thickness: 1),
                          BuildSlideTransition(
                            child: ProfilePoliciesItem(
                                title: getString("profile__coupon"),
                                onPressed: () {}),
                            animationDuration: animationDuration += 100,
                            curve: curve,
                          ),
                          Divider(thickness: 1),
                          BuildSlideTransition(
                            child: ProfilePoliciesItem(
                                title: getString("profile__help_&_support"),
                                onPressed: () {}),
                            animationDuration: animationDuration += 100,
                            curve: curve,
                          ),
                          Divider(thickness: 1),
                          BuildSlideTransition(
                            child: ProfilePoliciesItem(
                                title: getString("profile__privacy_policy"),
                                onPressed: () {}),
                            animationDuration: animationDuration += 100,
                            curve: curve,
                          ),
                          Divider(thickness: 1),
                          BuildSlideTransition(
                            child: ProfilePoliciesItem(
                                title: getString("profile__terms_n_condtition"),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, terms_and_condition_screen);
                                }),
                            animationDuration: animationDuration += 100,
                            curve: curve,
                          ),
                          Divider(thickness: 1),
                          BuildSlideTransition(
                            child: ProfilePoliciesItem(
                                title: getString("profile__logout"),
                                onPressed: () {
                                  context.read<UserProvider>().user = null;
                                  context.read<UserProvider>().token = null;
                                  setSession(null);
                                  showToast("You have been logout");
                                  Navigator.pushReplacementNamed(
                                      context, login_screen);
                                }),
                            animationDuration: animationDuration += 100,
                            curve: curve,
                          ),
                          Divider(thickness: 1),
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
          ],
        );
      }),
    );
  }
}

class ProfilePoliciesItem extends StatelessWidget {
  final String title;
  final onPressed;

  const ProfilePoliciesItem(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$title",
              style: const TextStyle(
                  fontSize: 18,
                  color: darkGreyColor,
                  fontWeight: FontWeight.w500),
            ),
            ReflectByLanguage(
              child: Image.asset(
                "assets/icons/forward_arrow.png",
                color: darkGreyColor,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
