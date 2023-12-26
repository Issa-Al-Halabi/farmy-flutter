import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharma/core/app_enum.dart';
import 'package:pharma/data/repository/product_repo.dart';
import 'package:pharma/models/product_details_response.dart';

part 'productdetails_event.dart';
part 'productdetails_state.dart';

class ProductdetailsBloc
    extends Bloc<ProductdetailsEvent, ProductdetailsState> {
  ProductRepo productRepo;
  ProductdetailsBloc({required this.productRepo})
      : super(const ProductdetailsState(screenState: ScreenState.initialized)) {
    on<ProductdetailsEvent>((event, emit) async {
      if (event is GetProductDetailsById) {
        emit(state.copyWith(screenState: ScreenState.loading));
        (await productRepo.getCategoyById(event.id)).fold(
            (l) => emit(state.copyWith(screenState: ScreenState.error)),
            (r) => emit(state.copyWith(
                productDetailsResponse: r, screenState: ScreenState.success)));
      }
    });
  }
}
