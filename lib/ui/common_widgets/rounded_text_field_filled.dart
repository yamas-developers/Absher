import 'package:absher/helpers/constants.dart';
import 'package:absher/helpers/public_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedTextFieldFilled extends StatelessWidget {
  RoundedTextFieldFilled({
    Key? key,
    required this.label,
    this.controller,
    this.errorText = '',
    this.prefixText = '',
    this.hintText = '',
    this.inputType = TextInputType.text,
    this.showNonNumericDigits = true,
    this.widthtoMinus = 0,
    this.maxLines = 1,
  }) : super(key: key);
  final String label;
  TextEditingController? controller;
  String errorText;
  String prefixText;
  String hintText;
  TextInputType inputType;
  bool showNonNumericDigits;
  double widthtoMinus;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context)- widthtoMinus,
      child: TextField(
        maxLines: maxLines,
        keyboardType: inputType,
        controller: controller,
        inputFormatters: showNonNumericDigits ? null : <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        decoration: InputDecoration(
          prefixText:  (prefixText != null || prefixText != '') ? prefixText : null,
          hintText: hintText,
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
          floatingLabelStyle: TextStyle(
            fontSize: 13,
            color: Theme.of(context).accentColor,
          ),

          // errorText: (errorText != null || errorText != '') ? errorText : null,
          // errorMaxLines: 1,
          border:
          // InputBorder.none,
          OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
          // errorStyle: TextStyle(
          //   fontSize: 11,
          //   color: Theme.of(context).errorColor,
          // ),
          // focusedErrorBorder:
          //     OutlineInputBorder(borderSide: BorderSide(color: mainColor), borderRadius: BorderRadius.circular(10)),
fillColor: lightestGreyColor,
          filled: true,

          // borderRadius: BorderRadius.circular(10)
          // borderRadius: BorderRadius.circular(10)
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}
