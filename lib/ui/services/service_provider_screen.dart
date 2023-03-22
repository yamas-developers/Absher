import 'package:absher/helpers/public_methods.dart';
import 'package:flutter/material.dart';

import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../../models/service.dart';
import '../common_widgets/misc_widgets.dart';

class ServiceProviderScreen extends StatefulWidget {
  const ServiceProviderScreen({Key? key}) : super(key: key);

  @override
  State<ServiceProviderScreen> createState() => _ServiceProviderScreenState();
}

class _ServiceProviderScreenState extends State<ServiceProviderScreen> {
  AbsherService? service;

  // String service = "Other Service";
  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) return;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      setState(() {
        service = args["service"];
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(6, 10, 18, 0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/icons/back_arrow_icon.png",
                            width: 22,
                            height: 22,
                          ),
                        ),
                        SizedBox(
                          width: 10,
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
                          "Service Provider",
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
            SizedBox(
              height: 20,
            ),
            Hero(
                tag: ValueKey("${service}"),
                child: ImageWithPlaceholder(
                  fit: BoxFit.fill,
                  image: service?.image,
                  prefix: MJ_Apis.serviceImgPath,
                  height: 200,
                    width: getWidth(context),
                ),),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                "${service?.name??"Name Unavailable"}",
                style: TextStyle(
                    color: mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              margin: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                  color: mainColorLightest,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/contact_person_icon.png",
                    height: 42,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      "Order Service",
                      style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                  Image.asset(
                    "assets/icons/whatsapp_icon.png",
                    height: 42,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(color: mainColor, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${service?.description??"Description Unavailable"}",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
