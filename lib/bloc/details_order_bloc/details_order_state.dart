import 'package:equatable/equatable.dart';

import '../../core/app_enum.dart';
import '../../models/order_details_model.dart';

class DetailsOrderState extends Equatable {
  ScreenStates screenStates;

  bool isLoading;
  int totalPrice;
  String error;
  final bool success;
  List<OrderDetailsModel> productList;

  DetailsOrderState({
    this.screenStates = ScreenStates.loading,
    this.isLoading = false,
    this.success = false,
    this.totalPrice = 0,
    this.error = '',
    this.productList = const [],
  });

  DetailsOrderState copyWith({
    ScreenStates? screenStates,
    bool? isLoading,
    bool? success,
    int? totalPrice,
    String? error,
    List<OrderDetailsModel>? productList,
  }) {
    return DetailsOrderState(
      screenStates: screenStates ?? ScreenStates.initialized,
      isLoading: isLoading ?? false,
      success: success ?? false,
      error: error ?? '',
      productList: productList ?? this.productList,
      totalPrice: totalPrice ?? 0,

    );
  }

  @override
  List<Object?> get props => [
        identityHashCode(this),
        screenStates,
        isLoading,
        success,
        error,
        productList,
    totalPrice
      ];
}

