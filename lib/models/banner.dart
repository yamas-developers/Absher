import 'package:absher/models/restaurant.dart';

class Bannerr {
  String? id;
  String? title;
  String? type;
  String? image;
  String? food;
  Business? restaurant;

  Bannerr(
      {this.id, this.title, this.type, this.image, this.restaurant, this.food});

  Bannerr.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'];
    type = json['type'];
    image = json['image'];
    restaurant = json['restaurant'] != null
        ?  Business.fromJson(json['restaurant'])
        : null;
    food = json['food'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['image'] = this.image;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    data['food'] = this.food;
    return data;
  }
}