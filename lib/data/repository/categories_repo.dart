import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pharma/core/utils/api_const.dart';
import 'package:pharma/data/data_resource/local_resource/data_store.dart';
import 'package:pharma/models/categories_respoonse.dart';
import 'package:pharma/models/category_by_id_response.dart';


import '../../models/product_response.dart';
import '../data_resource/remote_resource/api_handler/base_api_client.dart';

class CategoriesRepo {
  Future<Either<String, List<CategoriesResponse>>> getALLCategories() {
    return BaseApiClient.get<List<CategoriesResponse>>(
        url: ApiConst.getAllCategories,
        converter: (e) {
          return CategoriesResponse.listFromJson(e["data"]);
        });
  }

  Future<Either<String, CategoryByIdResponse>> getSubCategoryById(int id) {
    BaseApiClient.getTargetCancelToken.cancel("cancel");
    BaseApiClient.getTargetCancelToken = CancelToken();
    return BaseApiClient.get<CategoryByIdResponse>(
        cancelToken: BaseApiClient.getTargetCancelToken,
        url: ApiConst.getSubCategories(id),
        converter: (e) {
          return CategoryByIdResponse.fromJson(e["data"]);
        });
  }

  Future<Either<String, List<ProductResponse>>>
      getProductsBySubCategoriesId(int id) {
    BaseApiClient.getTargetCancelToken.cancel("cancel");
    BaseApiClient.getTargetCancelToken = CancelToken();
    return BaseApiClient.get<List<ProductResponse>>(
        cancelToken: BaseApiClient.getTargetCancelToken,
        queryParameters: {"subCategoryId": id,'lang':DataStore.instance.lang},
        url: ApiConst.getProductBySubCategoryId,
        converter: (e) {
          return ProductResponse.listFromJson(e["data"]);
        });
  }
}
