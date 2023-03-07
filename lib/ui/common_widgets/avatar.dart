import 'package:absher/helpers/constants.dart';
import 'package:flutter/material.dart';

class RoundedAvatar extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final double border;
  final String assetPath;
  RoundedAvatar({
    Key? key,
    this.height = 50.0,
    this.width = 50.0,
    this.border = 2.0,
    required this.assetPath,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: border, color: color),
            borderRadius: BorderRadius.circular(40)),
        // radius: 25,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              assetPath,
              fit: BoxFit.cover,
              width: width,
              height: height,
            ),
          ),
        ));
  }
}
class RoundedNetworkAvatar extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final double border;
  final String? url;
  final String? prefix;
  final BoxFit? fit;

  RoundedNetworkAvatar({
    Key? key,
    this.height = 50.0,
    this.width = 50.0,
    this.border = 2.0,
    required this.url,
    this.fit = BoxFit.cover,
    this.color = Colors.white, this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: border, color: color),
            borderRadius: BorderRadius.circular(40)),
        // radius: 25,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: url != null ? Image.network(
              "${prefix!=null?"$prefix/":""}$url",
              fit: fit,
              width: width,
              height: height,
            ) : Image.asset(
            PLACEHOLDER_IAMGE_PATH,
            height: height,
            width: width,
            fit: fit,
          ),
          ),
        ));
  }
}
