class StoreSlider {
  String? id;
  String? businessId;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;

  StoreSlider(
      {this.id,
        this.businessId,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  StoreSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    businessId = json['business_id'].toString();
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_id'] = this.businessId;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
