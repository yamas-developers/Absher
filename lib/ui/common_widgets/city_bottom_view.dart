import 'package:absher/ui/common_widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';

class CityBottomView extends StatefulWidget {
  const CityBottomView({Key? key}) : super(key: key);

  @override
  State<CityBottomView> createState() => _CityBottomViewState();
}

class _CityBottomViewState extends State<CityBottomView> {
  List cities = [{'city': 'Jakarta','country': 'Japan'}, {'city': 'Manila','country': 'Philippines'},
    {'city': 'Beijing','country': 'China'},
    {'city': 'New York','country': 'United States'},
    {'city': 'Mexico','country': 'Mexico'},
    {'city': 'Bangkok','country': 'Thailand'},
    {'city': 'Istanbul','country': 'Turkey'},
    {'city': 'Lagos','country': 'Nigeria'},
    {'city': 'Paris','country': 'France'},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context) * 0.82,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  getString("home__select_city"),
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ).marginOnly(left: 16),
                TouchableOpacity(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/icons/cross_rounded_filled.png",
                    color: mainColor,
                    height: 30,
                  ),
                ),
                // sbw(10)
              ],
            ),
            sbh(20),
            ...List.generate(cities.length, (index) =>  ListTile(
              // leading: Icon(Icons.gps_fixed),
              title: Text('${cities[index]['city']}'),
              subtitle: Text("${cities[index]['country']}"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),),
          ],
        ),
      ),
    );
  }
}
