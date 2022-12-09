import 'package:absher/ui/common_widgets/city_bottom_view.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import 'location_bottom_view.dart';

void modalBottomSheetLocation(context) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      context: context,
      backgroundColor: mainColorLightest,
      isScrollControlled: true,
      builder: (context) {
        TextStyle _sheetItemStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
        return LocationBottomView();
      });
}

void modalBottomSheetCity(context) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      context: context,
      backgroundColor: mainColorLightest,
      isScrollControlled: true,
      builder: (context) {
        TextStyle _sheetItemStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
        return CityBottomView();
      });
}
