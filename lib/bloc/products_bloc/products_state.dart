part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final ScreenState? screenState;
  List<ProductsBySubCategoryIdResponse> productsList = [];
  ProductsState({this.screenState, this.productsList = const []});
  ProductsState copyWith({
    List<ProductsBySubCategoryIdResponse>? productsList,
    ScreenState? screenState,
  }) {
    return ProductsState(
      screenState: screenState ?? this.screenState,
      productsList: productsList ?? this.productsList,
    );
  }

  @override
  List<Object?> get props =>
      [identityHashCode(this), screenState, productsList];
}