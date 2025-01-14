import 'package:absher/api/mj_apis.dart';
import 'package:absher/helpers/constants.dart';
import 'package:absher/ui/common_widgets/build_slide_transition.dart';
import 'package:absher/ui/common_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/public_methods.dart';
import '../../helpers/route_constants.dart';
import '../../models/service.dart';
import '../../providers/business/service_provider.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  List services = [
    "Pavement",
    "Carpenter",
    "Other",
    "Plumbing",
    "Electrician",
    "Wall Painter",
    "Design"
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ServiceProvider>(context, listen: false).reset();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int animationDuration = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
      ),
      body: Consumer<ServiceProvider>(builder: (context, provider, _) {
        return Column(
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
                    child: Container(
                      // height: 39,
                      padding: EdgeInsets.fromLTRB(4, 9, 4, 9),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.15),
                              blurRadius: 6,
                              spreadRadius: .1,
                            ),
                          ]),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Image.asset(
                            "assets/icons/search_icon.png",
                            width: 20,
                            height: 20,
                            color: mainColor,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Flexible(
                              child: Text(
                            "Search",
                            style: TextStyle(
                                fontSize: 16,
                                color: mainColor,
                                fontWeight: FontWeight.w500),
                          )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, notifications_screen);
                          },
                          child: Image.asset(
                            "assets/icons/notification.png",
                            width: 24,
                            color: mainColor,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "All Services",
                // textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Expanded(
              child: ListView(
                children: [
                  if (provider.loading && provider.list.isEmpty)
                    LoadingIndicator(),
                  ...List.generate(provider.list.length, (i) {
                    if (i != 0) {
                      animationDuration =
                          ((animationDuration += 200) / i).round() + 200;
                    } else {
                      animationDuration = 500;
                    }
                    // animationDuration = 300;

                    return BuildSlideTransition(
                      animationDuration: animationDuration,
                      curve: Curves.easeIn,
                      child: ServiceItem(service: provider.list[i]),
                    );
                  })
                ],
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
          ],
        );
      }),
    );
  }
}

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    Key? key,
    required this.service,
  }) : super(key: key);

  final AbsherService service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, service_provider_screen, arguments: {
            "service": service,
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Container(
                width: getWidth(context),
                height: 140,
                child: Hero(
                  tag: ValueKey("${service.id}"),
                  child: ImageWithPlaceholder(
                    fit: BoxFit.cover,
                    image: service.image,
                    prefix: MJ_Apis.serviceImgPath,
                  ),
                ),
              ),
              Container(
                width: getWidth(context),
                height: 140,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter,
                        colors: [
                      Color.fromRGBO(188, 55, 222, 0),
                      Color.fromRGBO(188, 55, 222, 0),
                      Color.fromRGBO(120, 22, 145, 0.82),
                    ])),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "${service.name}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
