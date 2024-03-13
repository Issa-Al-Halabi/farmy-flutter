// ignore_for_file: public_member_api_docs, sort_constructors_first
class InvoicesParams {
  int userAddressId;
  int deliveryMethodId;
  String notes;
  String? time;

  InvoicesParams({
    required this.userAddressId,
    required this.deliveryMethodId,
    this.notes = " ",
    required this.time,
  });
}
