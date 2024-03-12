

import 'package:pharma/models/attribute_response.dart';


class ProductResponse {
  int id;
  String? nameOfProduct;
  String? price;
  int? quantity;
  int? tax;
  List<AttrbiuteResponse> attributeList;
  String? availabilityOfProduct;
  String? sellerName;
  String? discountStatus;
  String? discountValue;
  String? image;
  String? description;
  bool? isDiscount;
  bool isFavorite;
  String? discount;

  List<ProductResponse>? relatedProducts;
  List<ProductResponse>? similarProducts;

  ProductResponse({
    required this.id,
    this.nameOfProduct,
    this.price,
    this.tax,
    this.quantity,
    this.attributeList = const [],
    this.availabilityOfProduct,
    this.sellerName,
    this.discountStatus,
    this.discountValue,
    this.isDiscount,
    this.image,
    this.description,
    this.relatedProducts,
    this.similarProducts,
    this.isFavorite=false,
    this.discount
  });
  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return json["availability"] == "1"
        ? ProductResponse(
            id: json["id"],
        tax: json["tax"] != null ? int.parse(json["tax"]) : null,

        quantity: json["quantity"] != null ? int.parse(json["quantity"]) : null,

        description: json["description"],
            discountStatus: json["discount_status"],
            discountValue: json["discount_status"] != 0
                ? getDiscountedPrice(json["price"], json["discount"])
                : json["discount"],
            sellerName: json["seller"] == null ? null : json["seller"]["name"],
            nameOfProduct: json["name"],
            price: json["price"],
        discount: json["discount_status"] != 0
                ? getDiscountedPrice(json["price"], json["discount"])
                : json["discount"],
            attributeList: json["attributes"] == null
                ? []
                : List<AttrbiuteResponse>.from(json["attributes"]
                    .map((x) => AttrbiuteResponse.fromJson(x))),
            image: json["image"],
        isFavorite: json["is_favorite"] ?? false,
            relatedProducts: json["related_products"] == null
                ? []
                : List<ProductResponse>.from(
                    json["related_products"].map(
                        (x) => ProductResponse.fromJson(x))),
            similarProducts: json["related_products"] == null
                ? []
                : List<ProductResponse>.from(
                    json["similar_products"].map(
                        (x) => ProductResponse.fromJson(x))))
        : ProductResponse( id: 0,);
  }
  static Map<String, dynamic> toJsonCard(
      ProductResponse productDetailsResponse) {
    return {
      "product_id": productDetailsResponse.id,
      "quantity": productDetailsResponse.quantity
    };
  }

  static List<Map<String, dynamic>> toJsonCardList(
      List<ProductResponse>? basketList) {
    return basketList == null
        ? []
        : basketList
            .map((value) => ProductResponse.toJsonCard(value))
            .toList();
  }

  static String getDiscountedPrice(String price, String discount) {
    int originalPrice = int.parse(price);
    int discountPrcie = int.parse(discount);

    int percantge = (((discountPrcie * 100) / originalPrice)).round();

    return percantge.toString();
  }

  static List<ProductResponse> listFromJson(
      List<dynamic>? json) {
    return json == null
        ? []
        : json
            .map((value) => ProductResponse.fromJson(value))
            .toList();
  }
}
