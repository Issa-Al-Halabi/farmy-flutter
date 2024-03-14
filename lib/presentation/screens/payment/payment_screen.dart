import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/bloc/basket_bloc/basket_bloc.dart';
import 'package:pharma/bloc/location_bloc/location_bloc.dart';
import 'package:pharma/bloc/location_bloc/location_state.dart';
import 'package:pharma/bloc/payment_bloc/payment_bloc.dart';
import 'package:pharma/bloc/setting_bloc/setting_bloc.dart';
import 'package:pharma/core/app_enum.dart';
import 'package:pharma/core/app_router/app_router.dart';
import 'package:pharma/core/utils/app_value_const.dart';
import 'package:pharma/core/utils/formatter.dart';
import 'package:pharma/data/repository/payment_repo.dart';
import 'package:pharma/models/delivery_response.dart';
import 'package:pharma/models/params/Invoices_params.dart';
import 'package:pharma/models/payment_process_response.dart';
import 'package:pharma/presentation/resources/assets_manager.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/resources/font_app.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import 'package:pharma/presentation/screens/auth_screen/%20widgets/input_field_auth.dart';
import 'package:pharma/presentation/screens/home_screen/home_screen.dart';
import 'package:pharma/presentation/screens/location_screen/location_screen.dart';
import 'package:pharma/presentation/screens/payment/widgets/custom_bill_details_row.dart';
import 'package:pharma/presentation/screens/payment/widgets/custom_date_picker.dart';
import 'package:pharma/presentation/screens/payment/widgets/custom_note_on_the_order_continer.dart';
import 'package:pharma/presentation/screens/payment/widgets/custom_order_type_continer.dart';
import 'package:pharma/presentation/widgets/custom_app_bar_screen.dart';
import 'package:pharma/presentation/widgets/custom_total_price.dart';
import 'package:pharma/presentation/widgets/dialogs/confirm_payment_order_dialog.dart';
import 'package:pharma/presentation/widgets/dialogs/error_dialog.dart';
import 'package:pharma/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:pharma/presentation/widgets/select_location.dart';
import 'package:pharma/translations.dart';
import 'widgets/custom_change_on_the_order_container.dart';
import 'widgets/custom_discount_code_container.dart';
import 'widgets/custom_payment_status_container.dart';

class PaymentScreen extends StatelessWidget {
  final PaymentProcessResponse paymentProcessResponse;

  PaymentScreen({super.key, required this.paymentProcessResponse});

  final PaymentBloc paymentBloc = PaymentBloc(paymentRepo: PaymentRepo());

  @override
  Widget build(BuildContext context) {
    paymentBloc
        .add(GetInitializeInvoice(initializeInvoice: paymentProcessResponse));
    return PaymentBody(paymentBloc: paymentBloc);
  }
}

class PaymentBody extends StatelessWidget {
  final PaymentBloc paymentBloc;

  PaymentBody({super.key, required this.paymentBloc});

