import 'package:dartz/dartz.dart';
import 'package:pharma/core/utils/api_const.dart';
import 'package:pharma/data/data_resource/local_resource/data_store.dart';
import 'package:pharma/data/data_resource/remote_resource/api_handler/base_api_client.dart';
import 'package:pharma/models/home_response.dart';
import 'package:pharma/models/params/rewards_by_coupon_params.dart';
import 'package:pharma/models/reward/reward_activity_coupons_model.dart';
import 'package:pharma/models/reward/reward_history_point_used_model.dart';
import 'package:pharma/models/reward/reward_my_coupons_model.dart';
import 'package:pharma/models/reward/reward_guide_model.dart';
import 'package:pharma/models/reward/reward_history_model.dart';
import 'package:pharma/models/reward/reward_membership_guide_model.dart';
import 'package:pharma/models/reward/reward_offers_coupons_model.dart';
import 'package:pharma/models/reward/reward_rank_user_model.dart';

import '../../models/reward/reward_buy_coupon_model.dart';

/// TODO Needs to edit
class RewardsRepo {
  static Future<Either<String, HomeResponse>> getHomeData() {
    return BaseApiClient.get<HomeResponse>(
        url: ApiConst.getAllRewards,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return HomeResponse.fromJson(e["data"]);
        });
  }

  static Future<Either<String, RewardGuideModel>> getRewardGuide() {
    return BaseApiClient.get<RewardGuideModel>(
        url: ApiConst.getRewardsGuide,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return RewardGuideModel.fromJson(e);
        });
  }

  static Future<Either<String, RewardMembershipGuideModel>>
      getRewardMemberShipGuide() {
    return BaseApiClient.get<RewardMembershipGuideModel>(
        url: ApiConst.getRewardsMemberShipGuide,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return RewardMembershipGuideModel.fromJson(e);
        });
  }

  static Future<Either<String, RewardHistoryModel>>
      getRewardHistoryPointsExpired() {
    return BaseApiClient.get<RewardHistoryModel>(
        url: ApiConst.getRewardsPointHistoryExpired,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return RewardHistoryModel.fromJson(e);
        });
  }

  static Future<Either<String, RewardsUsedPointsModel>> getRewardHistoryPointsUsed() {
    return BaseApiClient.get<RewardsUsedPointsModel>(
        url: ApiConst.getRewardsPointHistoryUsed,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return RewardsUsedPointsModel.fromJson(e);
        });
  }

  static Future<Either<String, RewardHistoryModel>>
      getRewardHistoryPointsValid() {
    return BaseApiClient.get<RewardHistoryModel>(
        url: ApiConst.getRewardsPointHistoryValid,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return RewardHistoryModel.fromJson(e);
        });
  }

  static Future<Either<String, RewardMyCouponsModel>> getRewardMyCoupons() {
    return BaseApiClient.get<RewardMyCouponsModel>(
        url: ApiConst.getRewardMyCoupons,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return RewardMyCouponsModel.fromJson(e);
        });
  }

  static Future<Either<String, RewardCouponsActivityModel>>
      getRewardActivity() {
    return BaseApiClient.get<RewardCouponsActivityModel>(
        url: ApiConst.getRewardActivityCoupons,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return RewardCouponsActivityModel.fromJson(e);
        });
  }

  static Future<Either<String, RewardsRankUserModel>> getRewardRankUser() {
    return BaseApiClient.get<RewardsRankUserModel>(
        url: ApiConst.getRewardsRankUser,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return RewardsRankUserModel.fromJson(e);
        });
  }

  static Future<Either<String, RewardsOffersModel>>
      getRewardOffersCouponUser() {
    return BaseApiClient.get<RewardsOffersModel>(
        url: ApiConst.getRewardsOfferCoupon,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return RewardsOffersModel.fromJson(e);
        });
  }

  static Future<Either<String, BuyCouponModel>> buyCoupon(
      {required BuyCouponParams buyCouponParams}) {
    return BaseApiClient.post<BuyCouponModel>(
        formData: buyCouponParams.toJson(),
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        url: ApiConst.buyCoupon,
        converter: (e) {
          return BuyCouponModel.fromJson(e);
        });
  }
}
