import 'package:absher/helpers/public_methods.dart';
import 'package:absher/models/misc_models.dart';
import 'package:absher/providers/settings/settings_provider.dart';
import 'package:absher/ui/common_widgets/rounded_center_button.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../helpers/route_constants.dart';
import '../../providers/business/express_provider.dart';
import '../common_widgets/language_aware_widgets.dart';

class ExpressDeliveryScreen extends StatefulWidget {
  const ExpressDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<ExpressDeliveryScreen> createState() => _ExpressDeliveryScreenState();
}

class _ExpressDeliveryScreenState extends State<ExpressDeliveryScreen> {
  String pickupAddress = "";
  String deliveryAddress = "";

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return Consumer<ExpressProvider>(builder: (context, provider, _) {
            return SingleChildScrollView(
              // height: getHeight(context),
              child: Column(
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
                                "${getString('app_name')} ${getString('express__express')}",
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
                  Center(
                    child: Text(
                      getString('express__from_here_there'),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      // SizedBox(width: 20,),
                      Column(
                        children: [
                          CircularPoint(),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            height: 30,
                            width: 3,
                            decoration: BoxDecoration(color: Colors.black),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          CircularPoint(),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                LocationResult result = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) =>
                                            PlacePicker(GOOGLE_API_KEY)));
                                ExpressAddress address = ExpressAddress(
                                    address: result.formattedAddress,
                                    lat: result.latLng!.latitude,
                                    lng: result.latLng!.longitude);
                                if(provider.destinationAddress?.address == address.address){
                                  showToast("Pickup and Delivery location can be same");
                                  return;
                                }
                                provider.pickupAddress = address;

                                // street1.text = result.name.toString();
                                // landmark1.text = result.subLocalityLevel1!.name == null
                                //     ? result.subLocalityLevel2!.name.toString()
                                //     : result.subLocalityLevel1!.name.toString();
                                // city1.text = result.city!.name.toString();
                                // cutries1.text = result.country!.name.toString();
                                // zipcode1.text = result.postalCode.toString();
                                // lat = result.latLng!.latitude;
                                // long = result.latLng!.longitude;

                                // setState(() {});
                              },
                              child: DeliveryAddressItem(
                                title: provider.pickupAddress?.address ??
                                    getString("express__enter_pickup_address"),
                                color: provider.pickupAddress?.address == null
                                    ? lightGreyFontColor
                                    : Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                LocationResult result = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) =>
                                            PlacePicker(GOOGLE_API_KEY)));

                                ExpressAddress address = ExpressAddress(
                                    address: result.formattedAddress,
                                    lat: result.latLng!.latitude,
                                    lng: result.latLng!.longitude);
                                if(provider.pickupAddress?.address == address.address){
                                  showToast("Pickup and Delivery location can be same");
                                  return;
                                }

                                provider.destinationAddress = address;
                              },
                              child: DeliveryAddressItem(
                                title: provider.destinationAddress?.address ??
                                    getString("express__enter_delivery_address"),
                                color: provider.destinationAddress?.address == null
                                    ? lightGreyFontColor
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/absher_express.png",
                      height: getSize(context, 0.3, 250, 200),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  BulletList([
                    getString('express__maximum_size'),
                    getString('express__maximum_weight'),
                    '${getString('app_name')} ${getString('express__does_not_provide_package')}'
                  ]),
                  Divider(),
                  if (provider.pickupAddress != null && provider.destinationAddress != null)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${settingsProvider.zone?.zoneData?.first.currency_symbol}',
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
                        if(false)
                        Center(
                          child: Text(
                            "${getString('express__pick_up_at')} 2:30 pm | ${getString('express__delivery_at')} 9:30 pm",
                            style: TextStyle(
                                fontSize: 13,
                                color: mediumGreyColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                            child: RoundedCenterButtton(
                          title: getString("express__enter_details"),
                          onPressed: () {
                            Navigator.pushNamed(context, express_details_screen);
                          },
                        )),
                      ],
                    )
                  else
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                      child: Text(
                        getString("express__select_locations"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            );
          });
        }
      ),
      // if(isPortrait(context)) Spacer(),
      // SizedBox(
      //   height: getHeight(context) * .25,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //
      //     ],
      //   ),
      // ),
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: isPortrait(context)
            ? ListView(
                children: children,
              )
            : ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
      ),
    );
  }
}

class DeliveryAddressItem extends StatelessWidget {
  const DeliveryAddressItem({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
      width: getWidth(context),
      decoration: BoxDecoration(
        color: lightGreyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "${title}",
              style: TextStyle(color: color),
            ),
          ),
          ReflectByLanguage(
            child: Image.asset(
              "assets/icons/forward_arrow.png",
              color: darkGreyColor,
              height: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class CircularPoint extends StatelessWidget {
  const CircularPoint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.black, width: 4)),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> strings;

  BulletList(this.strings);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(4, 15, 4, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022',
                style: TextStyle(
                  fontSize: 20,
                  height: 1.2,
                  // color: lightGreyFontColor
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    str,
                    textAlign: getTextAlignStart(context),
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      // color: lightGreyFontColor,
                      height: 1.55,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
