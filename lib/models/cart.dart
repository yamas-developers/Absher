
import 'dart:convert';
import 'dart:developer';

import 'package:absher/models/product.dart';

import '../helpers/db/sqf_object.dart';
import 'addons.dart';
import 'variation.dart';

class Cart extends MJObject<Cart> {
  static String STORE_NAME = 'cart';
  static String PRIMARY_KEY = 'id';
  static final query = """CREATE TABLE if not exists """ +
      STORE_NAME +
      """(
   id   INTEGER  NOT NULL PRIMARY KEY
  ,store_product_id   TEXT  NOT NULL
  ,qty TEXT
  ,title TEXT
  ,image TEXT
  ,store_id  TEXT,
  price TEXT,
  total_price TEXT,
  comment TEXT,
  available INT,
  add_ons TEXT,
  variant TEXT
  );""";
  String? id;
  String? title;
  String? storeProductId;
  String? qty;
  String? price;
  String? totalPrice;
  String? comment;
  String? image;
  String? storeId;
  bool available;
  List<AddOns>? addOns;
  Variation? variant;

  Cart(
      {this.id,
        this.title,
        this.storeProductId,
        this.qty,
        this.storeId,
        this.price,
        this.totalPrice,
        this.comment,
        this.image,
        this.addOns,
        this.available = true,
        this.variant
      });

  @override
  Map<String, dynamic> toMap(Cart cart) {
    Map<String,dynamic> data = {};
    data['id'] = cart.id;
    data['title'] = cart.title;
    data['store_product_id'] = cart.storeProductId;
    data['qty'] = cart.qty;
    data['store_id'] = cart.storeId;
    data['price'] = cart.price;
    data['total_price'] = cart.totalPrice;
    data['comment'] = cart.comment;
    data['available'] = cart.available?1:0;
    data['image'] = cart.image;
    if (cart.addOns != null) {
      data['add_ons'] = json.encode(cart.addOns!.map((v) => v.toJson()).toList());
    }
    data["variant"] = cart.variant == null ? null : json.encode(cart.variant?.toJson());
    return data;
  }
  @override
  Map<String, dynamic> toRequestMap(Cart cart) {
    Map<String,dynamic> data = {};
    data['id'] = cart.id;
    data['title'] = cart.title;
    data['store_product_id'] = cart.storeProductId;
    data['qty'] = cart.qty;
    data['store_id'] = cart.storeId;
    data['price'] = cart.price;
    data['total_price'] = cart.totalPrice;
    data['comment'] = cart.comment;
    data['available'] = cart.available?1:0;
    data['image'] = cart.image;
    if (cart.addOns != null) {
      data['add_ons'] = json.encode(cart.addOns!.map((v) => v.toJson()).toList());
    }
    Variation? variant = data["variant"] == null ? null : Variation.fromJson(json.decode(data["variant"]));

    return data;
  }

  @override
  Cart fromMap(dynamic data) {

      List<AddOns>? adds = [];
      if(data['add_ons']!=null){
      List? datum = json.decode(data['add_ons']);
    if (datum != null) {
      datum.forEach((v) {
        adds.add(AddOns.fromJson(v));
      });
    }
      }


      Variation? variant = data["variant"] == null ? null : Variation.fromJson(json.decode(data["variant"]));

    return Cart(
      id: data['id'].toString(),
      title: data['title'].toString(),
      storeProductId: data['store_product_id'].toString(),
      qty: data['qty'],
      storeId: data['store_id'],
      price: data['price'],
      comment: data['comment'],
      available: data['available']==1?true:false,
      image: data['image'],
      totalPrice: data['total_price'],
      addOns: adds,
      variant: variant
    );
  }

  toList(List<dynamic> data) {
    List<Cart> list = [];
    for (int i = 0; i < data.length; i++) {
      Cart object = this.fromMap(data[i]);
      list.add(object);
    }
    return list;
  }

  @override
  List<Cart> fromMapList(List data) {
    List<Cart> list = [];
    for (int i = 0; i < data.length; i++) {
      Cart object = this.fromMap(data[i]);
      list.add(object);
    }
    return list;
  }

  @override
  String getPrimaryKey() {
    // TODO: implement getPrimaryKey
    // throw UnimplementedError();
    return this.id!;
  }

  @override
  List<Map<String, dynamic>> toMapList(List<Cart> objectList) {
    List<Map<String, dynamic>> list = [];
    for (int i = 0; i < objectList.length; i++) {
      list.add(this.toMap(objectList[i]));
    }
    return list;
  }
  @override
  List<Map<String, dynamic>> toRequestMapList(List<Cart> objectList) {
    List<Map<String, dynamic>> list = [];
    for (int i = 0; i < objectList.length; i++) {
      list.add(this.toRequestMap(objectList[i]));
    }
    return list;
  }
}