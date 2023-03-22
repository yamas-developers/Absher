class CategoryProduct {
  String? id;
  String? name;
  String? image;
  String? description;
  int? price;
  String? availableTimeStarts;
  String? availableTimeEnds;
  String? categoryId;
  // List<Null> translations;

  CategoryProduct(
      {this.id,
        this.name,
        this.image,
        this.description,
        this.price,
        this.availableTimeStarts,
        this.availableTimeEnds,
        this.categoryId,
        // this.translations
      });

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    availableTimeStarts = json['available_time_starts'];
    availableTimeEnds = json['available_time_ends'];
    categoryId = json['category_id'].toString();
    // if (json['translations'] != null) {
    //   translations = new List<Null>();
    //   json['translations'].forEach((v) {
    //     translations.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['price'] = this.price;
    data['available_time_starts'] = this.availableTimeStarts;
    data['available_time_ends'] = this.availableTimeEnds;
    data['category_id'] = this.categoryId;
    // if (this.translations != null) {
    //   data['translations'] = this.translations.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}