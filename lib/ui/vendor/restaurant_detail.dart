import 'dart:developer' as dev;

import 'package:absher/models/restaurant.dart';
import 'package:absher/providers/business/business_detail_provider.dart';
import 'package:absher/ui/common_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../api/mj_apis.dart';
import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../helpers/route_constants.dart';
import '../../models/cart.dart';
import '../../models/category_product.dart';
import '../../models/user.dart';
import '../../providers/cart/cart_provider.dart';
import '../../providers/other/favorite_provider.dart';
import '../../providers/user/user_provider.dart';
import '../common_widgets/avatar.dart';
import '../common_widgets/build_slide_transition.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen>
    with TickerProviderStateMixin<RestaurantDetailScreen> {
  String selected = "1";

  // List categories = ["Best Selling", "Sushi", "Salad", "Pasta", "Fish"];
  List<GlobalKey>? _keys;
  GlobalKey<State> myKey = GlobalKey();
  double top = 40;
  bool showOnTop = false;
  String storeType = BUSINESS_TYPE_RESTAURANT;

  AnimationController? _controller;
  RenderObject? _prevRenderObject;
  double _offsetToRevealBottom = double.infinity;
  double _offsetToRevealTop = double.negativeInfinity;

  setTop(val) {
    // if(val == top) return;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   setState(() {
    //     top = val;
    //   });
    // });
  }

  setShowOnTop(val) {
    // if(showOnTop == val) return;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   setState(() {
    //     showOnTop = val;
    //   });
    //
    // });
  }

  @override
  void initState() {
    setState(() {});
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    _controller!.addStatusListener((val) {
      if (val == AnimationStatus.dismissed) {
        setState(() => showOnTop = true);
        print("showOnTop: ${showOnTop}");
      }
      print("value: ${val}");
      print("controller: ${_controller!.value}");
    });
    super.initState();
  }

  Business? businessItem;

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments == null) return;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      setState(() {
        businessItem = args["store"];
        storeType = businessItem?.businessType?.id ?? BUSINESS_TYPE_RESTAURANT;
      });
      dev.log("arguments: ${storeType} ${businessItem?.name}");
      if (businessItem is Business) {
        BusinessDetailProvider provider =
            context.read<BusinessDetailProvider>();
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          provider.business = businessItem;
          await provider.getData();
        });
      }
    }

    if (storeType == BUSINESS_TYPE_PHARMACY) {
      setState(() {
        // categories = ["All", "Men", "Women", "Kids", "Pain Killers"];
        selected = "1";
      });
    }
    super.didChangeDependencies();
  }

  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    dev.log("arguments:");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: Consumer<CartProvider>(builder: (context, cartProvider, _) {
        return Consumer<BusinessDetailProvider>(
            builder: (context, provider, _) {
          _keys = List.generate(
              provider.businessCategories.length, (index) => GlobalKey());
          return Stack(
            alignment: Alignment.center,
            children: [
              NotificationListener<ScrollNotification>(
                child: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate: MySliverAppBar(
                        expandedHeight: 200,
                        setTop: setTop,
                        setShowOnTop: setShowOnTop,
                        provider: provider,
                        isFavorite: isFavorited,
                        onFavoriteClick: () {
                          User? user = context.read<UserProvider>().currentUser;
                          if (user != null) {
                            context
                                .read<FavoriteProvider>()
                                .addFavoriteBusiness(
                                    user.id, provider.business?.id);
                            setState(() {
                              isFavorited = true;
                            });
                          } else {
                            showToast("Please login first");
                          }
                        },
                      ),
                      pinned: true,
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0, top: 18, right: 18),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${businessItem?.name}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                          '${businessItem?.businessType?.type}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: darkGreyColor)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 40,
                                        // padding: EdgeInsets.symmetric(vertical: 10),

                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          "assets/icons/star.png",
                                                          width: 16,
                                                          color: mainColor,
                                                          height: 16,
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          '${businessItem?.ratingCount ?? 0}',
                                                          style: TextStyle(
                                                              color: mainColor,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                      "Rating",
                                                      style: TextStyle(
                                                          color: darkGreyColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  // width: getWidth(context) * .3,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                    left: BorderSide(
                                                        color: mainColor,
                                                        width: 1.5),
                                                    right: BorderSide(
                                                        color: mainColor,
                                                        width: 1.5),
                                                  )),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            "assets/icons/time.png",
                                                            width: 16,
                                                            color: mainColor,
                                                            height: 16,
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            "${businessItem?.deliveryTime ?? 0} mins",
                                                            style: TextStyle(
                                                                color:
                                                                    mainColor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                        "Time",
                                                        style: TextStyle(
                                                            color:
                                                                darkGreyColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            vendor_info_screen);
                                                        // if (myKey.currentContext !=
                                                        //     null) {
                                                        //   Scrollable.ensureVisible(
                                                        //       myKey
                                                        //           .currentContext!);
                                                        // }
                                                      },
                                                      child: Image.asset(
                                                        "assets/icons/info_icon.png",
                                                        width: 24,
                                                        color: mainColor,
                                                        height: 24,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      ),
                                      SizedBox(height: 10),
                                    ]),
                              ),
                              if (provider.loading &&
                                  provider.businessCategories.isEmpty)
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: getHeight(context) * .16,
                                    ),
                                    LoadingIndicator(),
                                  ],
                                )
                              else ...[
                                // if(!showOnTop)
                                Container(
                                  key: myKey,
                                  // color: mainColorLight.withOpacity(0.25),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  height: 50,
                                  child: Visibility(
                                    visible: !showOnTop,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        ...List.generate(
                                          provider.businessCategories.length,
                                          (i) => GestureDetector(
                                            onTap: () {
                                              if (_keys != null) if (_keys![i]
                                                      .currentContext !=
                                                  null) {
                                                Scrollable.ensureVisible(
                                                  _keys![i].currentContext!,
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  curve: Curves.ease,
                                                );
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0,
                                                      vertical: 8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: provider
                                                                .businessCategories[
                                                                    i]
                                                                .id ==
                                                            selected
                                                        ? mainColor
                                                        : mainColorLight
                                                            .withOpacity(0.25),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Center(
                                                      child: Text(
                                                    "${provider.businessCategories[i].name}",
                                                    style: TextStyle(
                                                        color: provider
                                                                    .businessCategories[
                                                                        i]
                                                                    .id ==
                                                                selected
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
                                ),
                                // SizedBox(height: 20),
                                if (true)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 12),
                                    child: Column(
                                      children: [
                                        // if(provider.businessCategories.length>0)
                                        ...List.generate(
                                            provider.businessCategories.length,
                                            (index) => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                      key: _keys != null
                                                          ? _keys![index]
                                                          : null,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 18.0),
                                                      child: Text(
                                                        "${provider.businessCategories[index].name}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                            color: mainColor),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    ...List.generate(
                                                        provider
                                                                .businessCategories[
                                                                    index]
                                                                .categoryProducts
                                                                ?.length ??
                                                            0, (i) {
                                                      // int i = index < 11
                                                      //     ? index + 1
                                                      //     : Random().nextInt(11) +
                                                      //         1;
                                                      dev.log(
                                                          "length: ${provider.businessCategories.length} and $index");

                                                      int quantity = 0;
                                                      String cartId = "0";
                                                      CategoryProduct? product =
                                                          provider
                                                              .businessCategories[
                                                                  index]
                                                              .categoryProducts![i];
                                                      dynamic response =
                                                          cartProvider
                                                              .checkCartForProduct(
                                                                  product.id,
                                                                  provider
                                                                      .business
                                                                      ?.id);

                                                      dev.log(
                                                          "MJ: response from check cart ${response}");
                                                      if (response != null) {
                                                        quantity = convertNumber(
                                                            response[
                                                                "quantity"]);
                                                        cartId =
                                                            response["cartId"];
                                                        // setState(() {
                                                        // });
                                                      }

                                                      dynamic onIncrease =
                                                          () async {
                                                        await cartProvider
                                                            .updateProductCartQuantity(
                                                                cartId,
                                                                quantity + 1);
                                                      };
                                                      dynamic add = () async {
                                                        Cart item = Cart(
                                                          title: product.name,
                                                          storeProductId:
                                                              product.id,
                                                          image: product.image,
                                                          price: product.price
                                                              .toString(),
                                                          totalPrice: product
                                                              .price
                                                              .toString(),
                                                          addOns: [],
                                                          comment: product
                                                                  .description ??
                                                              "",
                                                          qty: "1",
                                                          storeId: provider
                                                              .business?.id,
                                                        );
                                                        await cartProvider
                                                            .addToCart(
                                                                cartItem: item);
                                                        showToast(
                                                            "Added to cart");
                                                        // Navigator.pop(context);
                                                      };
                                                      dynamic onDecrease =
                                                          () async {
                                                        await cartProvider
                                                            .updateProductCartQuantity(
                                                                cartId,
                                                                quantity - 1);
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
                                                            type: AlertType
                                                                .WARNING,
                                                            onPress: () {
                                                              Navigator.pop(
                                                                  context);
                                                              add();
                                                            },
                                                          );
                                                        }
                                                      }

                                                      return BuildSlideTransition(
                                                          child:
                                                              RestaurantFoodItem(
                                                            type: storeType,
                                                            product: product,
                                                            quantity: quantity,
                                                            onIncrease:
                                                                onIncrease,
                                                            addToCart:
                                                                addToCart,
                                                            onDecrease:
                                                                onDecrease,
                                                          ),
                                                          animationDuration:
                                                              (i + 1) * 500,
                                                          curve: Curves
                                                              .elasticInOut,
                                                          startPos: 2.0);
                                                    }).toList()
                                                  ],
                                                )).toList(),
                                      ],
                                    ),
                                  )
                              ],
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
                onNotification: (ScrollNotification scroll) {
                  var currentContext = myKey.currentContext;
                  if (currentContext == null) return false;

                  var renderObject = currentContext.findRenderObject();
                  print(
                      "in onNotification: ${RenderAbstractViewport.of(renderObject)}");

                  if (renderObject != null) {
                    final double yPosition = (renderObject as RenderBox)
                        .localToGlobal(Offset.zero)
                        .dy; // !
                    print(
                        'Widget is visible in the viewport at position: $yPosition');
                    if (yPosition <= 85) {
                      if (!showOnTop) {
                        setState(() {
                          showOnTop = true;
                          top = 55;
                        });
                        if (_controller!.status != AnimationStatus.forward) {
                          _controller!.forward();
                          print('forward animation');
                        } else {
                          _controller!.reverse();
                          print('reverse animation');
                        }
                      }
                    } else {
                      if (showOnTop)
                        setState(() {
                          showOnTop = false;
                          top = 40;
                        });
                    }
                    // do stuff...
                  } else {
                    print('Widget is not visible.');
                    // do stuff...
                  }

                  return false;

                  if (renderObject != _prevRenderObject) {
                    RenderAbstractViewport? viewport =
                        RenderAbstractViewport.of(renderObject);
                    if (viewport != null) {
                      _offsetToRevealBottom =
                          viewport.getOffsetToReveal(renderObject!, 1.0).offset;
                      _offsetToRevealTop =
                          viewport.getOffsetToReveal(renderObject, 0.0).offset;
                    }
                  }
                  print(
                      "offsets: $_offsetToRevealBottom and $_offsetToRevealTop");

                  final offset = scroll.metrics.pixels;

                  if (_offsetToRevealBottom < offset &&
                      offset < _offsetToRevealTop) {
                    if (!showOnTop) setState(() => showOnTop = true);

                    if (_controller!.status != AnimationStatus.forward) {
                      _controller!.forward();
                    }
                  } else {
                    if (_controller!.status != AnimationStatus.reverse) {
                      _controller!.reverse();
                    }
                  }
                  return false;
                },
              ),
              // if (showOnTop)
              AnimatedPositioned(
                // key: myKey,
                duration: Duration(milliseconds: 600),
                top: top,
                child: Visibility(
                  visible: showOnTop,
                  child: AnimatedBuilder(
                    builder: (BuildContext context, Widget? child) =>
                        Opacity(opacity: _controller!.value, child: child),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: getWidth(context),
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...List.generate(
                            provider.businessCategories.length,
                            (i) => GestureDetector(
                              onTap: () {
                                if (_keys != null) if (_keys![i]
                                        .currentContext !=
                                    null) {
                                  Scrollable.ensureVisible(
                                    _keys![i].currentContext!,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.ease,
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: provider
                                                  .businessCategories[i].id ==
                                              selected
                                          ? mainColor
                                          : mainColorLight.withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Center(
                                        child: Text(
                                      "${provider.businessCategories[i].name}",
                                      style: TextStyle(
                                          color: provider.businessCategories[i]
                                                      .id ==
                                                  selected
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
                    animation: this._controller!,
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
      }),
    );
  }
}



class RestaurantFoodItem extends StatelessWidget {
  RestaurantFoodItem({
    Key? key,
    required this.type,
    required this.product,
    required this.quantity,
    this.addToCart,
    this.onDecrease,
    this.onIncrease,
  }) : super(key: key);

  final String type;
  final CategoryProduct product;
  final int quantity;
  final dynamic addToCart;
  final dynamic onDecrease;
  final dynamic onIncrease;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, food_detail_screen,
            arguments: {"product": product, "type": type});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Hero(
                  tag: ValueKey("${product.id}"),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ImageWithPlaceholder(
                          image: product.image,
                          prefix: MJ_Apis.productImgPath,
                          width: 110,
                          fit: BoxFit.fitWidth)),
                )),
            Expanded(
              flex: 8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 12,),
                    Text(
                      "${product.name}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black54),
                    ),
                    Text(
                      "${product.description}",
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
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "QAR ${product.price}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: labelGreenColor),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    if (quantity == 0)
                      GestureDetector(
                          onTap: addToCart,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 14),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: mainColor),
                            child: Text(
                              "+Add",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
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
                            onTap: onDecrease,
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 0),
                              decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Text(
                                  "${quantity}",
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
                            onTap: onIncrease,
                            child: Image.asset(
                              "assets/icons/plus_filled.png",
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String text;
  final setTop;
  final setShowOnTop;
  final BusinessDetailProvider provider;

  MySliverAppBar(
      {required this.expandedHeight,
      required this.setTop,
      this.text = '',
      required this.setShowOnTop,
      required this.provider,
      this.onFavoriteClick,
      required this.isFavorite});

  final bool isFavorite;
  dynamic onFavoriteClick;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double top = 0;
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Image.network(
            "${MJ_Apis.restaurantCoverImgPath}${provider.business?.coverPhoto}",
            fit: BoxFit.cover),
        if (shrinkOffset / expandedHeight > 0.5)
          Builder(builder: (context) {
            print("in builder");
            double t = expandedHeight / 2 - shrinkOffset + 40;
            setTop(t);
            setShowOnTop(shrinkOffset / expandedHeight == 1);

            return AnimatedOpacity(
              duration: Duration(milliseconds: 150),
              opacity: shrinkOffset / expandedHeight,
              child: Container(
                // duration: Duration(seconds: 1),
                color:
                    mainColor.withOpacity(shrinkOffset / expandedHeight - 0.1),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    RoundedNetworkAvatar(
                        url:
                            "${MJ_Apis.restaurantImgPath}${provider.business?.logo}"),
                    // Text("${shrinkOffset / expandedHeight}")
                  ],
                ),
              ),
            );
          }),
        AnimatedPositioned(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeIn,
          top: expandedHeight / 2 - shrinkOffset + 40,
          left: MediaQuery.of(context).size.width / 4 - 75,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: RoundedNetworkAvatar(
                url: "${MJ_Apis.restaurantImgPath}${provider.business?.logo}",
                height: 70.0,
                width: 70.0),
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
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                      Text("${text}"),
                      GestureDetector(
                        onTap: onFavoriteClick,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                      //     padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
