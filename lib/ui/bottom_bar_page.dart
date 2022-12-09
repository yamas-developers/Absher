import 'dart:io';

import 'package:absher/helpers/constants.dart';
import 'package:absher/ui/cart/cart_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../helpers/public_methods.dart';
import '../search_screen.dart';
import 'account_screen.dart';
import 'favorites/favorites_screen.dart';
import 'home/home_screen.dart';

class BottomAppBarPage extends StatefulWidget {
  const BottomAppBarPage({Key? key}) : super(key: key);

  @override
  State<BottomAppBarPage> createState() => _BottomAppBarPageState();
}

class _BottomAppBarPageState extends State<BottomAppBarPage> {
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setCurrentIndex(int index) {
    currentIndex = index;
    setState(() {});
  }

  Widget getCurrentWidget() {
    if (currentIndex == 5) return CartScreen();
    if (currentIndex == 2) return SearchScreen();
    if (currentIndex == 3) return FovoritesScreen();
    if (currentIndex == 4) return AccountScreen();
    return HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        elevation: 1,
      ),
      body: getCurrentWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: getSize(context, .20, 120, 80),
        child: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: FloatingActionButton.large(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "assets/icons/cart.png",
                  width: getSize(context, .09, 44, 30),
                  height: 34,
                  color: currentIndex == 5 ? mainColor : lightGreyColor,
                ),
                SizedBox(height: 4),
                Text(
                  getString("bottom_nav__cart"),
                  style: TextStyle(
                    color: currentIndex == 5 ? mainColor : lightGreyColor,
                    fontSize: getSize(context, .03, 14, 12),
                    // fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            backgroundColor: Colors.white,
            onPressed: () {
              setCurrentIndex(5);
              // Overlay.of(context)!.insert(entry);
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 9.0,
        // color: Colors.transparent,
        // elevation: 0,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: getSize(context, .02, 10, 6)),
          height: getSize(context, .20, 80, 60),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: kIsWeb
                ? CrossAxisAlignment.center
                : Platform.isIOS
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Container(
                  width: getSize(context, .20, 60, 30),
                  child: GestureDetector(
                    onTap: () {
                      setCurrentIndex(1);
                    },
                    child: BottomBarItem(
                      currentIndex: currentIndex,
                      title: getString("bottom_nav__home"),
                      icon: 'assets/icons/home.png',
                      itemIndex: 1,
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 30,),
              GestureDetector(
                  onTap: () {
                    setCurrentIndex(2);
                  },
                  child: BottomBarItem(
                      currentIndex: currentIndex,
                      title: getString("bottom_nav__search"),
                      icon: 'assets/icons/search.png',
                      itemIndex: 2)),
              // SizedBox(),
              SizedBox(
                width: 64,
              ),
              // SizedBox(),
              GestureDetector(
                onTap: (){
                  setCurrentIndex(3);
                },
                child: BottomBarItem(
                    currentIndex: currentIndex,
                    icon: 'assets/icons/favorite.png',
                    title: getString("bottom_nav__favorite"),
                    itemIndex: 3),
              ),
              GestureDetector(
                onTap: (){
                  setCurrentIndex(4);
                },
                child: BottomBarItem(
                    currentIndex: currentIndex,
                    icon: 'assets/icons/user.png',
                    title: getString("bottom_nav__account"),
                    itemIndex: 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    Key? key,
    required this.currentIndex,
    required this.itemIndex,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final int currentIndex;
  final int itemIndex;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: getSize(context, .1, 40, 30),
          color: currentIndex == itemIndex ? mainColor : lightGreyColor,
        ),
        Text(
          title,
          style: TextStyle(
            color: currentIndex == itemIndex ? mainColor : lightGreyColor,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
