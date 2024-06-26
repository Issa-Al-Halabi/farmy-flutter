import 'package:dartz/dartz.dart';
import 'package:pharma/core/utils/api_const.dart';
import 'package:pharma/data/data_resource/local_resource/data_store.dart';
import 'package:pharma/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:pharma/models/track_model.dart';

class TrackingRepo {
  static Future<Either<String, TrackingModel>> getTracking(int id) {
    return BaseApiClient.get<TrackingModel>(
        url: ApiConst.getTrackOrderDetails(id),
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return TrackingModel.fromJson(e["data"]);
        });
  }

  static Future<Either<String, String>> getOrderVerify(int id) {
    return BaseApiClient.get<String>(
        url: ApiConst.getOrderVerifyCode(id),
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return e;
        });
  }
}
