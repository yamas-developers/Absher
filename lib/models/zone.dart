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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zone_id'] = this.zoneId;
    if (this.zoneData != null) {
      data['zone_data'] = this.zoneData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ZoneData {
  String? id;
  int? status;
  int? minimumShippingCharge;
  int? perKmShippingCharge;
  String? currency;
  String? currency_symbol;

  ZoneData({
    this.id,
    this.status,
    this.minimumShippingCharge,
    this.perKmShippingCharge,
    this.currency,
    this.currency_symbol
  });

  ZoneData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    status = json['status'];
    minimumShippingCharge = json['minimum_shipping_charge'];
    perKmShippingCharge = json['per_km_shipping_charge'];
    currency = json['currency'];
    currency_symbol = json['currency_symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['minimum_shipping_charge'] = this.minimumShippingCharge;
    data['per_km_shipping_charge'] = this.perKmShippingCharge;
    data['currency'] = this.currency;
    data['currency_symbol'] = this.currency_symbol;
    return data;
  }
}
