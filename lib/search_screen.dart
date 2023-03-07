import 'package:absher/providers/other/search_business_provider.dart';
import 'package:absher/providers/settings/settings_provider.dart';
import 'package:absher/ui/common_widgets/avatar.dart';
import 'package:absher/ui/common_widgets/build_slide_transition.dart';
import 'package:absher/ui/common_widgets/misc_widgets.dart';

// import 'package:absher/temp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/mj_apis.dart';
import 'helpers/constants.dart';
import 'helpers/public_methods.dart';
import 'helpers/route_constants.dart';
import 'models/restaurant.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isDelivery = true;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SearchBusinessProvider provider = Provider.of<SearchBusinessProvider>(context, listen: false);
      _controller.text = provider.searchedString;
      await
          provider.getPopularRestaurants();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int duration = 300;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Consumer<SearchBusinessProvider>(builder: (context, provider, _) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 6,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 18, 0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Image.asset(
                          //   "assets/icons/back_arrow_icon.png",
                          //   width: 24,
                          //   height: 24,
                          // ),
                          SizedBox(
                            width: 8,
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
                            GestureDetector(
                              onTap: () async {
                                await provider.reset(
                                    empty_list: true, name: _controller.text);
                              },
                              child: Image.asset(
                                "assets/icons/search_icon.png",
                                width: 20,
                                height: 20,
                                color: mainColor,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Flexible(
                                child: SizedBox(
                              height: 30,
                              child: TextField(
                                controller: _controller,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 12),
                                    border: InputBorder.none,
                                    labelText: "Search",
                                    labelStyle: TextStyle(color: mainColor),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never),
                              ),
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
                              Navigator.pushNamed(
                                  context, notifications_screen);
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
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              ...safeguardConnectivityAndService(context: context, widgets: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
                  child: Column(
                    children: [
                      if (provider.loading) LoadingIndicator(),
                      if (provider.list.length < 1 && !provider.loading)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text(
                            "Type above to search in area",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: darkGreyColor,
                                height: 1.2,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ...List.generate(provider.list.length, (index) {
                        Business? business = provider.list[index];
                        return BuildSlideTransition(
                            child: SearchBusinessItem(
                              business: business,
                              onPressed: () {
                                Provider.of<SettingsProvider>(context,
                                        listen: false)
                                    .gotoBusinessDetailPage(context, business);
                              },
                            ),
                            animationDuration: duration += 300,
                            startPos: 1.0,
                            curve: Curves.elasticInOut);
                      })
                    ],
                  ),
                ),
                if (provider.popularBusiness.length > 0)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 14.0, right: 14, top: 18),
                    child: Text(
                      getString("search__top_searched"),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: darkGreyColor),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 170,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...List.generate(
                          provider.popularBusiness.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  Provider.of<SettingsProvider>(context, listen: false)
                                      .gotoBusinessDetailPage(context,
                                          provider.popularBusiness[index]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: lightGreyColor
                                                .withOpacity(0.35),
                                            blurRadius: 12,
                                            offset: Offset(2, 4))
                                      ]),
                                  padding: EdgeInsets.only(
                                      left: index == 0 ? 14 : 4, right: 4),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: ImageWithPlaceholder(
                                          image: provider.popularBusiness[index]
                                              .coverPhoto,
                                          prefix:
                                              MJ_Apis.restaurantCoverImgPath,
                                          width: 130,
                                          height: 150,
                                          fit: BoxFit.fill)),
                                ),
                              ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
              ])
            ],
          ),
        );
      }),
    );
  }
}

class SearchBusinessItem extends StatelessWidget {
  SearchBusinessItem({Key? key, required this.business, this.onPressed})
      : super(key: key);

  final Business? business;
  final dynamic onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            RoundedNetworkAvatar(
              url: "${MJ_Apis.restaurantImgPath}${business?.logo}",
              color: mainColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 12,),
                  Text(
                    "${business?.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black54),
                  ),
                  Text(
                    business?.address ?? "4.4M Saved",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  // SizedBox(height: 12,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
