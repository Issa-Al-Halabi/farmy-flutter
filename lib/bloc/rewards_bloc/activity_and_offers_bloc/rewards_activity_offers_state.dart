import 'package:equatable/equatable.dart';
import 'package:pharma/core/app_enum.dart';
import 'package:pharma/models/reward/reward_activity_coupons_model.dart';
import 'package:pharma/models/reward/reward_my_coupons_model.dart';
import 'package:pharma/models/reward/reward_offers_coupons_model.dart';

class RewardsActivityAndOffersState extends Equatable {
  final bool rewardsActivityAndOffersSuccess;
  final bool rewardsActivityAndOffersHasError;
  final bool rewardsActivityAndOffersHasSuc;
  final String rewardsActivityAndOffersError;
  final bool rewardsActivityAndOffersLoading;
  final bool? rewardsActivityAndOffersByCouponLoading;
  final RewardMyCouponsModel? rewardMyCouponsModel;
  final RewardCouponsActivityModel? rewardCouponsActivityModel;
  final RewardsOffersModel? rewardsOffersModel;
  final RewardsActivityStateEnum rewardsActivityStateEnum;

  const RewardsActivityAndOffersState({
    required this.rewardsActivityAndOffersSuccess,
    required this.rewardsActivityAndOffersLoading,
    required this.rewardsActivityAndOffersHasError,
    required this.rewardsActivityAndOffersHasSuc,
    required this.rewardsActivityAndOffersError,
    required this.rewardsActivityStateEnum,
     this.rewardsActivityAndOffersByCouponLoading,
    this.rewardMyCouponsModel,
    this.rewardCouponsActivityModel,
    this.rewardsOffersModel,
  });

  RewardsActivityAndOffersState copyWith({
    bool? rewardsActivityAndOffersSuccess,
    bool? rewardsActivityAndOffersLoading,
    bool? rewardsActivityAndOffersHasSuc,
    bool? rewardsActivityAndOffersByCouponLoading,
    bool? rewardsActivityAndOffersHasError,
    String? rewardsActivityAndOffersError,
    RewardMyCouponsModel? rewardMyCouponsModel,
    RewardCouponsActivityModel? rewardCouponsActivityModel,
    RewardsActivityStateEnum? rewardsActivityStateEnum,
    RewardsOffersModel? rewardsOffersModel,
  }) {
    return RewardsActivityAndOffersState(
      rewardsActivityAndOffersLoading: rewardsActivityAndOffersLoading ??
          this.rewardsActivityAndOffersLoading,
      rewardsActivityAndOffersSuccess: rewardsActivityAndOffersSuccess ??
          this.rewardsActivityAndOffersSuccess,
      rewardsActivityAndOffersHasError: rewardsActivityAndOffersHasError ??
          this.rewardsActivityAndOffersHasError,
      rewardsActivityAndOffersError:
          rewardsActivityAndOffersError ?? this.rewardsActivityAndOffersError,
      rewardCouponsActivityModel:
          rewardCouponsActivityModel ?? this.rewardCouponsActivityModel,
      rewardMyCouponsModel: rewardMyCouponsModel ?? this.rewardMyCouponsModel,
      rewardsOffersModel: rewardsOffersModel ?? this.rewardsOffersModel,
      rewardsActivityStateEnum: rewardsActivityStateEnum ?? this.rewardsActivityStateEnum,
      rewardsActivityAndOffersHasSuc: rewardsActivityAndOffersHasSuc ?? this.rewardsActivityAndOffersHasSuc,
      rewardsActivityAndOffersByCouponLoading: rewardsActivityAndOffersByCouponLoading ?? this.rewardsActivityAndOffersByCouponLoading,
    );
  }

  @override
  List<Object?> get props => [
        rewardsActivityAndOffersSuccess,
        rewardsActivityAndOffersLoading,
        rewardsActivityAndOffersHasError,
        rewardsActivityAndOffersError,
        rewardMyCouponsModel,
        rewardsOffersModel,
        rewardCouponsActivityModel,
        rewardsActivityStateEnum,
    rewardsActivityAndOffersHasSuc,
    rewardsActivityAndOffersByCouponLoading,
      ];
}
