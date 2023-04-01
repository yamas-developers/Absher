
import 'package:absher/providers/business/business_detail_provider.dart';
import 'package:absher/providers/business/takeaway_pharma_provider.dart';
import 'package:absher/providers/cart/cart_provider.dart';
import 'package:absher/providers/order/order_detail_provider.dart';
import 'package:absher/providers/settings/settings_provider.dart';
import 'package:absher/providers/user/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'business/delivery_pharma_provider.dart';
import 'business/delivery_restaurant_provider.dart';
import 'business/express_provider.dart';
import 'business/grocery_store_provider.dart';
import 'business/product_detail_provider.dart';
import 'business/restaurant_provider.dart';
import 'business/service_provider.dart';
import 'business/store_detail_provider.dart';
import 'business/takeaway_restaurant_provider.dart';
import 'location/location_provider.dart';
import 'order/past_orders_provider.dart';
import 'order/pending_orders_provider.dart';
import 'other/favorite_provider.dart';
import 'other/search_business_provider.dart';


List<SingleChildWidget> providers = [
  ...independentProviders
];

List<SingleChildWidget> independentProviders = [
  ChangeNotifierProvider<LocationProvider>(
      create: (_) => LocationProvider()),
  ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(), lazy: false,),
  ChangeNotifierProvider<SettingsProvider>(
      create: (_) => SettingsProvider()),
  ChangeNotifierProvider<DeliveryRestaurantProvider>(
      create: (_) => DeliveryRestaurantProvider()),
  ChangeNotifierProvider<TakeawayRestaurantProvider>(
      create: (_) => TakeawayRestaurantProvider()),
  ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider()),
  ChangeNotifierProvider<TakeawayPharmaProvider>(
      create: (_) => TakeawayPharmaProvider()),
  ChangeNotifierProvider<DeliveryPharmaProvider>(
      create: (_) => DeliveryPharmaProvider()),
  ChangeNotifierProvider<GroceryStoreProvider>(
      create: (_) => GroceryStoreProvider()),
  ChangeNotifierProvider<BusinessDetailProvider>(
      create: (_) => BusinessDetailProvider()),
  ChangeNotifierProvider<ProductDetailProvider>(
      create: (_) => ProductDetailProvider()),
  ChangeNotifierProvider<CartProvider>(
      create: (_) => CartProvider(), lazy: false,),
  ChangeNotifierProvider<StoreDetailProvider>(
      create: (_) => StoreDetailProvider(),),

  ChangeNotifierProvider<FavoriteProvider>(
      create: (_) => FavoriteProvider(),),
  ChangeNotifierProvider<SearchBusinessProvider>(
      create: (_) => SearchBusinessProvider(),),

  ChangeNotifierProvider<ServiceProvider>(
      create: (_) => ServiceProvider(),),

  ChangeNotifierProvider<ExpressProvider>(
      create: (_) => ExpressProvider(),),
  ChangeNotifierProvider<PendingOrdersProvider>(
      create: (_) => PendingOrdersProvider(),),
  ChangeNotifierProvider<PastOrdersProvider>(
      create: (_) => PastOrdersProvider(),),
  ChangeNotifierProvider<OrderDetailProvider>(
      create: (_) => OrderDetailProvider(),),
];
