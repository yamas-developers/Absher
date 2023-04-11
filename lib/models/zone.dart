class Zone {
  String? zoneId;
  List<ZoneData>? zoneData;

  Zone({this.zoneId, this.zoneData});

  Zone.fromJson(Map<String, dynamic> json) {
    zoneId = json['zone_id'];
    if (json['zone_data'] != null) {
      zoneData = [];
      json['zone_data'].forEach((v) {
        zoneData!.add(ZoneData.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['zone_id'] = this.zoneId;
  //   if (this.zoneData != null) {
  //     data['zone_data'] = this.zoneData!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class ZoneData {
  String? id;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? restaurantWiseTopic;
  String? customerWiseTopic;
  String? deliverymanWiseTopic;
  double? minimumShippingCharge;
  double? perKmShippingCharge;
  // int? currencyId;
  int? timezoneId;
  // String? currency_symbol;
  Currency? currency;

  ZoneData({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.restaurantWiseTopic,
    this.customerWiseTopic,
    this.deliverymanWiseTopic,
    this.minimumShippingCharge,
    this.perKmShippingCharge,
    // this.currencyId,
    this.timezoneId,
    this.currency,
    // this.currency_symbol
  });

  ZoneData.fromJson(Map<String, dynamic> json) {
    String symbol = 'QAR';
    if(json['currenci']!=null && json['currenci']['currency_symbol'] !=null){
      symbol = json['currenci']['currency_symbol'];
    }
    id = json['id'].toString();
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantWiseTopic = json['restaurant_wise_topic'];
    customerWiseTopic = json['customer_wise_topic'];
    deliverymanWiseTopic = json['deliveryman_wise_topic'];
    minimumShippingCharge = json['minimum_shipping_charge']?.toDouble();
    perKmShippingCharge = json['per_km_shipping_charge']?.toDouble();
    // currencyId = json['currency_id'];
    timezoneId = json['timezone_id'];
    // currency_symbol = symbol;
    currency = json['currenci'] != null ? Currency.fromJson(json['currenci']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['status'] = this.status;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   data['restaurant_wise_topic'] = this.restaurantWiseTopic;
  //   data['customer_wise_topic'] = this.customerWiseTopic;
  //   data['deliveryman_wise_topic'] = this.deliverymanWiseTopic;
  //   data['minimum_shipping_charge'] = this.minimumShippingCharge;
  //   data['per_km_shipping_charge'] = this.perKmShippingCharge;
  //   data['currency_id'] = this.currencyId;
  //   data['timezone_id'] = this.timezoneId;
  //   if (this.currency != null) {
  //     data['currenci'] = this.currency?.toJson();
  //   }
  //   return data;
  // }
}

class Currency {
  String? id;
  String? country;
  String? currencyCode;
  String? currencySymbol;
  String? exchangeRate;
  String? createdAt;
  String? updatedAt;

  Currency({
    this.id,
    this.country,
    this.currencyCode,
    this.currencySymbol,
    this.exchangeRate,
    this.createdAt,
    this.updatedAt,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'].toString(),
      country: json['country'],
      currencyCode: json['currency_code'],
      currencySymbol: json['currency_symbol'],
      exchangeRate: json['exchange_rate'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

