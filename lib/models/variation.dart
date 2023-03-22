import '../helpers/public_methods.dart';

class Variation {
  String? type;
  int? price;

  Variation({this.type, this.price});

  Variation.fromJson(Map<String, dynamic> json) {
    if(json == null)return;
    type = json['type'];
    price = convertNumber(json['price']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['price'] = this.price;
    return data;
  }
}