// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pharma/models/attribute_response.dart';
import 'package:pharma/models/products_by_sub_category_id_response.dart';

class ProductDetailsResponse {
  int? id;
  String? nameOfProduct;
  String? price;
  String? quantity;
  List<AttrbiuteResponse> attributeList;
  String? availabilityOfProduct;
  String? sellerName;
  String? discountStatus;
  String? discountValue;
  String? image;
  String? description;
  bool? isDiscount;

  List<ProductsBySubCategoryIdResponse>? relatedProducts;
  List<ProductsBySubCategoryIdResponse>? similarProducts;
  ProductDetailsResponse({
    this.id,
    this.nameOfProduct,
    this.price,
    this.quantity,
    this.attributeList=const[],
    this.availabilityOfProduct,
    this.sellerName,
    this.discountStatus,
    this.discountValue,
    this.isDiscount,
    this.image,
    this.description,
    this.relatedProducts,
    this.similarProducts,
  });
  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    return json["availability"] == "1"
        ? ProductDetailsResponse(
            id: json["id"],
            description: json["description"],
            discountStatus: json["discount_status"],
            discountValue: json["discount_status"] != 0
                ? getDiscountedPrice(json["price"], json["discount"])
                : json["discount"],
            sellerName: json["seller"] == null ? null : json["seller"]["name"],
            nameOfProduct: json["name"],
            price: json["price"],
            attributeList: json["attributes"] == null
                ? []
                : List<AttrbiuteResponse>.from(json["attributes"]
                    .map((x) => AttrbiuteResponse.fromJson(x))),
            image: json["image"],
            relatedProducts: json["related_products"] == null
                ? []
                : List<ProductsBySubCategoryIdResponse>.from(
                    json["related_products"].map(
                        (x) => ProductsBySubCategoryIdResponse.fromJson(x))),
            similarProducts: json["related_products"] == null
                ? []
                : List<ProductsBySubCategoryIdResponse>.from(
                    json["similar_products"].map(
                        (x) => ProductsBySubCategoryIdResponse.fromJson(x))))
        : ProductDetailsResponse();
  }
  static Map<String, dynamic> toJsonCard(
      ProductDetailsResponse productDetailsResponse) {
    return {
      "id": productDetailsResponse.id,
      "quantity": productDetailsResponse.quantity
    };
  }

  static List<Map<String, dynamic>> toJsonCardList(
      List<ProductDetailsResponse>? basketList) {
    return basketList == null
        ? []
        : basketList.map((value) => ProductDetailsResponse.toJsonCard(value)).toList();
  }

  static String getDiscountedPrice(String price, String discount) {
    int originalPrice = int.parse(price);
    int discountPrcie = int.parse(discount);

    int percantge = (((discountPrcie * 100) / originalPrice)).round();

    return percantge.toString();
  }

  static List<ProductsBySubCategoryIdResponse> listFromJson(
      List<dynamic>? json) {
    return json == null
        ? []
        : json
            .map((value) => ProductsBySubCategoryIdResponse.fromJson(value))
            .toList();
  }
}