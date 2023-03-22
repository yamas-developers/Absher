import 'dart:developer';

class Business {
  String? id;
  String? vendorId;
  String? name;
  String? phone;
  String? email;
  String? logo;
  String? latitude;
  String? longitude;
  String? address;
  String? footerText;
  String? comission;
  String? createdAt;
  String? updatedAt;
  String? coverPhoto;
  String? offDay;
  String? deliveryTime;
  String? availableTimeStarts;
  String? availableTimeEnds;
  String? gstCode;
  int? minimumOrder;
  int? status;
  int? tax;
  int? zoneId;
  int? selfDeliverySystem;
  int? minimumShippingCharge;
  int? veg;
  int? nonVeg;
  int? orderCount;
  int? totalOrder;
  int? perKmShippingCharge;
  int? avgRating;
  int? ratingCount;
  bool freeDelivery = false;
  bool scheduleOrder = false;
  bool delivery = false;
  bool takeAway = false;
  bool foodSection = false;
  bool reviewsSection  = false;
  bool active = false;
  bool posSystem = false;
  bool gstStatus = false;
  BusinessType? businessType;
  int? campaignId;
  int? restaurantId;
  int? open;
  List<int>? categoryIds;
  List<int>? foodCategoryIds;
  int? discount;
  List<Schedules>? schedules;

  Business(
      {this.id,
        this.name,
        this.phone,
        this.email,
        this.logo,
        this.latitude,
        this.longitude,
        this.address,
        this.footerText,
        this.minimumOrder,
        this.comission,
        this.scheduleOrder = false,
        this.status,
        this.vendorId,
        this.createdAt,
        this.updatedAt,
        this.freeDelivery = false,
        this.coverPhoto,
        this.delivery = false,
        this.takeAway = false,
        this.foodSection = false,
        this.tax,
        this.zoneId,
        this.reviewsSection = false,
        this.active = false,
        this.offDay,
        this.selfDeliverySystem,
        this.posSystem = false,
        this.minimumShippingCharge,
        this.deliveryTime,
        this.veg,
        this.nonVeg,
        this.orderCount,
        this.totalOrder,
        this.perKmShippingCharge,
        this.businessType,
        this.campaignId,
        this.restaurantId,
        this.open,
        this.availableTimeStarts,
        this.availableTimeEnds,
        this.avgRating,
        this.ratingCount,
        this.gstStatus = false,
        this.gstCode,
        this.categoryIds,
      this.foodCategoryIds,
      this.discount,
      this.schedules
        });

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    logo = json['logo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    footerText = json['footer_text'];
    minimumOrder = json['minimum_order'];
    comission = json['comission'];
    scheduleOrder = json['schedule_order'] ?? false;
    status = json['status'];
    vendorId = json['vendor_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    freeDelivery = json['free_delivery'] ?? false;
    coverPhoto = json['cover_photo'];
    delivery = json['delivery'] ?? false;
    takeAway = json['take_away']  ?? false;
    foodSection = json['food_section']  ?? false;
    tax = json['tax'];
    zoneId = json['zone_id'];
    reviewsSection = json['reviews_section'] ?? false;
    active = json['active'] ?? false;
    offDay = json['off_day'];
    selfDeliverySystem = json['self_delivery_system'];
    posSystem = json['pos_system'] ?? false;
    minimumShippingCharge = json['minimum_shipping_charge'];
    deliveryTime = json['delivery_time'];
    veg = json['veg'];
    nonVeg = json['non_veg'];
    orderCount = json['order_count'];
    totalOrder = json['total_order'];
    perKmShippingCharge = json['per_km_shipping_charge'];
    businessType = json['business_type'] != null && json['business_type'] is Map
        ? BusinessType.fromJson(json['business_type'])
        : null;

    campaignId = json['campaign_id'];
    restaurantId = json['restaurant_id'];
    open = json['open'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count '];
    gstStatus = json['gst_status'] ?? false;
    gstCode = json['gst_code'];
    categoryIds = json['category_ids']?.cast<int>();
    // log("MJ in ${json['category_ids']?.cast<int>()??0}");
    foodCategoryIds = json['food_category_ids']?.cast<int>();
    discount = json['discount'] is int ? json['discount'] : null;
    if (json['schedules'] != null) {
      schedules = [];
      json['schedules'].forEach((v) {
        schedules!.add(new Schedules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['logo'] = this.logo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['footer_text'] = this.footerText;
    data['minimum_order'] = this.minimumOrder;
    data['comission'] = this.comission;
    data['schedule_order'] = this.scheduleOrder;
    data['status'] = this.status;
    data['vendor_id'] = this.vendorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['free_delivery'] = this.freeDelivery;
    data['cover_photo'] = this.coverPhoto;
    data['delivery'] = this.delivery;
    data['take_away'] = this.takeAway;
    data['food_section'] = this.foodSection;
    data['tax'] = this.tax;
    data['zone_id'] = this.zoneId;
    data['reviews_section'] = this.reviewsSection;
    data['active'] = this.active;
    data['off_day'] = this.offDay;
    data['self_delivery_system'] = this.selfDeliverySystem;
    data['pos_system'] = this.posSystem;
    data['minimum_shipping_charge'] = this.minimumShippingCharge;
    data['delivery_time'] = this.deliveryTime;
    data['veg'] = this.veg;
    data['non_veg'] = this.nonVeg;
    data['order_count'] = this.orderCount;
    data['total_order'] = this.totalOrder;
    data['per_km_shipping_charge'] = this.perKmShippingCharge;
    if (this.businessType != null) {
      data['business_type'] = this.businessType!.toJson();
    }
    data['campaign_id'] = this.campaignId;
    data['restaurant_id'] = this.restaurantId;
    data['open'] = this.open;
    data['available_time_starts'] = this.availableTimeStarts;
    data['available_time_ends'] = this.availableTimeEnds;
    data['avg_rating'] = this.avgRating;
    data['rating_count '] = this.ratingCount;
    data['gst_status'] = this.gstStatus;
    data['gst_code'] = this.gstCode;
    data['category_ids'] = this.categoryIds;
    data['food_category_ids'] = this.foodCategoryIds;
    data['discount'] = this.discount;
    if (this.schedules != null) {
      data['schedules'] = this.schedules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessType {
  String? id;
  String? type;
  String? createdAt;

  BusinessType({this.id, this.type, this.createdAt});

  BusinessType.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    return data;
  }
}
class Schedules {
  String? id;
  String? restaurantId;
  String? day;
  String? openingTime;
  String? closingTime;
  String? createdAt;
  String? updatedAt;

  Schedules(
      {this.id,
      this.restaurantId,
      this.day,
      this.openingTime,
      this.closingTime,
      this.createdAt,
      this.updatedAt});

  Schedules.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    restaurantId = json['restaurant_id'].toString();
    day = json['day'].toString();
    openingTime = json['opening_time'].toString();
    closingTime = json['closing_time'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['day'] = this.day;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}