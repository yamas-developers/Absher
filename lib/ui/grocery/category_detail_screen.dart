import 'dart:developer';

import 'package:absher/models/category_product.dart';
import 'package:absher/ui/common_widgets/build_slide_transition.dart';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../helpers/route_constants.dart';
import '../../models/cart.dart';
import '../../models/product.dart';
import '../../models/user.dart';
import '../../providers/business/store_detail_provider.dart';
import '../../providers/cart/cart_provider.dart';
import '../../providers/other/favorite_provider.dart';
import '../../providers/settings/settings_provider.dart';
import '../../providers/user/user_provider.dart';
import '../common_widgets/misc_widgets.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({Key? key}) : super(key: key);

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  int _current = 0;
  int cartQuantity = 0;

  // List<String> subCategories = ["Egg", "Chicken", "Mutton", "Beef", "Fish"];
  List<String> items = ["Chicken", "Wings", "Lorem ipsum dolor"];

  // String selected = "Chicken";
  // Category? item;
  // List<Category> categories = [];

  @override
  void didChangeDependencies() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   StoreDetailProvider provider = context.read<StoreDetailProvider>();
    //   await provider.getSubCatData();
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int animationDuration = 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Consumer<StoreDetailProvider>(builder: (context, provider, _) {
        return Consumer<CartProvider>(builder: (context, cartProvider, _) {
          return Consumer<FavoriteProvider>(builder: (context, favProvider, _) {
            return Stack(
              alignment: Alignment.center,
              children: [
                NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            color: mainColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 4,
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
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Image.asset(
                                                "assets/icons/back_arrow_icon.png",
                                                width: 24,
                                                height: 24,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Container(
                                          // height: 39,
                                          padding: EdgeInsets.fromLTRB(4, 9, 4, 9),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      Color.fromRGBO(0, 0, 0, 0.15),
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
                                                color: mainColor,
                                                width: 20,
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              Flexible(
                                                  child: Text(
                                                "Search for category",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: mainColor,
                                                    fontWeight: FontWeight.w500),
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Row(
                                      //     mainAxisAlignment: MainAxisAlignment.end,
                                      //     children: [
                                      //       GestureDetector(
                                      //         onTap: () {
                                      //           Navigator.pushNamed(
                                      //               context, cart_screen);
                                      //         },
                                      //         child: Image.asset(
                                      //           "assets/icons/cart.png",
                                      //           width: 24,
                                      //           color: Colors.white,
                                      //           height: 24,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    "Get Your Grocery",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                        ]),
                      ),
                    ];
                  },
                  body: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    child: (provider.loading && provider.storeSubCategories.isEmpty)
                        ? Column(
                            children: [
                              SizedBox(
                                height: getHeight(context) * 0.24,
                              ),
                              LoadingIndicator(),
                            ],
                          )
                        : (!provider.loading && provider.storeSubCategories.isEmpty)
                            ? EmptyWidget()
                            : Column(
                                children: [
                                  Container(
                                    // color: mainColorLight.withOpacity(0.25),
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    height: 50,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        ...List.generate(
                                          provider.storeSubCategories.length,
                                          (i) => GestureDetector(
                                            onTap: () {
                                              provider.selectedRestaurantSubCat =
                                                  provider.storeSubCategories[i];
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 4.0, vertical: 8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: provider
                                                                .storeSubCategories[
                                                                    i]
                                                                .id ==
                                                            provider
                                                                .selectedRestaurantSubCat
                                                                ?.id
                                                        ? mainColor
                                                        : mainColorLight
                                                            .withOpacity(0.25),
                                                    borderRadius:
                                                        BorderRadius.circular(6)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Center(
                                                      child: Text(
                                                    "${provider.storeSubCategories[i].name}",
                                                    style: TextStyle(
                                                        color: provider
                                                                    .storeSubCategories[
                                                                        i]
                                                                    .id ==
                                                                provider
                                                                    .selectedRestaurantSubCat
                                                                    ?.id
                                                            ? Colors.white
                                                            : Colors.black54),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ).toList(),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    // height: getHeight(context)-200,
                                    child: (provider.selectedRestaurantSubCat
                                                    ?.categoryProducts?.length ??
                                                0) <=
                                            0
                                        ? EmptyWidget()
                                        : GridView(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount:
                                                        isPortrait(context) ? 2 : 4,
                                                    childAspectRatio: 0.7),
                                            // itemCount: 16,
                                            // itemBuilder: (context, i) => ),
                                            children: [
                                              ...List.generate(
                                                  (provider
                                                          .selectedRestaurantSubCat
                                                          ?.categoryProducts
                                                          ?.length ??
                                                      0), (index) {
                                                if (index != 0) {
                                                  animationDuration =
                                                      ((animationDuration += 200) /
                                                                  index)
                                                              .round() +
                                                          800;
                                                }
                                                return BuildSlideTransition(
                                                  startPos: index % 2 == 0 ? -1 : 1,
                                                  animationDuration: index == 0
                                                      ? 350
                                                      : animationDuration,
                                                  child:
                                                      Builder(builder: (context) {
                                                    CategoryProduct? product = provider
                                                        .selectedRestaurantSubCat
                                                        ?.categoryProducts?[index];

                                                    ////////check if the product is available in the cart then get it's id and store id
                                                    int quantity = 0;
                                                    String cartId = "0";
                                                    dynamic response =
                                                        // null;
                                                        cartProvider
                                                            .checkCartForProduct(
                                                                product?.id,
                                                                provider
                                                                    .business?.id);

                                                    log("MJ: response from check cart ${response}");
                                                    if (response != null) {
                                                      quantity = convertNumber(
                                                          response["quantity"]);
                                                      cartId = response["cartId"];
                                                      // setState(() {
                                                      // });
                                                    }

                                                    dynamic onIncrease = () async {
                                                      await cartProvider
                                                          .updateProductCartQuantity(
                                                              cartId, quantity + 1);
                                                    };
                                                    dynamic add = () async {
                                                      Cart item = Cart(
                                                        title: product?.name,
                                                        storeProductId: product?.id,
                                                        image: product?.image,
                                                        price: product?.price
                                                            .toString(),
                                                        totalPrice: product?.price
                                                            .toString(),
                                                        addOns: [],
                                                        comment:
                                                            product?.description ??
                                                                "Store Product",
                                                        qty: "1",
                                                        storeId:
                                                            provider.business?.id,
                                                      );
                                                      await cartProvider.addToCart(
                                                          cartItem: item);
                                                      showToast("Added to cart");
                                                      // Navigator.pop(context);
                                                    };
                                                    dynamic onDecrease = () async {
                                                      await cartProvider
                                                          .updateProductCartQuantity(
                                                              cartId, quantity - 1);
                                                    };
                                                    dynamic addToCart() {
                                                      if (cartProvider
                                                          .currentStoreId
                                                          .toString() ==
                                                          provider
                                                              .business
                                                              ?.id
                                                              .toString() ||
                                                          cartProvider
                                                              .currentStoreId
                                                              .toString() ==
                                                              "0") {
                                                        add();
                                                      } else {
                                                        showAlertDialog(
                                                          context,
                                                          "Current items will be deleted",
                                                          "Your current cart items will be lost if you will add items from this store",
                                                          okButtonText:
                                                          "Sure",
                                                          dismissible: true,
                                                          type: AlertType.WARNING,
                                                          onPress: () {
                                                            Navigator.pop(context);
                                                            add();

                                                          },
                                                        );
                                                      }
                                                    }
                                                    // bool isFavorite = false;
                                                    // dynamic favoriteCallback = ;
                                                    return ProductItem(
                                                        product: product,
                                                        // isFavorite: isFavorite,
                                                        quantity: quantity,
                                                        addToCart: addToCart,
                                                        onDecrease: onDecrease,
                                                        onIncrease: onIncrease);
                                                  }),
                                                );
                                              }).toList(),
                                            ],
                                          ),
                                  ),
                                ],
                              ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: BottomCartWidget(),
                ),
              ],
            );
          });
        });
      }),
    );
  }
}

class ProductItem extends StatefulWidget {
  ProductItem({
    Key? key,
    required this.product,
    this.isFavorite = false,
    required this.quantity,
    required this.addToCart,
    required this.onDecrease,
    required this.onIncrease,
  }) : super(key: key);

  final CategoryProduct? product;
  bool isFavorite;
  final int quantity;

  final dynamic addToCart;
  final dynamic onDecrease;
  final dynamic onIncrease;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: lightGreyColor),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ImageWithPlaceholder(
                              image: widget.product?.image,
                              prefix: MJ_Apis.productImgPath,
                              height: null,
                              width: getWidth(context),
                              // height: 104,
                              fit: null)),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () async {
                            User? user =
                                Provider.of<UserProvider>(context, listen: false)
                                    .currentUser;
                            // if(isFavorite)
                            // await favProvider.removeFavoriteProduct(user?.id, product?.id);
                            // else

                            await context.read<FavoriteProvider>().addFavoriteProduct(
                                user?.id, widget.product?.id);
                            setState(() {
                              widget.isFavorite = true;
                            });
                          },
                          child: Container(
                            height: 30,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: darkGreyColor.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: Offset(1, 4))
                                ]),
                            child: Image.asset(
                              widget.isFavorite
                                  ? "assets/icons/favorite_filled.png"
                                  : "assets/icons/favorite.png",
                              // width: 84,
                              color: mainColor,
                              height: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${settingsProvider.zone?.zoneData?.first.currency_symbol} ${widget.product?.price ?? "N/A"}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: mainColor),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${widget.product?.name ?? "N/A"}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: darkGreyColor,
                    ),
                  ),
                  // SizedBox(
                  //   height: 14,
                  // ),
                  Spacer(),
                  if (widget.quantity == 0)
                    GestureDetector(
                        onTap: widget.addToCart,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: mainColor),
                          child: Text(
                            "+Add",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ))
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: widget.onDecrease,
                          child: Image.asset(
                            "assets/icons/minus_filled.png",
                            height: 24,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            // width: 60,
                            padding:
                                EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text(
                                "${widget.quantity}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: widget.onIncrease,
                          child: Image.asset(
                            "assets/icons/plus_filled.png",
                            height: 24,
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
/*
if((provider.selectedRestaurantSubCat?.categoryProducts
                          ?.length ??
                          0)<=0)EmptyWidget()
* */
