import 'dart:math';

import 'package:flutter/material.dart';

import '../../helpers/public_methods.dart';

class ReflectByLanguage extends StatelessWidget {
  const ReflectByLanguage({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(Directionality.of(context).toString() == 'TextDirection.rtl' ? pi : 0),
        child: child
    );
  }
}

class LangText extends StatelessWidget {
  const LangText(
      this.value, {
        Key? key,
        this.maxLines,
        this.style,
      }) : super(key: key);
  final TextStyle? style;
  final int? maxLines;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${value}',
      // maxLines: 2,
      textDirection: isLtr(context) ? TextDirection.ltr : TextDirection.rtl,
      textAlign: isLtr(context) ? TextAlign.end : TextAlign.start,
      maxLines: maxLines,
      style: style,
    );
  }
}
