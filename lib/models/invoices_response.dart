// ignore_for_file: public_member_api_docs, sort_constructors_first
class InvociesResponse {
  int? total;
  int? coponValue;
  int? deliveryValue;
  int? tax;
  int? subTotal;

  InvociesResponse({
    this.total,
    this.coponValue,
    this.deliveryValue,
    this.tax,
    this.subTotal,
  });

  factory InvociesResponse.formJson(Map<String, dynamic> json) {
    return InvociesResponse(
      subTotal: json["subtotal"],
      coponValue: json["coupon_price"],
      deliveryValue: json["delivery_price"],
      tax: json["tax"],
      total: json["total"],
    );
  }
}
