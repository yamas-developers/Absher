import 'package:absher/helpers/route_constants.dart';
import 'package:absher/ui/account_screen.dart';
import 'package:absher/ui/cart/cart_screen.dart';
import 'package:absher/ui/express_delivery/express_details_screen.dart';
import 'package:absher/ui/home/home_screen.dart';
import 'package:absher/ui/orders/thankyou_screen.dart';
import 'package:absher/ui/registeration/otp_verification_screen.dart';
import 'package:absher/ui/registeration/signup_screen.dart';
import 'package:absher/ui/services/service_provider_screen.dart';
import 'package:absher/ui/services/services_screen.dart';
import 'package:flutter/material.dart';

import '../search_screen.dart';
import '../ui/bottom_bar_page.dart';
import '../ui/cart/checkout_screen.dart';
import '../ui/express_delivery/express_delivery_screen.dart';
import '../ui/favorites/favorites_screen.dart';
import '../ui/grocery/category_detail_screen.dart';
import '../ui/grocery/grocery_store_screen.dart';
import '../ui/home/map_view.dart';
import '../ui/intro_screens/language_screen.dart';
import '../ui/intro_screens/splash_screen.dart';
import '../ui/loyalty/points_balance_screen.dart';
import '../ui/notification/notifications_screen.dart';
import '../ui/orders/order_detail_screen.dart';
import '../ui/orders/order_screen.dart';
import '../ui/profile/edit_profile.dart';
import '../ui/registeration/login_screen.dart';
import '../ui/registeration/terms_and_condition_screen.dart';
import '../ui/vendor/filter_screen.dart';
import '../ui/vendor/food_detail_screen.dart';
import '../ui/vendor/restaurant_detail.dart';
import '../ui/vendor/restaurant_screen.dart';
import '../ui/vendor/vendor_info_screen.dart';
import 'animate_route.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (BuildContext buildContext) {
        return SplashScreen(); //splash screen
      });
    case home_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: BottomAppBarPage(), routeName: home_screen);
    case language_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: LanguageScreen(), routeName: language_screen);
    case login_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: LoginScreen(), routeName: login_screen);
    case signup_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: SignupScreen(), routeName: signup_screen);

      case edit_profile_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: EditProfile(), routeName: edit_profile_screen);

    case terms_and_condition_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: TermsAndConditionScreen(), routeName: terms_and_condition_screen);

      case otp_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: OtpVerificationScreen(), routeName: otp_screen);

      case map_view:
      print(settings.name);
      return routeOne(
          settings: settings, widget: MapView(), routeName: map_view);

    case cart_screen:
      print(settings.name);
      return routeOne(
          settings: settings, widget: CartScreen(), routeName: cart_screen);

    case restaurant_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: RestaurantScreen(),
          routeName: restaurant_screen);
    case restaurant_detail_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: RestaurantDetailScreen(),
          routeName: restaurant_detail_screen);
    case restaurant_detail_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: SearchScreen(),
          routeName: restaurant_detail_screen);
    case favorite_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: FovoritesScreen(),
          routeName: favorite_screen);

    case account_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: AccountScreen(),
          routeName: account_screen);
    case grocery_store_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: GroceryStoreScreen(),
          routeName: grocery_store_screen);

    case category_detail_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: CategoryDetailScreen(),
          routeName: category_detail_screen);

    case services_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: ServicesScreen(),
          routeName: services_screen);

    case service_provider_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: ServiceProviderScreen(),
          routeName: service_provider_screen);

      case points_balance_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: PointsBalanceScreen(),
          routeName: points_balance_screen);
    case notifications_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: NotificationsScreen(),
          routeName: notifications_screen);

      case order_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: OrderScreen(),
          routeName: order_screen);
    case thankyou_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: ThankyouScreen(),
          routeName: thankyou_screen);

    case express_delivery_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: ExpressDeliveryScreen(),
          routeName: express_delivery_screen);

    case express_details_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: ExpressDetailsScreen(),
          routeName: express_details_screen);

      case order_detail_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: OrderDetailScreen(),
          routeName: order_detail_screen);

    case filter_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: FilterScreen(),
          routeName: filter_screen);
      case vendor_info_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: VendorInfoScreen(),
          routeName: vendor_info_screen);
      case food_detail_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: FoodDetailScreen(),
          routeName: food_detail_screen);
      case checkout_screen:
      print(settings.name);
      return routeOne(
          settings: settings,
          widget: ChecoutScreen(),
          routeName: checkout_screen);

    default:
      print("default");
      return routeOne(
          settings: settings,
          widget: HomeScreen(), //login screen
          routeName: home_screen);
  }
}
