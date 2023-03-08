import '../../models/addons.dart';
import '../../models/category_ids.dart';
import '../../models/choice_options.dart';
import '../../models/variations.dart';

class OrderDetails {
  String? id;
  String? foodId;
  String? orderId;
  int? price;
  FoodDetails? foodDetails;
  List<Variations>? variation;
  List<AddOns>? addOns;
  int? discountOnFood;
  String? discountType;
  int? quantity;
  int? taxAmount;
  String? variant;
  String? createdAt;
  String? updatedAt;
  String? itemCampaignId;
  int? totalAddOnPrice;

  OrderDetails(
      {this.id,
        this.foodId,
        this.orderId,
        this.price,
        this.foodDetails,
        this.variation,
        this.addOns,
        this.discountOnFood,
        this.discountType,
        this.quantity,
        this.taxAmount,
        this.variant,
        this.createdAt,
        this.updatedAt,
        this.itemCampaignId,
        this.totalAddOnPrice});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    foodId = json['food_id'].toString();
    orderId = json['order_id'].toString();
    price = json['price'];
    foodDetails = json['food_details'] != null
        ? FoodDetails.fromJson(json['food_details'])
        : null;
    if (json['variation'] != null) {
      variation = [];
      json['variation'].forEach((v) {
        variation?.add(Variations.fromJson(v));
      });
    }
    if (json['add_ons'] != null) {
      addOns = [];
      json['add_ons'].forEach((v) {
        addOns?.add(AddOns.fromJson(v));
      });
    }
    discountOnFood = json['discount_on_food'];
    discountType = json['discount_type'];
    quantity = json['quantity'];
    taxAmount = json['tax_amount'];
    variant = json['variant'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    itemCampaignId = json['item_campaign_id'];
    totalAddOnPrice = json['total_add_on_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['food_id'] = this.foodId;
    data['order_id'] = this.orderId;
    data['price'] = this.price;
    if (this.foodDetails != null) {
      data['food_details'] = this.foodDetails?.toJson();
    }
    if (this.variation != null) {
      data['variation'] = this.variation?.map((v) => v.toJson()).toList();
    }
    if (this.addOns != null) {
      data['add_ons'] = this.addOns?.map((v) => v.toJson()).toList();
    }
    data['discount_on_food'] = this.discountOnFood;
    data['discount_type'] = this.discountType;
    data['quantity'] = this.quantity;
    data['tax_amount'] = this.taxAmount;
    data['variant'] = this.variant;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['item_campaign_id'] = this.itemCampaignId;
    data['total_add_on_price'] = this.totalAddOnPrice;
    return data;
  }
}

class FoodDetails {
  String? id;
  String? name;
  String? description;
  String? image;
  String? categoryId;
  List<CategoryIds>? categoryIds;
  List<Variations>? variations;
  List<AddOns>? addOns;
  List<String>? attributes;
  List<ChoiceOptions>? choiceOptions;
  int? price;
  int? tax;
  String? taxType;
  int? discount;
  String? discountType;
  String? availableTimeStarts;
  String? availableTimeEnds;
  int? veg;
  int? status;
  String? restaurantId;
  String? createdAt;
  String? updatedAt;
  int? orderCount;
  int? avgRating;
  int? ratingCount;
  String? restaurantName;
  int? restaurantDiscount;
  String? restaurantOpeningTime;
  String? restaurantClosingTime;
  bool? scheduleOrder;

  FoodDetails(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.categoryId,
        this.categoryIds,
        this.variations,
        this.addOns,
        this.attributes,
        this.choiceOptions,
        this.price,
        this.tax,
        this.taxType,
        this.discount,
        this.discountType,
        this.availableTimeStarts,
        this.availableTimeEnds,
        this.veg,
        this.status,
        this.restaurantId,
        this.createdAt,
        this.updatedAt,
        this.orderCount,
        this.avgRating,
        this.ratingCount,
        this.restaurantName,
        this.restaurantDiscount,
        this.restaurantOpeningTime,
        this.restaurantClosingTime,
        this.scheduleOrder});

  FoodDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    description = json['description'];
    image = json['image'];
    categoryId = json['category_id'].toString();
    if (json['category_ids'] != null) {
      categoryIds = [];
      json['category_ids'].forEach((v) {
        categoryIds?.add(CategoryIds.fromJson(v));
      });
    }
    if (json['variations'] != null) {
      variations = [];
      json['variations'].forEach((v) {
        variations?.add(Variations.fromJson(v));
      });
    }
    if (json['add_ons'] != null) {
      addOns = [];
      json['add_ons'].forEach((v) {
        addOns?.add(new AddOns.fromJson(v));
      });
    }
    attributes = json['attributes'].cast<String>();
    if (json['choice_options'] != null) {
      choiceOptions = [];
      json['choice_options'].forEach((v) {
        choiceOptions?.add(new ChoiceOptions.fromJson(v));
      });
    }
    price = json['price'];
    tax = json['tax'];
    taxType = json['tax_type'];
    discount = json['discount'];
    discountType = json['discount_type'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    veg = json['veg'];
    status = json['status'];
    restaurantId = json['restaurant_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderCount = json['order_count'];
    avgRating = json['avg_rating'];
    ratingCount = json['rating_count'];
    restaurantName = json['restaurant_name'];
    restaurantDiscount = json['restaurant_discount'];
    restaurantOpeningTime = json['restaurant_opening_time'];
    restaurantClosingTime = json['restaurant_closing_time'];
    scheduleOrder = json['schedule_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    if (this.categoryIds != null) {
      data['category_ids'] = this.categoryIds?.map((v) => v.toJson()).toList();
    }
    if (this.variations != null) {
      data['variations'] = this.variations?.map((v) => v.toJson()).toList();
    }
    if (this.addOns != null) {
      data['add_ons'] = this.addOns?.map((v) => v.toJson()).toList();
    }
    data['attributes'] = this.attributes;
    if (this.choiceOptions != null) {
      data['choice_options'] =
          this.choiceOptions?.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['available_time_starts'] = this.availableTimeStarts;
    data['available_time_ends'] = this.availableTimeEnds;
    data['veg'] = this.veg;
    data['status'] = this.status;
    data['restaurant_id'] = this.restaurantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order_count'] = this.orderCount;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_discount'] = this.restaurantDiscount;
    data['restaurant_opening_time'] = this.restaurantOpeningTime;
    data['restaurant_closing_time'] = this.restaurantClosingTime;
    data['schedule_order'] = this.scheduleOrder;
    return data;
  }
}
