part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  final int? orderId;
  final ScreenStates? screenState;
  final OrderStates? orderState;
  final PaymentStates? paymentState;
  final PaymentProcessResponse? paymentProcessResponse;
  final List<DeliveryAttributesResponse> attributeChosenList;
  final List<DeliveryMethodResponse> deliveryMethodChosenList;
  final List<DeliveryChangesResponse> deliveryChangesList;
  final int? deliveryCost;
  final CompletePaymentStates? completePaymentStates;
  final String? errorMessage;
  final String? time;
  final String? hour;
  final String? minutes;
  final bool isExpandedMinutes;
  final bool isExpandedHours;
  final String? couponId;
  final String? couponCode;
  final int? id;
   String coupon;

   PaymentState({
    this.orderId,
    this.screenState,
    this.paymentProcessResponse,
    this.completePaymentStates,
    this.errorMessage,
    this.orderState,
    this.deliveryCost = 0,
    this.paymentState,
    this.deliveryMethodChosenList = const [],
    this.attributeChosenList = const [],
    this.deliveryChangesList = const [],
    this.time,
    this.isExpandedMinutes = false,
    this.isExpandedHours = false,
    this.hour,
    this.minutes,
    this.couponId,
    this.couponCode,
    this.id,
    this.coupon='',
  });

  PaymentState copyWith({
    int? orderId,
    ScreenStates? screenState,
    OrderStates? orderState,
    int? deliveryCost,
    PaymentProcessResponse? paymentProcessResponse,
    CompletePaymentStates? completePaymentStates,
    String? errorMessage,
    List<DeliveryMethodResponse>? deliveryMethodChosenList,
    List<DeliveryChangesResponse>? deliveryChangesList,
    PaymentStates? paymentState,
    List<DeliveryAttributesResponse>? attributeChosenList,
    bool? isCompletePayment,
    String? time,
    bool? isExpandedMinutes,
    bool? isExpandedHours,
    String? couponId,
    String? couponCode,
    String? coupon,
    int? id,
  }) {
    return PaymentState(
      orderId: orderId,
      completePaymentStates:
          completePaymentStates ?? CompletePaymentStates.initialized,
      paymentProcessResponse:
          paymentProcessResponse ?? this.paymentProcessResponse,
      deliveryCost: deliveryCost ?? this.deliveryCost,
      deliveryMethodChosenList:
          deliveryMethodChosenList ?? this.deliveryMethodChosenList,
      deliveryChangesList: deliveryChangesList ?? this.deliveryChangesList,
      attributeChosenList: attributeChosenList ?? this.attributeChosenList,
      screenState: screenState ?? ScreenStates.initialized,
      orderState: orderState ?? this.orderState,
      paymentState: paymentState ?? this.paymentState,
      errorMessage: errorMessage ?? "",
      time: time ?? this.time,
      isExpandedMinutes: isExpandedMinutes ?? this.isExpandedMinutes,
      isExpandedHours: isExpandedHours ?? this.isExpandedHours,
      couponId: couponId ?? this.couponId,
      couponCode: couponCode ?? this.couponCode,
      coupon: coupon ?? this.coupon,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
        identityHashCode(this),
        orderId,
        screenState,
        orderState,
        paymentState,
        deliveryCost,
        attributeChosenList,
        deliveryChangesList,
        deliveryMethodChosenList,
        paymentProcessResponse,
        completePaymentStates,
        errorMessage,
        time,
        isExpandedMinutes,
        isExpandedHours,
        couponCode,
        couponId,
        id,
        coupon,
      ];
}
