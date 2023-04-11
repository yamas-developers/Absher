import 'package:absher/helpers/constants.dart';
import 'package:absher/ui/common_widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/mj_apis.dart';
import '../../helpers/public_methods.dart';
import '../../models/cart.dart';
import '../../providers/settings/settings_provider.dart';
import 'language_aware_widgets.dart';
import 'misc_widgets.dart';

class CartItem extends StatelessWidget {
  final Cart item;
  final dynamic onIncrease;
  final dynamic onDecrease;
  final dynamic onDelete;
  final Color bgColor;

  const CartItem({Key? key,
    required this.item,
    this.onIncrease = null,
    this.onDecrease = null,
    this.onDelete, this.bgColor = const Color.fromRGBO(255, 255, 255, 0.1)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, _) {
        return Container(
          padding:
          item.available ? EdgeInsets.fromLTRB(6, 6, 6, 6) : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: bgColor,
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
                                Text("${settingsProvider.zone?.zoneData?.first.currency?.currencySymbol??'--'} ${item.price} ",
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

                                SizedBox(
                                  height: 6,
                                ),
                                if(item.variant!=null)
                                Text("Variant: ${item.variant?.type}",
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
                                        (index) =>
                                        Column(
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
                                                  "${settingsProvider.zone?.zoneData?.first.currency?.currencySymbol??'--'} ${item.addOns?[index]
                                                      .price}",
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
              if (!item.available /*|| true*/)
                Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        // color: Color.fromRGBO(255, 255, 255, 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Unavailable",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          InkWell(
                            onTap: onDelete,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/icons/trash.png",
                                  width: 20,
                                ),
                                Text(
                                  "Delete Item",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
            ],
          ),
        );
      }
    );
  }
}