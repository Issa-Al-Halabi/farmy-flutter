import 'package:pharma/models/attribute_response.dart';
import 'package:hive_flutter/adapters.dart';
part 'product_response.g.dart';

@HiveType(typeId: 0)
class ProductResponse {
  @HiveField(0)
  int id;

  @HiveField(1)
  String? nameOfProduct;

  @HiveField(2)
  String? price;

  @HiveField(3)
  int? quantity;

  @HiveField(4)
  int? tax;

  @HiveField(5)
  List<AttributeResponse> attributeList;

  @HiveField(6)
  String? availabilityOfProduct;

  @HiveField(7)
  String? sellerName;

  @HiveField(8)
  String? discountStatus;

  @HiveField(9)
  String? discountPrice;

  @HiveField(10)
  String? image;

  @HiveField(11)
  String? description;

  @HiveField(12)
  bool? isDiscount;

  @HiveField(13)
  bool isFavorite;

  @HiveField(14)
  String? discount;

  @HiveField(15)
  List<ProductResponse>? relatedProducts;

  @HiveField(16)
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
    this.discountPrice,
    this.isDiscount,
    this.image,
    this.description,
    this.relatedProducts,
    this.similarProducts,
    this.isFavorite = false,
    this.discount,
  });

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
            discount: json["discount"],
            attributeList: json["attributes"] == null
                ? []
                : List<AttributeResponse>.from(
                    json["attributes"].map(
                      (x) => AttributeResponse.fromJson(x),
                    ),
                  ),
            image: json["image"],
            isFavorite: json["is_favorite"] ?? false,
            relatedProducts: json["related_products"] == null
                ? []
                : List<ProductResponse>.from(
                    json["related_products"].map(
                      (x) => ProductResponse.fromJson(x),
                    ),
                  ),
            similarProducts: json["similar_products"] == null
                ? []
                : List<ProductResponse>.from(
                    json["similar_products"].map(
                      (x) => ProductResponse.fromJson(x),
                    ),
                  ),
          )
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

  static String getDiscountedPrice(String price, String discount) {
    int originalPrice = int.tryParse(price) ?? 0;
    int discountPrice = int.tryParse(discount) ?? 0;

    if (discountPrice <= 0) {
      return "";
    }

    double percentage =
        (((discountPrice / 100) * originalPrice) - originalPrice).abs();

    return percentage.toStringAsFixed(0);
  }

  static List<ProductResponse> listFromJson(List<dynamic>? json) {
    return json == null || json == []
        ? []
        : json.map((value) => ProductResponse.fromJson(value)).toList();
  }
}
