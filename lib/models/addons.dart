class AddOns {
  String? id;
  String? name;
  int? price;
  String? createdAt;
  String? updatedAt;
  String? restaurantId;
  String? status;
  bool available = true; ////for local use
  int qty = 0; ////for local use

  AddOns(
      {this.id,
        this.name,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.restaurantId,
        this.status,
        this.available = true,
        this.qty = 0
      });

  AddOns.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantId = json['restaurant_id'].toString();
    status = json['status'].toString();
    available = json['available']??true;
    qty = json['qty']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['restaurant_id'] = this.restaurantId;
    data['status'] = this.status;
    data['qty'] = this.qty;
    data['available'] = this.available;
    return data;
  }
}