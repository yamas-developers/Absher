import 'dart:ui';

import 'package:absher/helpers/constants.dart';
import 'package:absher/helpers/public_methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/route_constants.dart';
import '../../providers/cart/cart_provider.dart';
import '../../providers/settings/settings_provider.dart';

class NoServiceAreaWidget extends StatelessWidget {
  const NoServiceAreaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Image.asset("assets/gifs/restaurant.gif"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "We are currently not operating in your area but we hope that soon we will!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.2, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}

class NoNetworkWidget extends StatelessWidget {
  const NoNetworkWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/gifs/wifi.gif",
            height: getHeight(context) * 0.2,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "Please make sure you are connected to the internet",
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.2, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                getSettingsData(context: context, showToast: true);
              },
              child: Text("Retry"))
        ],
      ),
    );
  }
}

class NoLocationPermissionsWidget extends StatelessWidget {
  const NoLocationPermissionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/gifs/location_map.gif",
            height: getHeight(context) * 0.3,
            width: getWidth(context) * 0.8,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "Please provide the location permission to use the app",
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.2, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                getSettingsData(context: context, showToast: true);
              },
              child: Text("Give Permission"))
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/gifs/location.gif",
            height: getHeight(context) * 0.2,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "Fetching data based on your location",
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.2, fontWeight: FontWeight.w600, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  EmptyWidget({Key? key, this.title}) : super(key: key);
  String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/gifs/empty.gif",
            height: getHeight(context) * 0.3,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              title ?? "No Data",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: darkGreyColor,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/gifs/loading.gif",
        height: 70,
        color: mainColor,
        fit: BoxFit.contain,
      ),
    );
  }
}

class ImageWithPlaceholder extends StatelessWidget {
  const ImageWithPlaceholder({
    Key? key,
    required this.image,
    required this.prefix,
    this.width = 80,
    this.height = 80,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String? image;
  final String? prefix;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return image != null && image != ""
        ? CachedNetworkImage(
            imageUrl: "$prefix$image",
            height: height,
            width: width,
            fit: fit,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    // colorFilter:
                    //     ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                ),
              ),
            ),
            placeholder: (context, url) => Stack(
              children: <Widget>[
                // Show a blurred version of the image
                Image.network("$prefix$image"),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.white.withOpacity(0),
                  ),
                ),
                // Center(
                //   child: CircularProgressIndicator(),
                // ),
              ],
            ),
            // errorWidget: (context, url, error) => Icon(Icons.error),
            errorWidget: (context, url, error) => Image.asset(
              PLACEHOLDER_IAMGE_PATH,
              height: height,
              width: width,
              fit: fit,)
            )
        : Image.asset(
            PLACEHOLDER_IAMGE_PATH,
            height: height,
            width: width,
            fit: fit,
          );
  }
}

class BottomCartWidget extends StatelessWidget {
  const BottomCartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(builder: (context, settingsProvider, _) {
      return Consumer<CartProvider>(builder: (context, cartProvider, _) {
        return GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, cart_screen);
          },
          child: Container(
              width: getWidth(context) * 0.94,
              height: 50,
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        // height: ,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),

                            // borderRadius: BorderRadius.circular(50),
                            shape: BoxShape.circle),
                        child: Text(
                          "${cartProvider.list.length}",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    Text(
                      "Click to view cart",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      "${settingsProvider.zone?.zoneData?.first.currency_symbol} ${cartProvider.cartTotal}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ])),
        );
      });
    });
  }
}
