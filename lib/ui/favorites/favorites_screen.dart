import 'dart:developer';

import 'package:absher/helpers/public_methods.dart';
import 'package:absher/models/product.dart';
import 'package:absher/providers/other/favorite_provider.dart';
import 'package:absher/providers/user/user_provider.dart';
import 'package:absher/ui/common_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../../helpers/route_constants.dart';
import '../../models/restaurant.dart';
import '../../models/user.dart';
import '../common_widgets/avatar.dart';

class FovoritesScreen extends StatefulWidget {
  const FovoritesScreen({Key? key}) : super(key: key);

  @override
  State<FovoritesScreen> createState() => _FovoritesScreenState();
}

class _FovoritesScreenState extends State<FovoritesScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      User? user = context.read<UserProvider>().currentUser;
      await context.read<FavoriteProvider>().getData(user?.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: mainColor,
        ),
        body: Consumer<FavoriteProvider>(builder: (context, provider, _) {
          return NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  SliverList(
                    delegate: SliverChildListDelegate([
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                      child: Text(
                                    getString("favorite__all_favorite"),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: mainColor,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                ];
              },
              body: Column(
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Container(
                      height: 40,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: darkGreyColor.withOpacity(.35),
                              offset: Offset(0, 1),
                              blurRadius: 8,
                            )
                          ]
                          // border: Border.all(
                          //   color:  Color.fromRGBO(27, 189, 198, 1),
                          // ),
                          ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: TabBar(
                          controller: tabController,
                          indicator: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                colors: [
                                  mainColor,
                                  mainColorLight.withOpacity(0.8)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: darkGreyColor,
                          tabs: [
                            Tab(
                              text: getString('favorite__vendors'),
                            ),
                            Tab(
                              text: getString('favorite__products'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(controller: tabController, children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18, top: 8),
                        child: FavoriteBusinessArea(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18, top: 8),
                        child: FavoriteProductsArea(),
                      ),
                    ]),
                  ),
                ],
              ));
        }));
  }
}

class FavoriteProductsArea extends StatefulWidget {
  const FavoriteProductsArea({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteProductsArea> createState() => _FavoriteProductsAreaState();
}

class _FavoriteProductsAreaState extends State<FavoriteProductsArea> {
  var _listItems = <Widget>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  void _loadItems() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (_listKey.currentState == null) {
        await Future.delayed(Duration(milliseconds: 400));
        return _loadItems();
      }
      List<Product> list =
          Provider.of<FavoriteProvider>(context).favoriteProducts;
      var future = Future(() {});
      for (Product product in list) {
        log("MK: product name ${product.name}");
        future = future.then((_) {
          return Future.delayed(Duration(milliseconds: 200), () {
            _listItems.add(NotificationItem(
              title: product.name ?? "Title Unavailable",
              image: product.image,
              description: product.description ?? "No description",
              isFavorited: true,
              onClick: () {

              },
              prefix: null,
            ));
            _listKey.currentState!.insertItem(_listItems.length - 1);
          });
        });
      }
    });
  }

  @override
  void initState() {
    _loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(builder: (context, provider, _) {
      return provider.favoriteProducts.length > 0 ? ListView.builder(
        key: _listKey,
        padding: EdgeInsets.only(top: 10),
        itemCount: provider.favoriteProducts.length,
        itemBuilder: (context, index) {
          Product product = provider.favoriteProducts[index];
          return NotificationItem(
            title: product.name ?? "Title Unavailable",
            image: product.image,
            description: product.description ?? "No description",
            isFavorited: true,
            onClick: () async {
              User? user =
                  Provider.of<UserProvider>(context, listen: false).currentUser;
              await provider.removeFavoriteProduct(user?.id, product.id);
            },
            prefix: MJ_Apis.productImgPath,
          );
        },
      ) : EmptyWidget(title: "No items in favorites",);
    });
  }
}


