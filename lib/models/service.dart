import 'dart:developer';

class AbsherService {
  String? id;
  String? name;
  String? image;
  String? description;
  String? userId;
  int? status;
  String? waNumber;
  String? zoneId;
  String? createdAt;
  String? updatedAt;

  AbsherService(
      {this.id,
        this.name,
        this.description,
        this.userId,
        this.status,
        this.waNumber,
        this.zoneId,
        this.createdAt,
        this.updatedAt});

  AbsherService.fromJson(Map<String, dynamic> json) {

    id = json['id'].toString();
    name = json['name'];
    image = json['image'];
    description = json['description'];
    userId = json['user_id'].toString();
    status = json['status'];
    waNumber = json['wa_number'].toString();
    zoneId = json['zone_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['wa_number'] = this.waNumber;
    data['zone_id'] = this.zoneId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
