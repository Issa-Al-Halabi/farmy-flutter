// ignore_for_file: public_member_api_docs, sort_constructors_first
class BannersResponse {
  int id;
  String? type;
  String? bannerLink;
  BannersResponse({
    required this.id,
    this.type,
    this.bannerLink,
  });

  factory BannersResponse.fromJson(Map<String, dynamic> json) {
    return BannersResponse(
        id: json["id"], bannerLink: json["link"], type: json["type"]);
  }
  static List<BannersResponse> listFromJson(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => BannersResponse.fromJson(value)).toList();
  }
}
