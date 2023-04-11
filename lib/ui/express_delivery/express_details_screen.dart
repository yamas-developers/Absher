import 'package:absher/helpers/public_methods.dart';
import 'package:absher/providers/user/user_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../providers/business/express_provider.dart';
import '../../providers/settings/settings_provider.dart';
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
  List categories = [
    "Documents",
    "Food",
    "Personal Stuff",
    "Clothes",
    "Sensitive Items"
  ];
  String selected = "";

  TextEditingController pickupNameController = TextEditingController();
  TextEditingController dropoffNameController = TextEditingController();
  TextEditingController pickupAddressController = TextEditingController();
  TextEditingController dropoffAddressController = TextEditingController();
  TextEditingController pickupPhoneController = TextEditingController();
  TextEditingController dropoffPhoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  placeOrder() async {
    UserProvider userProvider = context.read<UserProvider>();
    ExpressProvider expressProvider = context.read<ExpressProvider>();

    if (!userProvider.isLogin || userProvider.currentUser == null) {
      showToast("Please login to proceed");
      return;
    }
    if (pickupNameController.text.trim().isEmpty ||
        pickupPhoneController.text.trim().isEmpty ||
        pickupAddressController.text.trim().isEmpty) {
      showToast("Please provide all pickup details");
      return;
    }
    if (dropoffNameController.text.trim().isEmpty ||
        dropoffPhoneController.text.trim().isEmpty ||
        dropoffAddressController.text.trim().isEmpty) {
      showToast("Please provide all pickup details");
      return;
    }
    if (descriptionController.text.trim().isEmpty) {
      showToast("Please provide description");
      return;
    }
    if (expressProvider.catId == null) {
      showToast("Please select category");
      return;
    }

    Map<String, dynamic> payload = {
      "user_id": userProvider.currentUser?.id,
      "pickup_name": pickupNameController.text.trim(),
      "pickup_phone": pickupPhoneController.text.trim(),
      "pickup_address_details": pickupAddressController.text.trim(),
      "dropoff_name": dropoffNameController.text.trim(),
      "dropoff_phone": dropoffPhoneController.text.trim(),
      "dropoff_address_details": dropoffAddressController.text.trim(),
      "pickup_address": expressProvider.pickupAddress?.address,
      "dropoff_address": expressProvider.destinationAddress?.address,
      "price": 30.0.toString(),
      "pickup_lat": expressProvider.pickupAddress?.lat.toString(),
      "pickup_lng": expressProvider.pickupAddress?.lng.toString(),
      "dropoff_lat": expressProvider.destinationAddress?.lat.toString(),
      "dropoff_lng": expressProvider.destinationAddress?.lng.toString(),
      "description": descriptionController.text.trim().toString(),
      "category_id": expressProvider.catId.toString()
    };
    showProgressDialog(context, "Placing Order");
    bool flag = await expressProvider.placeOrder(payload);
    hideProgressDialog(context);
    if (flag) Navigator.pop(context);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<ExpressProvider>().fetchCategories();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
      return  Consumer<ExpressProvider>(builder: (context, provider, _) {
            return SingleChildScrollView(
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
                    ExpressDetailItem(
                      address: provider.pickupAddress?.address ?? '',
                      title: getString("express__pick_up"),
                      nameCtrl: pickupNameController,
                      addressCtrl: pickupAddressController,
                      phoneCtrl: pickupPhoneController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ExpressDetailItem(
                      address: provider.destinationAddress?.address ?? '',
                      title: getString("express__delivery"),
                      nameCtrl: dropoffNameController,
                      addressCtrl: dropoffAddressController,
                      phoneCtrl: dropoffPhoneController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      getString('express__describe_item'),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedTextFieldFilled(
                      label: getString("express__tell_more"),
                      maxLines: 2,
                      controller: descriptionController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if ((provider.expressCategories?.length ?? 0) > 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...List.generate(
                              provider.expressCategories?.length ?? 0,
                              (i) => GestureDetector(
                                onTap: () {
                                  provider.catId =
                                      provider.expressCategories![i].id;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: provider.expressCategories![i].id ==
                                                provider.catId
                                            ? mainColor
                                            : mainColorLight.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                        "${provider.expressCategories![i].name}",
                                        style: TextStyle(
                                            color:
                                                provider.expressCategories![i].id ==
                                                        provider.catId
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
                              "${settingsProvider.zone?.zoneData?.first.currency?.currencySymbol??'--'}",
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
                        // Text(
                        //   "${getString(
                        //       'express__pick_up_at')} 2:30 pm | ${getString(
                        //       'express__delivery_at')} 9:30 pm",
                        //   style: TextStyle(
                        //       fontSize: 13,
                        //       color: mediumGreyColor,
                        //       fontWeight: FontWeight.w400),
                        // ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        RoundedCenterButtton(
                          title: getString("Place Order"),
                          onPressed: () {
                            placeOrder();
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: getString(
                                  'express__clicking_checkout_agree_terms'),
                              style: TextStyle(
                                color: mediumGreyColor,
                                fontSize: 12,
                                // fontWeight: FontWeight.bold
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: getString('express__prohibited_items'),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // open desired screen
                                      }),
                                TextSpan(
                                    text: ' ${getString('common__and')} ',
                                    style: TextStyle(
                                      color: mediumGreyColor,
                                      fontSize: 12,
                                      // fontWeight: FontWeight.bold
                                    )),
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
                                      }),
                              ]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            );
          });
        }
      ),
    );
  }
}

class ExpressDetailItem extends StatelessWidget {
  ExpressDetailItem({
    Key? key,
    required this.address,
    required this.title,
    this.nameCtrl,
    this.phoneCtrl,
    this.addressCtrl,
  }) : super(key: key);

  final String address;
  final String title;
  final TextEditingController? nameCtrl;
  final TextEditingController? phoneCtrl;
  final TextEditingController? addressCtrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${title}',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          '${address}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
                child: RoundedTextFieldFilled(
                    label: getString("express__name"), controller: nameCtrl)),
            SizedBox(
              width: 6,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              decoration: BoxDecoration(
                  color: lightestGreyColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.perm_contact_calendar_sharp,
                color: mediumGreyColor.withOpacity(0.8),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        RoundedTextFieldFilled(
          label: getString("express__phone"),
          controller: phoneCtrl,
        ),
        SizedBox(
          height: 10,
        ),
        RoundedTextFieldFilled(
            label: getString("express__address_details"),
            maxLines: 3,
            controller: addressCtrl),
      ],
    );
  }
}
