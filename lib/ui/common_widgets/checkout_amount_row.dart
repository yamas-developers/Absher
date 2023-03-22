import 'package:absher/helpers/public_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../providers/settings/settings_provider.dart';

class CheckoutAmountRow extends StatelessWidget {
  const CheckoutAmountRow({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return  Row(
          children: [
            Text(
              "${title}",
              style: TextStyle(
                  fontSize: 16, color: blackFontColor, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Text(
              "${settingsProvider.zone?.zoneData?.first.currency_symbol}",
              style: TextStyle(
                  fontSize: 15, color: mainColor, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              "${amount}",
              style: TextStyle(
                  fontSize: 18, color: mainColor, fontWeight: FontWeight.w600),
            ),
          ],
        );
      }
    );
  }
}