class FavoriteBusinessArea extends StatefulWidget {
  const FavoriteBusinessArea({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteBusinessArea> createState() => _FavoriteBusinessAreaState();
}

class _FavoriteBusinessAreaState extends State<FavoriteBusinessArea> {
  var _listItems = <Widget>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  // void _loadItems() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     if (_listKey.currentState == null) {
  //       await Future.delayed(Duration(milliseconds: 400));
  //       return _loadItems();
  //     }
  //     List<Business> list =
  //         Provider.of<FavoriteProvider>(context).favoritesBusiness;
  //     var future = Future(() {});
  //     for (Business product in list) {
  //       log("MK: product name ${product.name}");
  //       future = future.then((_) {
  //         return Future.delayed(Duration(milliseconds: 200), () {
  //           _listItems.add(NotificationItem(
  //             title: product.name ?? "Title Unavailable",
  //             image: product.logo,
  //             description: product.address ?? "No address",
  //             isFavorited: true,
  //             onClick: () {},
  //             prefix: null,
  //           ));
  //           _listKey.currentState!.insertItem(_listItems.length - 1);
  //         });
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    // _loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(builder: (context, provider, _) {
      return provider.favoritesBusiness.length > 0 ? ListView.builder(
        key: _listKey,
        padding: EdgeInsets.only(top: 10),
        itemCount: provider.favoritesBusiness.length,
        itemBuilder: (context, index) {
          Business item = provider.favoritesBusiness[index];
          return NotificationItem(
            title: item.name ?? "Title Unavailable",
            image: item.logo,
            description: item.address ?? "No address",
            isFavorited: true,
            onClick: () async {
              User? user =
                  Provider.of<UserProvider>(context, listen: false).currentUser;
              await provider.removeFavoriteBusiness(user?.id, item.id);
            },
            prefix: MJ_Apis.restaurantImgPath,
          );
        },
      ) : EmptyWidget(title: "No items in favorites",);
    });
  }
}

// class FavoriteItemsArea extends StatefulWidget {
//   const FavoriteItemsArea({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<FavoriteItemsArea> createState() => _FavoriteItemsAreaState();
// }
//
// class _FavoriteItemsAreaState extends State<FavoriteItemsArea> {
//   var _listItems = <Widget>[];
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey();
//
//   void _loadItems(length) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       if (_listKey.currentState == null) {
//         await Future.delayed(Duration(milliseconds: 400));
//         return _loadItems(length);
//       }
//       var future = Future(() {});
//       for (var i = 0; i < length; i++) {
//         future = future.then((_) {
//           return Future.delayed(Duration(milliseconds: 200), () {
//             _listItems.add(NotificationItem());
//             _listKey.currentState!.insertItem(_listItems.length - 1);
//           });
//         });
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     _loadItems(6);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedList(
//       key: _listKey,
//       padding: EdgeInsets.only(top: 10),
//       initialItemCount: _listItems.length,
//       itemBuilder: (context, index, animation) {
//         return SlideTransition(
//           position: CurvedAnimation(
//             curve: Curves.bounceInOut,
//             parent: animation,
//           ).drive((Tween<Offset>(
//             begin: Offset(2, 0),
//             end: Offset(0, 0),
//           ))),
//           child: _listItems[index],
//         );
//       },
//     );
//   }
// }

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.title,
    this.image,
    this.prefix,
    required this.description,
    this.onClick,
    required this.isFavorited,
  }) : super(key: key);

  final String title;
  final String? image;
  final String? prefix;
  final String description;
  final dynamic onClick;
  final bool isFavorited;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Placeholder()
                RoundedNetworkAvatar(
                  url: image,
                  prefix: prefix,
                  color: mainColor,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 12,),
                  Text(
                    "$title",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  Text(
                    "$description",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  // SizedBox(height: 12,),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                InkWell(
                  onTap: onClick,
                  child: Image.asset(
                    isFavorited
                        ? "assets/icons/favorite_filled.png"
                        : "assets/icons/favorite.png",
                    color: mainColor,
                    fit: BoxFit.fill,
                    height: 25,
                    // width: 20,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
