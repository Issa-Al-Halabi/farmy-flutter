// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'basket_bloc.dart';

class BasketEvent extends Equatable {
  const BasketEvent();

  @override
  List<Object> get props => [];
}

class AddToBasket extends BasketEvent {
  final ProductDetailsResponse product;
  const AddToBasket({
    required this.product,
  });
}
class PaymentProcess extends BasketEvent{

}