  final Duration animationDuration = const Duration(milliseconds: 500);

  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<PaymentBloc, PaymentState>(
        bloc: paymentBloc,
        listener: (context, state) {
          // log(state.toString());
          if (state.screenState == ScreenStates.loading) {
            LoadingDialog().openDialog(context);
          }
          if (state.screenState == ScreenStates.success) {
            LoadingDialog().closeDialog(context);
          }
          if (state.screenState == ScreenStates.error) {
            LoadingDialog().closeDialog(context);
            ErrorDialog.openDialog(context, "some thing went wrong");
          }
          if (state.completePaymentStates == CompletePaymentStates.complete) {
            LoadingDialog().closeDialog(context);

            ConfirmPaymentOrderDialog.openDialog(
                context, AppLocalizations.of(context)!.orderSuccesfulyComplete);
            context.read<BasketBloc>().add(ClearBasket());
          }
          if (state.completePaymentStates == CompletePaymentStates.loading) {
            LoadingDialog().openDialog(context);
          }
          if (state.completePaymentStates == CompletePaymentStates.error) {
            LoadingDialog().closeDialog(context);
            ErrorDialog.openDialog(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          // log("state $state");
          return Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBarScreen(
                        sectionName: AppLocalizations.of(context)!.payment,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 21),
                              child: Text(
                                AppLocalizations.of(context)!.payment_statment,
                                style: getRegularStyle(
                                  color: ColorManager.grayForMessage,
                                  fontSize: FontSizeApp.s16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 21,
                                vertical: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.address,
                                    style: getBoldStyle(
                                      color: ColorManager.grayForMessage,
                                      fontSize: FontSizeApp.s14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  GestureDetector(
                                    onTap: () {
                                      AppRouter.push(
                                        context,
                                        const LocationScreen(),
                                      );
                                    },
                                    child: BlocBuilder<LocationBloc,
                                        LocationState>(
                                      builder: (context, state) {
                                        return SelectLocation(
                                          favoriteuserAddress:
                                              state.addressCurrent,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 21),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.conduction,
                                    style: getBoldStyle(
                                      color: ColorManager.grayForMessage,
                                      fontSize: FontSizeApp.s14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  for (var item in state.paymentProcessResponse!.deliveryMethodList!) ...[
                                    if (item.deliveryName == "طلب مجدول") ...[
                                      if (checkIsOpening(context)) ...[
                                        BlocBuilder<LocationBloc,
                                            LocationState>(
                                          builder: (context, locationState) {
                                            return buildCustomOrderTypeContainer(
                                              context,
                                              locationState,
                                              item,
                                              state,
                                            );
                                          },
                                        ),
                                      ]
                                    ],
                                    if (item.deliveryName != "طلب مجدول") ...[
                                      BlocBuilder<LocationBloc, LocationState>(
                                        builder: (context, locationState) {
                                          return buildCustomOrderTypeContainer(
                                            context,
                                            locationState,
                                            item,
                                            state,
                                          );
                                        },
                                      ),
                                    ]
                                  ],
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 21,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.payment,
                                    style: getBoldStyle(
                                      color: ColorManager.grayForMessage,
                                      fontSize: FontSizeApp.s14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  CustomPaymentStatusContainer(
                                    image: ImageManager.farmySmile,
                                    text: AppLocalizations.of(context)!
                                        .cash_payment,
                                    paymentState: PaymentStates.cashPayment,
                                  ),
                                  const SizedBox(height: 12),
                                  CustomPaymentStatusContainer(
                                    image: ImageManager.farmySmile,
                                    text: AppLocalizations.of(context)!
                                        .farmy_wallet,
                                    paymentState: PaymentStates.farmyWallet,
                                  ),
                                ],
                              ),
                            ),
                            //  todo
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 21,
                                vertical: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.hasm_code,
                                    style: getBoldStyle(
                                      color: ColorManager.primaryGreen,
                                      fontSize: FontSizeApp.s14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: CustomDiscountCodeContainer(
                                            imageUrl: ImageManager.codeDiscount,
                                            subjectText:
                                                AppLocalizations.of(context)!
                                                    .hasm_code,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: CustomDiscountCodeContainer(
                                            isReplacePoint: true,
                                            imageUrl: ImageManager.replacePoint,
                                            subjectText:
                                                AppLocalizations.of(context)!
                                                    .redeem_points,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //  todo
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "لا يمكنك استخدام كود الحسم واستبدال النقاط معا (اختر واحدة فقط)",
                                  style: getRegularStyle(
                                    color: ColorManager.grayForMessage,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "لقد حصلت على حسم 5000 ل.س من مجمل الفاتورة",
                                  style: getBoldStyle(
                                    color: ColorManager.redForFavorite,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 21,
                                vertical: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.reviews,
                                    style: getBoldStyle(
                                      color: ColorManager.grayForMessage,
                                      fontSize: FontSizeApp.s14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  InputFieldAuth(
                                    controller: noteController,
                                    maxLines: 5,
                                    minLines: 5,
                                    height: .30.sw,
                                    width: 1.sw,
                                    color: ColorManager.lightGray,
                                    hintText:
                                        AppLocalizations.of(context)!.add_notes,
                                    hintStyle: getRegularStyle(
                                      color: ColorManager.grayForMessage,
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Column(
                                children: [
                                  for (int i = 0;
                                      i <
                                          state.paymentProcessResponse!
                                              .deliveryAttributeList!.length;
                                      i++)
                                    CustomNoteOnTheOrder(
                                      onTab: () {
                                        if (paymentBloc
                                            .state.attributeChosenList
                                            .any(
                                          (element) =>
                                              element.id ==
                                              state.paymentProcessResponse!
                                                  .deliveryAttributeList![i].id,
                                        )) {
                                          paymentBloc.add(
                                            RemoveFromChosenList(
                                              attributeData: state
                                                  .paymentProcessResponse!
                                                  .deliveryAttributeList![i],
                                            ),
                                          );
                                        } else {
                                          paymentBloc.add(
                                            AddToChosenAttributeList(
                                              attributeData: state
                                                  .paymentProcessResponse!
                                                  .deliveryAttributeList![i],
                                            ),
                                          );
                                        }
                                      },
                                      isSelected: paymentBloc
                                              .state.attributeChosenList
                                              .any(
                                        (element) =>
                                            element.id ==
                                            state.paymentProcessResponse!
                                                .deliveryAttributeList![i].id,
                                      )
                                          ? true
                                          : false,
                                      noteText: state
                                          .paymentProcessResponse!
                                          .deliveryAttributeList![i]
                                          .nameDeliveryAttribute!,
                                    ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 21,
                                vertical: 14,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .requiredChange,
                                    style: getBoldStyle(
                                      color: ColorManager.primaryGreen,
                                      fontSize: FontSizeApp.s14,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  SizedBox(
                                    width: 1.sw,
                                    child: GridView.builder(
                                      itemCount: state.paymentProcessResponse!
                                          .deliveryChangesResponse.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(1, 2),
                                                spreadRadius: 1.5,
                                                color:
                                                    ColorManager.grayForSearch,
                                              ),
                                            ],
                                          ),
                                          child: CustomChangeOnTheOrder(
                                            onTab: () {
                                              if (paymentBloc
                                                  .state.deliveryChangesList
                                                  .any(
                                                (element) =>
                                                    element.id ==
                                                    state
                                                        .paymentProcessResponse!
                                                        .deliveryChangesResponse[
                                                            index]
                                                        .id,
                                              )) {
                                                /// todo : change DeliveryAttributesResponse to changeResponse
                                                paymentBloc.add(
                                                  RemoveChangeList(
                                                    removeDeliveryChangesResponse: state
                                                        .paymentProcessResponse!
                                                        .deliveryChangesResponse[index],
                                                  ),
                                                );
                                              } else {
                                                /// todo : change DeliveryAttributesResponse to changeResponse

                                                paymentBloc.add(
                                                  AddChangeList(
                                                    addDeliveryChangesResponse: state
                                                        .paymentProcessResponse!
                                                        .deliveryChangesResponse[index],
                                                  ),
                                                );
                                              }
                                            },
                                            isSelected: paymentBloc
                                                    .state.deliveryChangesList
                                                    .any(
                                              (element) =>
                                                  element.id ==
                                                  state
                                                      .paymentProcessResponse!
                                                      .deliveryChangesResponse[
                                                          index]
                                                      .id,
                                            )
                                                ? true
                                                : false,
                                            changeText: state
                                                .paymentProcessResponse!
                                                .deliveryChangesResponse[index]
                                                .value!,
                                          ),
                                        );
                                      },
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 30,
                                        mainAxisSpacing: 10,
                                        mainAxisExtent: 30,
                                        crossAxisCount: 3,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                right: 38,
                                left: 38,
                                top: 15,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.invoice,
                                    style: getUnderBoldStyle(
                                      color: ColorManager.grayForMessage,
                                      fontSize: FontSizeApp.s14,
                                    )!
                                        .copyWith(height: 1),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                right: 21,
                                left: 21,
                                bottom: 11,
                              ),
                              child: Column(
                                children: [
                                  CustomBillDetailsRow(
                                    subStatusBill: AppLocalizations.of(context)!
                                        .total_amount,
                                    price: state.paymentProcessResponse!
                                                .invoicesResponse!.subTotal !=
                                            null
                                        ? Formatter.formatPrice(
                                            state.paymentProcessResponse!
                                                .invoicesResponse!.subTotal!,
                                          )
                                        : AppValueConst.defaultInvoiceValue
                                            .toString(),
                                  ),
                                  CustomBillDetailsRow(
                                    subStatusBill:
                                        AppLocalizations.of(context)!.hasm_code,
                                    price: state.paymentProcessResponse!
                                                .invoicesResponse!.coponValue !=
                                            null
                                        ? Formatter.formatPrice(
                                            state.paymentProcessResponse!
                                                .invoicesResponse!.coponValue!,
                                          )
                                        : AppValueConst.defaultInvoiceValue
                                            .toString(),
                                  ),
                                  CustomBillDetailsRow(
                                    subStatusBill: AppLocalizations.of(context)!
                                        .deliverycharges,
                                    price: (
                                      state
                                              .paymentProcessResponse!
                                              .invoicesResponse!
                                              .deliveryValue ??
                                          0,
                                    ).toString(),
                                  ),
                                  CustomBillDetailsRow(
                                    subStatusBill:
                                        AppLocalizations.of(context)!.tax,
                                    price: state.paymentProcessResponse!
                                                .invoicesResponse!.tax !=
                                            null
                                        ? Formatter.formatPrice(
                                            state.paymentProcessResponse!
                                                .invoicesResponse!.tax!,
                                          )
                                        : AppValueConst.defaultInvoiceValue
                                            .toString(),
                                  ),
                                  CustomBillDetailsRow(
                                    colorText: ColorManager.primaryGreen,
                                    subStatusBill:
                                        AppLocalizations.of(context)!.total,
                                    price: state.paymentProcessResponse!
                                                .invoicesResponse!.total !=
                                            null
                                        ? Formatter.formatPrice(
                                            state.paymentProcessResponse!
                                                .invoicesResponse!.total!,
                                          )
                                        : AppValueConst.defaultInvoiceValue
                                            .toString(),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                CustomTotalPrice(
                  title: AppLocalizations.of(context)!
                      .total_price
                      .replaceAll(":", ""),
                  totoalPrice:
                      state.paymentProcessResponse!.invoicesResponse!.total !=
                              null
                          ? Formatter.formatPrice(
                              state.paymentProcessResponse!.invoicesResponse!
                                  .total!,
                            )
                          : AppValueConst.defaultInvoiceValue.toString(),
                  onCompletePayment: () {
                    print('#####################');
                    print(state.time);
                    print('#####################');
                    paymentBloc.add(
                      CreateOrder(
                        productList:
                            context.read<BasketBloc>().state.productList!,
                        invoicesParams: InvoicesParams(
                          time: state.time,
                          notes: noteController.text,
                          deliveryMethodId:
                              state.deliveryMethodChosenList.isNotEmpty
                                  // ToDo deliveryMethodChosenList[0].id ??? 0
                                  ? state.deliveryMethodChosenList[0].id
                                  : 0,
                          userAddressId: context
                              .read<LocationBloc>()
                              .state
                              .addressCurrent
                              .id!,
                        ),
                      ),
                    );
                  },
                  onCompleteShopping: () {
                    AppRouter.pushReplacement(context, const HomeScreen());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  CustomOrderTypeContainer buildCustomOrderTypeContainer(
    BuildContext context,
    LocationState locationState,
    DeliveryMethodResponse item,
    PaymentState state,
  ) {
    return CustomOrderTypeContainer(
      idMethodeType: item.id,
      isChosenLocation:
          context.read<LocationBloc>().state.addressCurrent.latitude != null,
      userAddressId: locationState.addressCurrent.id ?? 0,
      deliveryField: item,
      isSelected: state.deliveryMethodChosenList
          .any((element) => element.id == item.id),
      deliveryCost:
          "${AppLocalizations.of(context)!.delivery_cost} ${item.deliveryPrice} ل.س ",
      image: ImageManager.dateTimeImage,
      text: "${item.deliveryName} (${item.deliveryTime} دقيقة) ",
      onTap: () {
        if (!state.deliveryMethodChosenList
            .any((element) => element.id == item.id)) {
          if (context.read<LocationBloc>().state.addressCurrent.latitude !=
              null) {
            paymentBloc.add(ToggleDeliveryMethod(deliveryMethodData: item));
            paymentBloc.add(GetInvoicesDetails(
                invoicesParams: InvoicesParams(
                  time: state.time,
                  notes: noteController.text,
                  deliveryMethodId: item.id,
                  userAddressId: locationState.addressCurrent.id!,
                ),
                productList: context.read<BasketBloc>().state.productList,
              ),
            );
            if (item.id == 3) {
              showDialog(
                context: context,
                builder: (unContext) => CustomDatePicker(
                  paymentBloc: paymentBloc,
                ),
              );
            }
          }
        }
      },
    );
  }

  bool checkIsOpening(BuildContext context) {
    DateTime dateTime = DateTime.now();
    List<String> endTime = (context.read<SettingBloc>().settingModel!.data!.openingTimes!.endTime).split(":");
    print('=================== Current Time =============================');
    print(dateTime.hour);
    print('====================== End Time ==============================');
    print(endTime[0]);
    print('==============================================================');
    if (int.parse(endTime[0]) > dateTime.hour) {
      return true;
    } else if (int.parse(endTime[0]) == dateTime.hour) {
      if (int.parse(endTime[1]) > dateTime.minute) {
        return true;
      }
    } else {
      return false;
    }
    return false;
  }
}
