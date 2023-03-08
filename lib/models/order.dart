import 'package:absher/models/restaurant.dart';

import 'delivery_address.dart';

class Order {
  String? id;
  String? userId;
  int? orderAmount;
  int? couponDiscountAmount;
  String? couponDiscountTitle;
  String? paymentStatus;
  String? orderStatus;
  int? totalTaxAmount;
  String? paymentMethod;
  String? transactionReference;
  String? deliveryAddressId;
  String? deliveryManId;
  String? couponCode;
  String? orderNote;
  String? orderType;
  int? checked;
  String? restaurantId;
  String? createdAt;
  String? updatedAt;
  int? deliveryCharge;
  String? scheduleAt;
  String? callback;
  String? otp;
  String? pending;
  String? accepted;
  String? confirmed;
  String? processing;
  String? handover;
  String? pickedUp;
  String? delivered;
  String? canceled;
  String? refundRequested;
  String? refunded;
  DeliveryAddress? deliveryAddress;
  int? scheduled;
  int? restaurantDiscountAmount;
  int? originalDeliveryCharge;
  String? failed;
  String? adjusment;
  int? edited;
  String? zoneId;
  int? dmTips;
  String? processingTime;
  String? freeDeliveryBy;
  int? detailsCount;
  Business? restaurant;
  String? deliveryMan;

  Order(
      {this.id,
        this.userId,
        this.orderAmount,
        this.couponDiscountAmount,
        this.couponDiscountTitle,
        this.paymentStatus,
        this.orderStatus,
        this.totalTaxAmount,
        this.paymentMethod,
        this.transactionReference,
        this.deliveryAddressId,
        this.deliveryManId,
        this.couponCode,
        this.orderNote,
        this.orderType,
        this.checked,
        this.restaurantId,
        this.createdAt,
        this.updatedAt,
        this.deliveryCharge,
        this.scheduleAt,
        this.callback,
        this.otp,
        this.pending,
        this.accepted,
        this.confirmed,
        this.processing,
        this.handover,
        this.pickedUp,
        this.delivered,
        this.canceled,
        this.refundRequested,
        this.refunded,
        this.deliveryAddress,
        this.scheduled,
        this.restaurantDiscountAmount,
        this.originalDeliveryCharge,
        this.failed,
        this.adjusment,
        this.edited,
        this.zoneId,
        this.dmTips,
        this.processingTime,
        this.freeDeliveryBy,
        this.detailsCount,
        this.restaurant,
        this.deliveryMan});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    orderAmount = json['order_amount'];
    couponDiscountAmount = json['coupon_discount_amount'];
    couponDiscountTitle = json['coupon_discount_title'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    totalTaxAmount = json['total_tax_amount'];
    paymentMethod = json['payment_method'];
    transactionReference = json['transaction_reference'];
    deliveryAddressId = json['delivery_address_id'].toString();
    deliveryManId = json['delivery_man_id'].toString();
    couponCode = json['coupon_code'];
    orderNote = json['order_note'];
    orderType = json['order_type'];
    checked = json['checked'];
    restaurantId = json['restaurant_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryCharge = json['delivery_charge'];
    scheduleAt = json['schedule_at'];
    callback = json['callback'];
    otp = json['otp'];
    pending = json['pending'];
    accepted = json['accepted'];
    confirmed = json['confirmed'];
    processing = json['processing'];
    handover = json['handover'];
    pickedUp = json['picked_up'];
    delivered = json['delivered'];
    canceled = json['canceled'];
    refundRequested = json['refund_requested'];
    refunded = json['refunded'];
    deliveryAddress = json['delivery_address'] != null
        ? DeliveryAddress.fromJson(json['delivery_address'])
        : null;
    scheduled = json['scheduled'];
    restaurantDiscountAmount = json['restaurant_discount_amount'];
    originalDeliveryCharge = json['original_delivery_charge'];
    failed = json['failed'];
    adjusment = json['adjusment'];
    edited = json['edited'];
    zoneId = json['zone_id'].toString();
    dmTips = json['dm_tips'];
    processingTime = json['processing_time'];
    freeDeliveryBy = json['free_delivery_by'];
    detailsCount = json['details_count'];
    restaurant = json['restaurant'] != null
        ? Business.fromJson(json['restaurant'])
        : null;
    deliveryMan = json['delivery_man'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_amount'] = this.orderAmount;
    data['coupon_discount_amount'] = this.couponDiscountAmount;
    data['coupon_discount_title'] = this.couponDiscountTitle;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['payment_method'] = this.paymentMethod;
    data['transaction_reference'] = this.transactionReference;
    data['delivery_address_id'] = this.deliveryAddressId;
    data['delivery_man_id'] = this.deliveryManId;
    data['coupon_code'] = this.couponCode;
    data['order_note'] = this.orderNote;
    data['order_type'] = this.orderType;
    data['checked'] = this.checked;
    data['restaurant_id'] = this.restaurantId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['delivery_charge'] = this.deliveryCharge;
    data['schedule_at'] = this.scheduleAt;
    data['callback'] = this.callback;
    data['otp'] = this.otp;
    data['pending'] = this.pending;
    data['accepted'] = this.accepted;
    data['confirmed'] = this.confirmed;
    data['processing'] = this.processing;
    data['handover'] = this.handover;
    data['picked_up'] = this.pickedUp;
    data['delivered'] = this.delivered;
    data['canceled'] = this.canceled;
    data['refund_requested'] = this.refundRequested;
    data['refunded'] = this.refunded;
    if (this.deliveryAddress != null) {
      data['delivery_address'] = this.deliveryAddress?.toJson();
    }
    data['scheduled'] = this.scheduled;
    data['restaurant_discount_amount'] = this.restaurantDiscountAmount;
    data['original_delivery_charge'] = this.originalDeliveryCharge;
    data['failed'] = this.failed;
    data['adjusment'] = this.adjusment;
    data['edited'] = this.edited;
    data['zone_id'] = this.zoneId;
    data['dm_tips'] = this.dmTips;
    data['processing_time'] = this.processingTime;
    data['free_delivery_by'] = this.freeDeliveryBy;
    data['details_count'] = this.detailsCount;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant?.toJson();
    }
    data['delivery_man'] = this.deliveryMan;
    return data;
  }
}

