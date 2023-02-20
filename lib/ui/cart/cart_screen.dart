import 'package:absher/api/mj_apis.dart';
import 'package:absher/helpers/constants.dart';
import 'package:absher/helpers/route_constants.dart';
import 'package:absher/providers/cart/cart_provider.dart';
import 'package:absher/ui/common_widgets/misc_widgets.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/public_methods.dart';
import '../../models/cart.dart';
import '../common_widgets/build_slide_transition.dart';
import '../common_widgets/language_aware_widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CartProvider>().refreshCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int animationDuration = 300;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      // backgroundColor: Color.fromRGBO(177, 50, 210, 1),

      body: Consumer<CartProvider>(builder: (context, provider, _) {
        return Stack(
          children: [
            Container(
              width: getWidth(context),
              height: getHeight(context),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromRGBO(177, 50, 210, 1),
                    Color.fromRGBO(127, 15, 153, 1),
                  ])),
            ),
            Container(
              height: getHeight(context),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: getWidth(context),
                          child:
                              Image.asset("assets/images/cart_top_layout.png"),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                          child: Center(
                            child: Image.asset(
                              'assets/images/app_logo.png',
                              width: getSize(context, .22, 200, 60),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 12, 14, 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Resturant name",
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/trash.png",
                                    width: 20,
                                  ),
                                  Text(
                                    getString("cart__remove_all"),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ...List.generate(
                                    provider.list.length,
                                    (index) => BuildSlideTransition(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: CartItem(
                                              item: provider.list[index],
                                              onIncrease: () {
                                                int q = convertNumber(provider
                                                        .list[index].qty) +
                                                    1;
                                                provider
                                                    .updateProductCartQuantity(
                                                        provider
                                                            .list[index].id!,
                                                        q);
                                              },
                                              onDecrease: () {
                                                int q = convertNumber(provider
                                                        .list[index].qty) -
                                                    1;
                                                provider
                                                    .updateProductCartQuantity(
                                                        provider
                                                            .list[index].id!,
                                                        q);
                                              },
                                            ),
                                          ),
                                          animationDuration:
                                              animationDuration += 300,
                                          curve: Curves.elasticInOut,
                                          startPos: index % 2 == 0 ? 4 : -4,
                                        )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 12, 10, 12),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        getString("cart__sub_total"),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "₪",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            "${provider.cartTotal}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/rider.png",
                                            width: 22,
                                            height: 22,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            getString('cart__delivery_charges'),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "₪",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            "0",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        getString("cart__discount_%"),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "₪",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    125, 209, 193, 1),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            "0",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    125, 209, 193, 1),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        getString("cart__total"),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "₪",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            "${provider.cartTotal}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  getString("cart__add_more"),
                                  style: TextStyle(
                                      color: Color.fromRGBO(120, 22, 145, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.white),
                                    textStyle:
                                        MaterialStateProperty.resolveWith(
                                            (states) => TextStyle(
                                                  color: Color.fromRGBO(
                                                      120, 22, 145, 1),
                                                )),
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) => 0),
                                    shape: MaterialStateProperty.resolveWith(
                                        (states) => RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ))),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, checkout_screen);
                                },
                                child: Text(
                                  getString("cart__checkout"),
                                  style: TextStyle(
                                      color: Color.fromRGBO(120, 22, 145, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.white),
                                    textStyle:
                                        MaterialStateProperty.resolveWith(
                                            (states) => TextStyle(
                                                  color: Color.fromRGBO(
                                                      120, 22, 145, 1),
                                                )),
                                    elevation:
                                        MaterialStateProperty.resolveWith(
                                            (states) => 0),
                                    shape: MaterialStateProperty.resolveWith(
                                        (states) => RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CartItem extends StatelessWidget {
  final Cart item;
  final dynamic onIncrease;
  final dynamic onDecrease;

  const CartItem(
      {Key? key,
      required this.item,
      this.onIncrease = null,
      this.onDecrease = null})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: item.available ? EdgeInsets.fromLTRB(6, 6, 6, 6) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [

          Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ImageWithPlaceholder(
                          image: item.image,
                          prefix: MJ_Apis.productImgPath,
                          height: 70,
                          fit: BoxFit.contain,
                        ),
                      )),
                  Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${getString("common__qar")} ${item.price} ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                )),
                            SizedBox(
                              height: 6,
                            ),
                            Text("${item.title}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            SizedBox(
                              height: 6,
                            ),
                            Text("${item.comment}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11)),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            getString("common__qty"),
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ReflectByLanguage(
                                child: TouchableOpacity(
                                  onTap: onDecrease,
                                  child: Icon(Icons.arrow_back_ios_new_rounded,
                                      color: Colors.white, size: 16),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${item.qty}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TouchableOpacity(
                                onTap: onIncrease,
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
              if ((item.addOns?.length ?? 0) > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "AddOns:",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Column(
                          children: [
                            ...List.generate(
                                (item.addOns?.length ?? 0),
                                (index) => Column(
                                      children: [
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${item.addOns?[index].name}:  ",
                                              style: TextStyle(
                                                  color: Colors.white60),
                                            ),
                                            Text(
                                              "${item.addOns?[index].qty} x ",
                                              style: TextStyle(
                                                  color: Colors.white60),
                                            ),
                                            Text(
                                              "qar ${item.addOns?[index].price}",
                                              style: TextStyle(
                                                  color: Colors.white60),
                                            ),
                                            if (!(item
                                                    .addOns?[index].available ??
                                                true))
                                              Text(
                                                " (Unavailable)",
                                                style: TextStyle(
                                                    color: Colors.white60,
                                                    fontSize: 11),
                                              ),
                                          ],
                                        )
                                      ],
                                    ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
          if(!item.available)
          Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                color: Colors.black38,
                  // color: Color.fromRGBO(255, 255, 255, 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text("Unavailable", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),),
                ),
              )),
        ],
      ),
    );
  }
}
