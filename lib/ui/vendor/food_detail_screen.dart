import 'dart:developer';

import 'package:absher/helpers/public_methods.dart';
import 'package:absher/providers/business/product_detail_provider.dart';
import 'package:absher/providers/cart/cart_provider.dart';
import 'package:absher/ui/common_widgets/misc_widgets.dart';
import 'package:absher/ui/common_widgets/rounded_center_button.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../../models/addons.dart';
import '../../models/cart.dart';
import '../../models/category_product.dart';
import '../../models/product.dart';
import '../../models/user.dart';
import '../../models/variation.dart';
import '../../providers/other/favorite_provider.dart';
import '../../providers/settings/settings_provider.dart';
import '../../providers/user/user_provider.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  // String image = "assets/images/placeholder_image.png";
  // String type = BUSINESS_TYPE_RESTAURANT;
  CategoryProduct? product;
  int quantity = 0;
  TextEditingController commentController = TextEditingController();
  String? cartId;

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) return;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        ProductDetailProvider detailProvider =
            context.read<ProductDetailProvider>();
        CartProvider cartProvider = context.read<CartProvider>();
        setState(() {
          product = args["product"];
          // type = args["type"];
        });
        await detailProvider.getData(product?.id);
        Cart? item = cartProvider.list.firstWhereOrNull(
            (element) => element.storeProductId == product?.id);
        List<AddOns>? addOns = item?.addOns;
        log("MJ: addOns in cart_screen ${addOns} in ${item?.id}");
        if (addOns != null && addOns.isNotEmpty) {
          for (AddOns addOn in addOns) {
            // bool flag = false;
            detailProvider.addOns.forEach((element) {
              if (element.id == addOn.id) {
                element.qty = addOn.qty;
                element.available = true;
                // flag = true;
              }
            });
            // if (flag == false) element.available = false;
          }
          log("MJ: addOns in cart_screen2 ${addOns.length} in ${addOns[0].qty}");
          // detailProvider.addOns = addOns;
        }
        detailProvider.variant = item?.variant;
        setState(() {
          cartId = item?.id;
          quantity = convertNumber(item?.qty);
          commentController.text = item?.comment ?? "";
          if(cartId == null)quantity = 1;
        });
      });
    }
    super.didChangeDependencies();
  }

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Consumer<ProductDetailProvider>(builder: (context, provider, _) {
        return Consumer<SettingsProvider>(
            builder: (context, settingsProvider, _) {
              return  Consumer<CartProvider>(builder: (context, cartProvider, _) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                            tag: ValueKey("${product?.id}"),
                            child: ImageWithPlaceholder(
                              image: product?.image,
                              height: 200,
                              width: getWidth(context),
                              prefix: MJ_Apis.productImgPath,
                            )),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${settingsProvider.zone?.zoneData?.first.currency_symbol} ${product?.price ?? "N/A"}",
                                style: TextStyle(
                                    color: priceGreenColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "${product?.name ?? "N/A"}",
                                style: TextStyle(
                                    color: blackFontColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "${product?.description ?? "N/A"}",
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Add Ons",
                                style: TextStyle(
                                    color: blackFontColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        provider.loading
                            ? LoadingIndicator()
                            : Center(
                                child: Wrap(children: [
                                  for (AddOns addOn in provider.addOns)
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 6.0),
                                      child: Container(
                                        width: getWidth(context) / 2 - 16,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 12),
                                        margin: EdgeInsets.symmetric(horizontal: 3),
                                        decoration: BoxDecoration(
                                            color: mainColorLightest,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${settingsProvider.zone?.zoneData?.first.currency_symbol} ${addOn.price}",
                                                    style: TextStyle(
                                                        color: mainColor,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 15),
                                                  ),
                                                  Text(
                                                    "${addOn.name}",
                                                    style: TextStyle(
                                                        color: mainColor,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: addOn.available
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          onTap: addOn.available
                                                              ? () {
                                                                  // addOn.available = false;
                                                                  // return;
                                                                  if (addOn.qty ==
                                                                      0) return;
                                                                  setState(() {
                                                                    addOn.qty--;
                                                                  });
                                                                }
                                                              : null,
                                                          child: Image.asset(
                                                            "assets/icons/minus_filled.png",
                                                            height: 22,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "${addOn.qty}",
                                                          style: TextStyle(
                                                              color: mainColor,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              fontSize: 13),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        InkWell(
                                                          onTap: addOn.available
                                                              ? () {
                                                                  setState(() {
                                                                    addOn.qty++;
                                                                  });
                                                                }
                                                              : null,
                                                          child: Image.asset(
                                                            "assets/icons/plus_filled.png",
                                                            height: 22,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Text(
                                                      "Unavailable",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: mainColorLight),
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                ]),
                              ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            "Variants",
                            style: TextStyle(
                                color: blackFontColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Wrap(children: [
                            // for (Variations variant in )
                            ...List.generate(
                                provider.product?.variations?.length ?? 0, (index) {
                              Variation? variant =
                                  provider.product?.variations![index];
                              bool isSelected = provider.isVariantSame(variant);
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 4),
                                child: GestureDetector(
                                  onTap: () {
                                    provider.variant = variant;
                                  },
                                  child: Container(
                                    width: getWidth(context) / 3 - 24,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 12),
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    decoration: BoxDecoration(
                                        color: isSelected
                                            ? mainColorLight
                                            : mainColorLightest,
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${settingsProvider.zone?.zoneData?.first.currency_symbol} ${variant?.price}",
                                                style: TextStyle(
                                                    color: isSelected
                                                        ? Colors.white
                                                        : mainColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                "${variant?.type}",
                                                style: TextStyle(
                                                    color: isSelected
                                                        ? Colors.white
                                                        : mainColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ]),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            "Add Comment",
                            style: TextStyle(
                                color: blackFontColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: darkGreyColor.withOpacity(0.3),
                                      offset: Offset(0, 2),
                                      blurRadius: 8)
                                ],
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: TextField(
                              controller: commentController,
                              maxLines: 4,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: "Add your comment",
                                  border: InputBorder.none
                                  // OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(12)),
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            "Quantity",
                            style: TextStyle(
                                color: blackFontColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Container(
                            // width: 270,
                            padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                            decoration: BoxDecoration(
                                border: Border.all(color: lightGreyFontColor),
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: darkGreyColor.withOpacity(0.2),
                                      offset: Offset(0, 2),
                                      blurRadius: 8)
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TouchableOpacity(
                                  onTap: () {
                                    if (quantity <= 0) return;
                                    setState(() {
                                      quantity--;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Image.asset(
                                      "assets/icons/angle_left.png",
                                      height: 30,
                                      color: lightGreyFontColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${quantity}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: lightGreyFontColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                TouchableOpacity(
                                  onTap: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Image.asset(
                                      "assets/icons/angle_right.png",
                                      height: 30,
                                      color: lightGreyFontColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: RoundedCenterButtton(
                              onPressed: () async {
                                add() async {
                                  if (quantity <= 0 && cartId == null) {
                                    showToast("Please select quantity");
                                    return;
                                  }
                                  if (provider.variant == null && cartId == null) {
                                    showToast("Please select variant");
                                    return;
                                  }
                                  int total = 0;
                                  int addOns = 0;
                                  List<AddOns> list = [];
                                  for (int i = 0;
                                      i < (provider.addOns.length);
                                      i++) {
                                    if (convertNumber(provider.addOns[i].qty) > 0) {
                                      list.add(provider.addOns[i]);
                                      addOns +=
                                          convertNumber(provider.addOns[i].price) *
                                              convertNumber(provider.addOns[i].qty);
                                    }
                                  }
                                  total += (convertNumber(provider.variant?.price) +
                                          addOns) *
                                      quantity;

                                  // provider.addOns
                                  log('MK: variant price ${provider.variant?.price}');

                                  int price = provider.variant?.price??provider.product?.price??0;


                                  Cart item = Cart(
                                      title: provider.product?.name,
                                      storeProductId: provider.product?.id,
                                      image: provider.product?.image,
                                      price: price.toString(),
                                      totalPrice: total.toString(),
                                      addOns: list,
                                      comment: commentController.text,
                                      qty: quantity.toString(),
                                      storeId: provider.product?.restaurantId,
                                      variant: provider.variant);

                                  if (quantity > 0) {
                                    await context
                                        .read<CartProvider>()
                                        .addToCart(cartItem: item);
                                    showToast("Added to cart");
                                  } else {
                                    if (cartId != null) {
                                      await context
                                          .read<CartProvider>()
                                          .removeFromCart(cartId);
                                      showToast("Cart updated");
                                    }
                                  }
                                  Navigator.pop(context);
                                }

                                dynamic addToCart() {
                                  if (cartProvider.currentStoreId.toString() ==
                                          provider.product?.restaurantId
                                              .toString() ||
                                      cartProvider.currentStoreId.toString() ==
                                          "0") {
                                    add();
                                  } else {
                                    showAlertDialog(
                                      context,
                                      "Current items will be deleted",
                                      "Your current cart items will be lost if you will add items from this store",
                                      okButtonText: "Sure",
                                      dismissible: true,
                                      type: AlertType.WARNING,
                                      onPress: () {
                                        Navigator.pop(context);
                                        add();
                                      },
                                    );
                                  }
                                }

                                addToCart();
                              },
                              title:
                                  "${cartId != null ? "Update Cart" : "Add to Cart"}",
                              heightToMinus: 0),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                      top: 12,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18.0),
                                child: Image.asset(
                                  "assets/icons/back_arrow_icon.png",
                                  width: 24,
                                  height: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    User? user =
                                        context.read<UserProvider>().currentUser;
                                    if (user != null) {
                                      context
                                          .read<FavoriteProvider>()
                                          .addFavoriteProduct(
                                              user.id, provider.product?.id);
                                      setState(() {
                                        isFavorite = true;
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0),
                                    child: Image.asset(
                                      !isFavorite
                                          ? "assets/icons/favorite.png"
                                          : "assets/icons/favorite_filled.png",
                                      width: 30,
                                      height: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.pop(context);
                                //   },
                                //   child: Padding(
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 18.0),
                                //     child: Image.asset(
                                //       "assets/icons/bookmark.png",
                                //       width: 20,
                                //       // height: 20,
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // ),
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.pop(context);
                                //   },
                                //   child: Padding(
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 18.0),
                                //     child: Image.asset(
                                //       "assets/icons/exit_icon.png",
                                //       width: 24,
                                //       height: 24,
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // ),
                              ],
                            )
                          ],
                        ),
                      )),
                ],
              );
            });
          }
        );
      }),
    );
  }
}
