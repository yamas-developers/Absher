import 'package:absher/ui/common_widgets/build_slide_transition.dart';
import 'package:absher/ui/common_widgets/language_aware_widgets.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../common_widgets/avatar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
              padding: EdgeInsets.fromLTRB(0, 15, 18, 0),
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
                          child: ReflectByLanguage(
                            child: Image.asset(
                              "assets/icons/back_arrow_icon.png",
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
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
                          getString("common__notifications"),
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
              height: 16,
            ),
            LinearProgressIndicator(
              color: mainColor,
              value: 0.5,
            ),
            SizedBox(
              height: 26,
            ),
            ...List.generate(
                4,
                (index) => BuildSlideTransition(
animationDuration: (index*300)+300,curve: Curves.easeInOutCubicEmphasized,
                        child: NotificationItem(
                      index: index,
                      isRead: index % 2 != 0,
                    ))),
            // SizedBox(
            //   height: 35,
            // ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  NotificationItem({
    Key? key,
    required this.index,
    this.isRead = false,
  }) : super(key: key);
  final int index;
  final bool isRead;
  String content = "Lorem ipsum dolor sit amet, consec tetur adipiscing eli";
  List images = [
    'assets/images/temp/person0.png',
    "assets/images/temp/person3.png"
  ];
  int length = 0;

  @override
  Widget build(BuildContext context) {
    if (index % 2 == 0) {
      length = 1;
    } else {
      length = images.length;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
      child: Opacity(
        opacity: isRead ? 0.4 : 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/icons/notification.png",
                      height: 20, color: mainColor),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 12,),
                    Row(
                      children: [
                        for (int i = 0; i < length; i++)
                          RoundedAvatar(
                            assetPath: "${images[i]}",
                            height: 40,
                            width: 40,
                          )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      "$content",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: darkGreyFontColor),
                    ),
                    // SizedBox(height: 12,),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
