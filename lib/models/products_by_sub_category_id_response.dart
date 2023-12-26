class ProductsBySubCategoryIdResponse {
  int? id;
  String? nameOfProduct;
  String? price;
  String? quantity;
  String? availabilityOfProduct;
  String? sellerName;
  String? discount;
  String? discountStatus;
  String? image;
  ProductsBySubCategoryIdResponse(
      {this.id,
      this.nameOfProduct,
      this.price,
      this.quantity,
      this.availabilityOfProduct,
      this.discountStatus,
      this.image,
      this.sellerName,
      this.discount});
  factory ProductsBySubCategoryIdResponse.fromJson(Map<String, dynamic> json) {
    return json["availability"] == "1"
        ? ProductsBySubCategoryIdResponse(
            id: json["id"],
            availabilityOfProduct: json["availability"],
            discountStatus: json["discount_status"],
            discount: json["discount"],
            nameOfProduct: json["name"],
            price: json["price"],
            quantity: json["quantity"],
            image: json["image"],
            sellerName: json["seller"] == null ? null : json["seller"]["name"])
        : ProductsBySubCategoryIdResponse();
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
