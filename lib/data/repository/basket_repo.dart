import 'package:dartz/dartz.dart';
import 'package:pharma/core/utils/api_const.dart';
import 'package:pharma/data/data_resource/local_resource/data_store.dart';
import 'package:pharma/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:pharma/models/params/payment_process_parms.dart';
import 'package:pharma/models/payment_process_response.dart';

import '../../models/product_response.dart';

class BasketRepo {

  Future<Either<String, PaymentProcessResponse>> getPaymentDetails(PaymentProcessParams paymentProcessParams) {
    return BaseApiClient.post<PaymentProcessResponse>(
        formData: paymentProcessParams.toJson(),
        queryParameters: {'lang':DataStore.instance.lang},

        url: ApiConst.getPaymentDetails,
        converter: (e) {
          return PaymentProcessResponse.fromJson(e["data"]);
        });
  }

  static Future<Either<String, PaymentProcessResponse>> getPaymentDetailBasket(List<ProductResponse> paymentProcessParams) {
    return BaseApiClient.post<PaymentProcessResponse>(
        queryParameters: {'lang':DataStore.instance.lang},
        formData: {
          "products": ProductResponse.toJsonCardList(paymentProcessParams),
        },
        url: ApiConst.getPaymentDetails,
        converter: (e) {
          return PaymentProcessResponse.fromJson(e["data"]);
        });
  }

}
