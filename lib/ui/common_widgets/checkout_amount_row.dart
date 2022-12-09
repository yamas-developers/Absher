import 'package:absher/helpers/public_methods.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

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
    return Row(
      children: [
        Text(
          "${title}",
          style: TextStyle(
              fontSize: 16, color: blackFontColor, fontWeight: FontWeight.w600),
        ),
        Spacer(),
        Text(
          getString("common__qar"),
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
}
