import 'package:absher/providers/location/location_provider.dart';
import 'package:absher/providers/settings/settings_provider.dart';
import 'package:absher/ui/common_widgets/comon.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../helpers/route_constants.dart';

class LocationBottomView extends StatefulWidget {
  const LocationBottomView({Key? key}) : super(key: key);

  @override
  State<LocationBottomView> createState() => _LocationBottomViewState();
}

class _LocationBottomViewState extends State<LocationBottomView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, provider, _) {
        return Container(
          // height: getHeight(context) * 0.45,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 3,
                    color: greyDividerColor,
                  ),
                ],
              ),
              sbh(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getString("home__location"),
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                  ).marginOnly(left: 16),
                  TouchableOpacity(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/icons/cross_rounded_filled.png",
                      color: mainColor,
                      height: 26,
                    ),
                  ),
                  // sbw(10)
                ],
              ),
              sbh(20),
              ListTile(
                leading: Icon(Icons.gps_fixed),
                title: Text(getString('home__use_current_location')),
                onTap: ()  {
                  Navigator.pushNamed(context, map_view);
                  // Navigator.pop(context);
                },
              ),
              ...List.generate(provider.addressDetails.length, (index) {
                bool selected = provider.addressDetails[index]["address"] == provider.address;
                return ListTile(
                leading: Icon(Icons.home_work_outlined,color: selected ? mainColor: null),
                title: Text(provider.addressDetails[index]["address"]?? "No Location Available", maxLines: 2,style: TextStyle(fontSize: 13, color: selected ? mainColor: null),),
                subtitle: Text(provider.addressDetails[index]["address"]?? "City: N/A", style: TextStyle(color: selected ? mainColor: null),),
                onTap: () async {
                  Navigator.pop(context);
                  provider.setCurrentAddress(provider.addressDetails[index]);

                  if (provider.currentLocation != null) {
                    await context.read<SettingsProvider>().getSettings(provider.currentLocation);
                  }
                },
              );
              }),
              ListTile(
                leading: Icon(Icons.add_circle_outline),
                title: Text(getString('home__add_new_address')),
                onTap: () {
                  Navigator.pushNamed(context, map_view);
                },
              ),
              SizedBox(height: 20,)

              // ListTile(
              //   leading: Icon(Icons.location_city_outlined),
              //   title: Text(getString('home__select_city')),
              //   onTap: () {
              //     Navigator.pop(context);
              //     modalBottomSheetCity(context);
              //   },
              // ),

            ],
          ),
        );
      }
    );
  }
}
