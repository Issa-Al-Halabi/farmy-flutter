import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/bloc/my_order_bloc/my_order_event.dart';
import 'package:pharma/bloc/my_order_bloc/my_order_state.dart';
import 'package:pharma/core/app_enum.dart';
import 'package:pharma/core/app_router/app_router.dart';
import 'package:pharma/models/params/product_model.dart';
import 'package:pharma/presentation/screens/order_not_install_details_screen/widgets/card_details_order_not_install.dart';
import 'package:pharma/presentation/widgets/custom_error_screen.dart';
import 'package:pharma/presentation/widgets/over_scroll_indicator.dart';
import '../../../bloc/my_order_bloc/my_order_bloc.dart';
import '../../../core/services/services_locator.dart';
import '../../../translations.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_app.dart';
import '../../resources/style_app.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/dialogs/error_dialog.dart';
import '../../widgets/dialogs/loading_dialog.dart';
import '../base_screen/base_screen.dart';
import '../payment/payment_screen.dart';

class OrderNotInstallDetailsScreen extends StatelessWidget {
  final List<Product> id;
  final int idBasket;
  final bool isEdit;

  const OrderNotInstallDetailsScreen(
      {super.key,
      required this.id,
      this.isEdit = false,
      required this.idBasket});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return sl<MyOrderBloc>()
          ..add(ShowBasket(idProducts: id, idBasket: idBasket));
      },
      child: OrderDetailsBody(id: id, isEdit: isEdit, idBasket: idBasket),
    );
  }
}

class OrderDetailsBody extends StatelessWidget {
  final List<Product> id;
  final bool isEdit;
  final int idBasket;

  const OrderDetailsBody({
    super.key,
    required this.id,
    this.isEdit = false,
    required this.idBasket,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      backgroundColor: Colors.white,
      appbarTitle: AppLocalizations.of(context)!.order_details,
      body: SafeArea(
        child: Column(
          children: [
            // CustomAppBar( ),
            // CustomAppBarScreen(
            //     sectionName: AppLocalizations.of(context)!.order_details),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Text(
                AppLocalizations.of(context)!.payment_statment,
                style: getRegularStyle(
                  color: ColorManager.grayForMessage,
                  fontSize: FontSizeApp.s16,
                ),
              ),
            ),
            BlocConsumer<MyOrderBloc, MyOrderState>(
              listener: (context, state) {
                if (state.isLoadingConfirm) {
                  LoadingDialog().openDialog(context);
                } else {
                  LoadingDialog().closeDialog(context);
                }
                if (state.error != "") {
                  ErrorDialog.openDialog(context, state.error);
                }
                if (state.successConfirm) {
                  AppRouter.push(
                    context,
                    PaymentScreen(
                      rewardCouponsFixedValueModel: state.rewardCouponsFixedValueModel!,
                      paymentProcessResponse: state.paymentProcessResponse!,
                      myOrderBloc: context.read<MyOrderBloc>(),
                      idBasket: idBasket,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.screenStates == ScreenStates.loading) {
                  return const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                    color: ColorManager.primaryGreen,
                  )));
                } else if (state.screenStates == ScreenStates.error) {
                  return Expanded(
                    child: CustomErrorScreen(
                      onTap: () {
                        // context.read<DetailsOrderBloc>().add(ShowDetailsOrder(id:id));
                      },
                      titleError: state.error,
                    ),
                  );
                }
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: CustomOverscrollIndicator(
                          child: ListView.builder(
                            itemBuilder: (context, index) =>
                                CardDetailsOrderNotInstall(
                              myOrderBloc: context.read<MyOrderBloc>(),
                              product: state.productList[index],
                              isEdit: isEdit,
                              idBasket: idBasket,
                              index: index,
                            ),
                            itemCount: state.productList.length,
                          ),
                        ),
                      ),
                      state.productList.isEmpty
                          ? const SizedBox()
                          : Container(
                              width: 1.sw,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(22),
                                      topRight: Radius.circular(22)),
                                  boxShadow: [ColorManager.shadowGaryUp]),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Text(AppLocalizations.of(context)!.totalPrice,
                                      style: getBoldStyle(
                                          color: ColorManager.grayForMessage,
                                          fontSize: 14)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(state.totalPrice.toString(),
                                          style: getBoldStyle(
                                              color: ColorManager.primaryGreen,
                                              fontSize: 24)),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.curruncy,
                                        style: getBoldStyle(
                                                color:
                                                    ColorManager.primaryGreen,
                                                fontSize: 15)!
                                            .copyWith(height: 1),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 27, vertical: 9),
                                    child: Row(
                                      children: [
                                        isEdit
                                            ? Expanded(
                                                child: CustomButton(
                                                  label: "تثبيت الطلب ",
                                                  fillColor:
                                                      ColorManager.primaryGreen,
                                                  onTap: () {
                                                    context
                                                        .read<MyOrderBloc>()
                                                        .add(
                                                          PaymentProcessBasket(
                                                            idBasket,
                                                          ),
                                                        );
                                                    // context.read<DetailsOrderBloc>().add(EditDetailsOrder(id:id));
                                                  },
                                                ),
                                              )
                                            : const SizedBox(),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                          child: CustomButton(
                                            label: "رجوع",
                                            fillColor:
                                                ColorManager.primaryGreen,
                                            labelColor: Colors.white,
                                            onTap: () {
                                              AppRouter.pop(context);
                                              // SystemNavigator.pop();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
      //  drawer: const CustomAppDrawer(),
    );
  }
}
