import '../helpers/public_methods.dart';

class Variations {
  String? type;
  int? price;

  Variations({this.type, this.price});

  Variations.fromJson(Map<String, dynamic> json) {
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