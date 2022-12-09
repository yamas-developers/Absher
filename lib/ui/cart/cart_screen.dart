import 'package:absher/helpers/constants.dart';
import 'package:absher/helpers/route_constants.dart';
import 'package:flutter/material.dart';

import '../../helpers/public_methods.dart';
import '../common_widgets/build_slide_transition.dart';
import '../common_widgets/language_aware_widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    int animationDuration = 300;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      // backgroundColor: Color.fromRGBO(177, 50, 210, 1),

      body: Stack(
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
                        child: Image.asset("assets/images/cart_top_layout.png"),
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
                              ...List.generate(4, (index) =>  BuildSlideTransition(child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: CartItem(
                                    image: 'assets/images/product${index<=4 ? index + 1 : 3}.png',
                                    price: '12.99',
                                    description:
                                    'Lorem ipsum dolor sit amet  et dolore',
                                    qty: '3'),
                              ), animationDuration : animationDuration += 300,curve: Curves.elasticInOut, startPos: index%2==0? 4: -4,)),

                              // SizedBox(
                              //   height: 10,
                              // ),
                              // CartItem(
                              //     image: 'assets/images/product2.png',
                              //     price: '2.49',
                              //     description:
                              //         'Lorem ipsum dolor sit amet  et dolore',
                              //     qty: '2'),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // CartItem(
                              //     image: 'assets/images/product3.png',
                              //     price: '2.49',
                              //     description:
                              //         'Lorem ipsum dolor sit amet  et dolore',
                              //     qty: '2'),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // CartItem(
                              //     image: 'assets/images/product4.png',
                              //     price: '2.49',
                              //     description:
                              //         'Lorem ipsum dolor sit amet  et dolore',
                              //     qty: '2'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
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
                                          "53",
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
                                          "1.5",
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
                                          "3",
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
                                SizedBox(height: 6,),
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
                                          "51.5",
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
                              child: Text(getString("cart__add_more"),
                              style: TextStyle(
                                color: Color.fromRGBO(120, 22, 145, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w600

                              ),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
                                  color: Color.fromRGBO(120, 22, 145, 1),
                                )),
                                elevation: MaterialStateProperty.resolveWith((states) => 0),
                                shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ))
                              ),
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
                              child: Text(getString("cart__checkout"),
                                style: TextStyle(
                                    color: Color.fromRGBO(120, 22, 145, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600

                                ),),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                                  textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
                                    color: Color.fromRGBO(120, 22, 145, 1),
                                  )),
                                  elevation: MaterialStateProperty.resolveWith((states) => 0),
                                  shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ))
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String image;
  final String price;
  final String description;
  final String qty;

  const CartItem(
      {Key? key,
      required this.image,
      required this.price,
      required this.description,
      required this.qty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
              flex: 3,
              child: Image.asset(
                "${image}",
                height: 70,
                fit: BoxFit.contain,
              )),
          Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${getString("common__qar")} ${price} ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(
                      height: 6,
                    ),
                    Text("${description}",
                        style: TextStyle(color: Colors.white, fontSize: 11)),
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
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white, size: 16),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${qty}',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
