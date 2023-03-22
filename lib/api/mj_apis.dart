class MJ_Apis{
  static const APP_BASE_URL = "https://absher.junaidali.tk/";
  // static const APP_BASE_URL = "http://127.0.0.1:8000/";
  static const BASE_URL = APP_BASE_URL+"api/v1/";
  static const storagePath = "storage/app/public/";
  /////////path to the images
  static const bannerImgPath = APP_BASE_URL+ storagePath+"banner/";
  static const restaurantCoverImgPath = APP_BASE_URL+ storagePath+"restaurant/cover/";
  static const restaurantImgPath = APP_BASE_URL+ storagePath+"restaurant/";
  static const productImgPath = APP_BASE_URL+ storagePath+"product/";
  static const categoryImgPath = APP_BASE_URL+ storagePath+"category/";
  static const serviceImgPath = APP_BASE_URL+ storagePath+"service/";
  static const profileImgPath = APP_BASE_URL+ storagePath+"profile/";

  static const signup = "auth/sign-up";
  static const login = "auth/login";
  static const customer_info = "customer/info";
  static const banners = "banners";
  static const get_zone_id = "config/get-zone-id";
  static const get_all_restaurants = "restaurants/get-restaurants/all"; //get request
  static const get_delivery_restaurants = "restaurants/get-restaurants/delivery"; //get request
  static const get_takeaway_restaurants = "restaurants/get-restaurants/takeaway"; //get request
  static const get_businees_detail = "restaurants/details"; //get request
  static const get_businees_slider = "banners/business"; //get request (?id=2)
  static const get_express_categories = "express/get_express_categories"; //get request (?id=2)
  static const get_express_place_order = "express/place_express_order"; //post request (?id=2)
  static const get_services = "business/get_services"; //get request
  static const get_searched_businees = "restaurants/search"; //get request (?name=guru)
  static const get_popular_businees = "restaurants/popular"; //get request top 5
  static const get_product_detail = "products/details"; //get request
  static const sync_all_products = "products/sync"; //post request {"ids":"[1]"}
  static const categories = "categories"; //get request
  static const get_sub_categories = "categories/childes"; //get request /{cat id}/{business id}
  static const categories_products = "categories/products"; //post request {"category_ids":[32,37],"restaurant_id": 1}
  static const get_favorites = "customer/wish-list"; //get request /user id
  static const remove_favorites = "customer/wish-list/remove"; //get request /user id
  static const add_favorites = "customer/wish-list/add"; //get request /user id
  static const update_profile = "customer/update-profile"; //post request
  static const place_order = "customer/order/place"; //post request
  static const pending_order_list = "customer/order/running-orders"; //get request
  static const order_details = "customer/order/details"; //get request

  //////////

}
