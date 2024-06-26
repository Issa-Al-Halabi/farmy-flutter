
import 'package:pharma/models/banners_response.dart';
import 'package:pharma/models/categories_respoonse.dart';
import 'package:pharma/models/product_response.dart';
import 'package:pharma/models/user_address_response.dart';

class HomePageDynamicModel {
  int? id;
  String? type;
  String? order;
  Map<String, dynamic>? title;
  String? link;
  int? lastPagePagination;

  List<ProductResponse>? sectionContent;
  List<BannersResponse>? sliderContent;
  List<CategoriesResponse>? categoryContent;

  UserAddressModel? userAddressModel;

  HomePageDynamicModel(
      {this.id,
      this.type,
      this.order,
      this.title,
      this.link,
      this.sectionContent,
      this.lastPagePagination,
      this.userAddressModel,
      this.sliderContent});

  HomePageDynamicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    order = json['order'];
    title = json['title'];
    link = json['link'];

    userAddressModel = json["favourite_address"] != null
        ? UserAddressModel.fromJson(json["favourite_address"])
        : UserAddressModel();

    lastPagePagination = int.tryParse(json['last_page'].toString());

    if (json['type'] == "section") {
      if (json['content'] != null) {
        sectionContent = <ProductResponse>[];
        json['content'].forEach((v) {
          sectionContent!.add(ProductResponse.fromJson(v));
        });
      }
    } else if (json['type'] == "slider") {
      if (json['content'] != null) {
        sliderContent = <BannersResponse>[];
        json['content'].forEach((v) {
          sliderContent!.add(BannersResponse.fromJson(v));
        });
      }
    } else if (json['type'] == "category") {
      if (json['content'] != null) {
        categoryContent = <CategoriesResponse>[];
        json['content'].forEach((v) {
          categoryContent!.add(CategoriesResponse.fromJson(v));
        });
      }
    }
  }

  // List<HomePageDynamicModel> fromJsonList(
  //     List<Map<dynamic, dynamic>> listJson) {
  //   List<HomePageDynamicModel> returnedList = [];
  //   for (var json in listJson) {
  //     returnedList.add(HomePageDynamicModel.fromJson(json));
  //   }
  //   return returnedList;
  // }

  static List<HomePageDynamicModel> fromJsonList(List<dynamic>? json) {
    return json == null
        ? []
        : json.map((value) => HomePageDynamicModel.fromJson(value)).toList();
  }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['type'] = type;
//     data['order'] = order;
//     if (title != null) {
//       data['title'] = title!.toJson();
//     }
//     data['link'] = link;
//     if (sectionContent != null) {
//       data['content'] = sectionContent!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
}

class Seller {
  int? id;
  String? name;

  Seller({this.id, this.name});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Commission {
  int? id;
  String? name;
  String? commissionValue;

  Commission({this.id, this.name, this.commissionValue});

  Commission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    commissionValue = json['commission_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['commission_value'] = commissionValue;
    return data;
  }
}

class Attributes {
  int? id;
  String? name;
  String? value;

  Attributes({this.id, this.name, this.value});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
