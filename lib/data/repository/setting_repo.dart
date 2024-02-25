import 'package:dartz/dartz.dart';
import 'package:pharma/core/utils/api_const.dart';
import 'package:pharma/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:pharma/models/setting_model.dart';

class SettingRepo {
  static Future<Either<String, SettingModel>> getSetting() {
    return BaseApiClient.get<SettingModel>(
        url: ApiConst.getSetting,
        converter: (e) {
          return SettingModel.fromJson(e);
        });
  }
}