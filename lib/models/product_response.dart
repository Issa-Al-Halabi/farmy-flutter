import 'package:pharma/models/attribute_response.dart';

class ProductResponse {
  int id;
  String? nameOfProduct;
  String? price;
  int? quantity;
  int? tax;
  List<AttributeResponse> attributeList;
  String? availabilityOfProduct;
  String? sellerName;
  String? discountStatus;
  String? discountPrice;
  String? image;
  String? description;
  bool? isDiscount;
  bool isFavorite;
  String? discount;

  List<ProductResponse>? relatedProducts;
  List<ProductResponse>? similarProducts;

  ProductResponse(
      {required this.id,
      this.nameOfProduct,
      this.price,
      this.tax,
      this.quantity,
      this.attributeList = const [],
      this.availabilityOfProduct,
      this.sellerName,
      this.discountStatus,
      this.discountPrice,
      this.isDiscount,
      this.image,
      this.description,
      this.relatedProducts,
      this.similarProducts,
      this.isFavorite = false,
      this.discount});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return (json["availability"].toString() == "1")
        ? ProductResponse(
            id: json["id"],
            tax: json["tax"] != null ? int.parse(json["tax"]) : null,
            quantity:
                json["quantity"] != null ? int.parse(json["quantity"]) : null,
            description: json["description"],
            discountStatus: json["discount_status"],
            discountPrice: json["discount"] != "0"
                ? getDiscountedPrice(
                    json["price"].toString(), json["discount"].toString())
                : json["price"],
            sellerName: json["seller"] == null ? null : json["seller"]["name"],
            nameOfProduct: json["name"],
            price: json["price"],
            discount:
                json["discount"],
            attributeList: json["attributes"] == null
                ? []
                : List<AttributeResponse>.from(json["attributes"]
                    .map((x) => AttributeResponse.fromJson(x))),
            image: json["image"],
            isFavorite: json["is_favorite"] ?? false,
            relatedProducts: json["related_products"] == null
                ? []
                : List<ProductResponse>.from(json["related_products"]
                    .map((x) => ProductResponse.fromJson(x))),
            similarProducts: json["similar_products"] == null
                ? []
                : List<ProductResponse>.from(json["similar_products"]
                    .map((x) => ProductResponse.fromJson(x))))
        : ProductResponse(
            id: 0,
          );
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
        : basketList.map((value) => ProductResponse.toJsonCard(value)).toList();
  }

  //
  // static String getDiscountedPrice(String price, String discount) {
  //   print("getDiscountedPrice");
  //   print(price);
  //   print(discount);
  //   int originalPrice = int.parse(price);
  //   int discountPrice = int.parse(discount);
  //
  //   int  percentage = ((originalPrice * 100) / discountPrice).round();
  //
  //   return  percentage.toString();
  // }
  static String getDiscountedPrice(String price, String discount) {
    int originalPrice = int.tryParse(price) ?? 0;
    int discountPrice = int.tryParse(discount) ?? 0;

    print('================================');
    print(discountPrice / 100);
    print(originalPrice);
    print((((discountPrice / 100) * originalPrice) - originalPrice).abs());
    print('================================');

    if (discountPrice <= 0) {
      return "";
    }

    double percentage = (((discountPrice / 100) * originalPrice) - originalPrice).abs();

    return percentage.toStringAsFixed(0);
  }

  static List<ProductResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => ProductResponse.fromJson(value)).toList();
  }
}
