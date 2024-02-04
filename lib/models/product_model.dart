// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pharma/models/attribute_response.dart';
import 'package:pharma/models/products_by_sub_category_id_response.dart';

class ProductModel {
  int? id;
  String? name;
  String? description;
  String? price;
  String? tax;
  String? slug;
  String? quantity;
  String? status;

  String? sellerName;
  String? discountStatus;
  String? discountValue;
  String? image;


  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.tax,
    this.slug,
    this.quantity,
    this.status,

    this.sellerName,
    this.discountStatus,
    this.discountValue,

    this.image,


  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        tax: json["tax"],
        slug: json["slug"],
        quantity: json["quantity"],
        status: json["status"],
        discountValue:  json["discount"],
        discountStatus: json["discount_status"],
      image: json["image"],//todo
    );

  }







}