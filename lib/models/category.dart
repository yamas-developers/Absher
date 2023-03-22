import 'category_product.dart';

class Category {
  String? id;
  String? name;
  String? image;
  String? parentId;
  String? businessType;
  String? createdAt;
  String? updatedAt;
  int? position;
  int? status;
  int? priority;
  List<CategoryProduct>? categoryProducts;
  // List<Null> translations;

  Category(
      {this.id,
        this.name,
        this.image,
        this.parentId,
        this.businessType,
        this.position,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.priority,
        this.categoryProducts,
      // this.translations
      });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    image = json['image'];
    parentId = json['parent_id'].toString();
    businessType = json['business_type'].toString();
    position = json['position'];
    status = json['status'];
    priority = json['priority'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['category_products'] != null) {
      categoryProducts = [];
      json['category_products'].forEach((v) {
        categoryProducts!.add(CategoryProduct.fromJson(v));
      });
    }
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
    data['parent_id'] = this.parentId;
    data['business_type'] = this.businessType;
    data['position'] = this.position;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['priority'] = this.priority;
    if (this.categoryProducts != null) {
      data['category_products'] =
          this.categoryProducts!.map((v) => v.toJson()).toList();
    }
    // if (this.translations != null) {
    //   data['translations'] = this.translations.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}


