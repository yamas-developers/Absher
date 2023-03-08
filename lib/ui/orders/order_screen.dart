import 'dart:developer' as dev;

import 'package:absher/helpers/route_constants.dart';
import 'package:absher/ui/common_widgets/avatar.dart';
import 'package:absher/ui/common_widgets/build_slide_transition.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../helpers/app_loader.dart';
import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../models/order.dart';
import '../../providers/order/order_detail_provider.dart';
import '../../providers/order/pending_orders_provider.dart';
import '../common_widgets/language_aware_widgets.dart';
import '../common_widgets/misc_widgets.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int animationDuration = 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(
                            //   width: 4,
                            // ),
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
                              width: 4,
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
                                getString("common__search"),
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
                      SizedBox(
                        width: 0,
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
        body: SizedBox(
          height: getHeight(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
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
                          text: getString('order__current_orders'),
                        ),
                        Tab(
                          text: getString('order__past_orders'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // height: getHeight(context),
                child: TabBarView(controller: tabController, children: [
                  Consumer<PendingOrdersProvider>(
                      builder: (context, pendingOrderProvider, _) {
                    return OrdersArea(
                      orderProvider: pendingOrderProvider,
                      isPending: true,
                    );
                  }),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, top: 18, right: 12),
                    child: ListView(
                      children: [
                        ...List.generate(5, (index) {
                          if (index == 0) animationDuration = 0;
                          return BuildSlideTransition(
                            child: OrderItem(
                              orderData: Order(),
                            ),
                            animationDuration: animationDuration += 300,
                            curve: Curves.easeInBack,
                            startPos: -1.0,
                          );
                        })
                      ],
                    ),
                  ),
                ]),
              ),
              // SizedBox(
              //   height: 35,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderArea extends StatelessWidget {
  const OrderArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 18, right: 12),
      child: ListView(
        children: [
          ...List.generate(1, (index) {
            // if (index == 0) animationDuration = 0;
            return OrderItem(
              orderData: Order(),
            );
          })
        ],
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
    required this.orderData,
    this.isPending = false,
  }) : super(key: key);

  final Order orderData;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        OrderDetailProvider detailProvider = context.read<OrderDetailProvider>();
        detailProvider.orderId = orderData.id;
        detailProvider.orderItem = orderData;
        detailProvider.getData();
        Navigator.pushNamed(context, order_detail_screen);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      blurRadius: 6,
                      spreadRadius: .1,
                    ),
                  ]),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(width: 6,),
                            if (isPending)
                              Text(
                                "${getString('order__created_at')} ${orderData.createdAt??"N/A"}",
                                style: TextStyle(
                                    fontSize: 12, color: darkGreyColor),
                              )
                            else
                              Text(
                                "${getString('order__delivered_at')} 10:38pm, 20.02.2022",
                                style: TextStyle(
                                    fontSize: 12, color: darkGreyColor),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              RoundedAvatar(
                                  assetPath: 'assets/images/temp/dish.png',
                                  height: 60,
                                  width: 60),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(height: 12,),
                                Text(
                                  "${orderData.restaurant?.name}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                                Text(
                                  "${getString('common__qar')} ${orderData.orderAmount}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: mainColor),
                                ),
                                // SizedBox(height: 12,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 6,),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${getString('common__order')} #${orderData.id}",
                          style: TextStyle(fontSize: 13, color: darkGreyColor),
                        ),
                        ReflectByLanguage(
                          child: Image.asset(
                            "assets/icons/right_arrow.png",
                            color: darkGreyColor,
                            fit: BoxFit.fill,
                            width: 25,
                            // width: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // if(isPending)
                  Opacity(
                    opacity: isPending? 0.3: 1,
                    child: Container(
                      // padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: darkGreyColor))),
                      child: Row(
                        children: [
                          Expanded(
                            child: TouchableOpacity(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(color: darkGreyColor))),
                                child: Text(
                                  getString("order__re_order"),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TouchableOpacity(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  getString("order__rate_order"),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 14,
              right: isLtr(context) ? 18 : null,
              left: isLtr(context) ? null : 18,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    "assets/icons/done_icon.png",
                    width: 38,
                    height: 38,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersArea extends StatefulWidget {
  const OrdersArea({
    Key? key,
    required this.orderProvider,
    this.isPending = false,
  }) : super(key: key);
  final dynamic orderProvider;
  final bool isPending;

  @override
  State<OrdersArea> createState() => _OrdersAreaState();
}

class _OrdersAreaState extends State<OrdersArea> {
  bool initialized = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        await widget.orderProvider.getData();
        initialized = true;
      } catch (e) {
        dev.log("error in initstate: $e");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RefreshController controller = widget.orderProvider.refreshController;
    return SizedBox(
      height: getHeight(context),
      child: SmartRefresher(
        controller: controller,
        // controller: widget.resProvider.refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: BezierHeader(
          child: Center(
              child: Column(
            children: [
              AppLoader(
                size: 40.0,
                strock: 1,
              ),
            ],
          )),
          bezierColor: mainColor,
        ),
        footer: CustomFooter(
          height: 70,
          builder: smartRefreshFooter,
        ),
        onLoading: () async {
          if (!controller.isRefresh && initialized == true)
            await widget.orderProvider.getData();
        },
        onRefresh: () async {
          await widget.orderProvider.reset();
        },
        child: widget.orderProvider.loading && widget.orderProvider.list.isEmpty
            ? LoadingIndicator()
            : widget.orderProvider.list.isEmpty
                ? EmptyWidget()
                : ListView(
                    children: [
                      ...List.generate(widget.orderProvider.list.length,
                          (index) {
                        Order order = widget.orderProvider.list[index];
                        return SizedBox(
                          child: OrderItem(
                              orderData: order, isPending: widget.isPending
                              // onPress: () {
                              //   if (widget.storeType == BUSINESS_TYPE_STORE)
                              //     Navigator.pushNamed(context, grocery_store_screen,
                              //         arguments: {
                              //           "store": widget.orderProvider.list[index],
                              //         });
                              //   else
                              //     Navigator.pushNamed(
                              //         context, restaurant_detail_screen,
                              //         arguments: {
                              //           "store": widget.orderProvider.list[index],
                              //         });
                              // },
                              // resData: order,
                              // centerImageheight: 140,
                              // maxWidth: 320,
                              ),
                        );
                      })
                    ],
                  ),
      ),
    );
  }
}
