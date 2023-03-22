import 'package:absher/models/restaurant.dart';

class Campaign {
  String? id;
  String? title;
  String? image;
  String? description;
  String? adminId;
  String? createdAt;
  String? updatedAt;
  String? startTime;
  String? endTime;
  String? availableDateStarts;
  String? availableDateEnds;
  int? status;
  List<Business>? restaurants;
  List<dynamic>? translations;

  Campaign(
      {this.id,
        this.title,
        this.image,
        this.description,
        this.status,
        this.adminId,
        this.createdAt,
        this.updatedAt,
        this.startTime,
        this.endTime,
        this.availableDateStarts,
        this.availableDateEnds,
        this.restaurants,
        this.translations});

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    adminId = json['admin_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    availableDateStarts = json['available_date_starts'];
    availableDateEnds = json['available_date_ends'];
    if (json['restaurants'] != null) {
      restaurants = [];
      json['restaurants'].forEach((v) {
        restaurants!.add(Business.fromJson(v));
      });
    }
    // TODO: add translations in compaigns model
    if (json['translations'] != null) {
      translations = [];
      json['translations'].forEach((v) {
        translations!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['status'] = this.status;
    data['admin_id'] = this.adminId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['available_date_starts'] = this.availableDateStarts;
    data['available_date_ends'] = this.availableDateEnds;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants!.map((v) => v.toJson()).toList();
    }
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


