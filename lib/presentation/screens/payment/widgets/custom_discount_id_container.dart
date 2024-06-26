import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharma/bloc/basket_bloc/basket_bloc.dart';
import 'package:pharma/bloc/location_bloc/location_bloc.dart';
import 'package:pharma/bloc/my_order_bloc/my_order_bloc.dart';
import 'package:pharma/bloc/payment_bloc/payment_bloc.dart';
import 'package:pharma/models/params/Invoices_params.dart';
import 'package:pharma/models/reward/reward_coupons_fixed_value.dart';
import 'package:pharma/presentation/resources/assets_manager.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/resources/font_app.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import 'package:pharma/translations.dart';

class CustomDiscountIdContainer extends StatefulWidget {
  final String subjectText;
  final String imageUrl;
  final bool? isReplacePoint;
  final RewardCouponsFixedValueModel? rewardCouponsFixedValueModel;
  final MyOrderBloc? myOrderBloc;
  final PaymentBloc paymentBloc;
  final int? idBasket;
  final String notesText;

  const CustomDiscountIdContainer({
    super.key,
    required this.subjectText,
    required this.imageUrl,
    this.isReplacePoint = false,
    required this.rewardCouponsFixedValueModel,
    required this.myOrderBloc,
    required this.paymentBloc,
    required this.idBasket,
    required this.notesText,
  });

  @override
  State<CustomDiscountIdContainer> createState() =>
      _CustomDiscountIdContainerState();
}

class _CustomDiscountIdContainerState extends State<CustomDiscountIdContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Column(
        children: [
          Container(
            height: 61.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorManager.grayForMessage,
                  width: 1,
                )),
            child: Row(
              children: [
                SizedBox(width: 22.w,),
                Image.asset(
                  widget.imageUrl,
                  height: 44.h,
                  width: 44.w,
                ),
                SizedBox(width: 18.w,),
                FittedBox(
                  child: Text(
                    widget.subjectText,
                    style: getBoldStyle(
                      color: ColorManager.grayForMessage,
                      fontSize: FontSizeApp.s11.sp,
                    )!
                        .copyWith(height: 1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                widget.isReplacePoint == true
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 13.h,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorManager.primaryGreen,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          height: 22.h,
                          width: 22.w,
                          child: isExpanded
                              ? SvgPicture.asset(ImageManager.dropUp)
                              : SvgPicture.asset(ImageManager.dropDown),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          AnimatedCrossFade(
            secondCurve: Curves.linear,
            duration: const Duration(milliseconds: 200),
            firstChild: const SizedBox(),
            secondChild: Container(
              decoration: BoxDecoration(
                border: const Border(
                  right: BorderSide(),
                  left: BorderSide(),
                  bottom: BorderSide(),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0.r),
                  bottomRight: Radius.circular(10.0.r),
                ),
              ),
              height: 180.h,
              alignment: Alignment.center,
              child: ListView.separated(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),
                itemBuilder: (context, index) {
                  if (widget.rewardCouponsFixedValueModel!.data.isNotEmpty) {
                    return InkWell(
                      onTap: () {
                        if (widget.paymentBloc.state.id != null) {
                          widget.paymentBloc.add(
                            GetCoupon(
                                widget.rewardCouponsFixedValueModel!.data[index]
                                    .id
                                    .toString(),
                                ""),
                          );
                          if (widget.myOrderBloc != null) {
                            widget.paymentBloc.add(
                              GetInvoicesDetails(
                                productList:
                                    widget.myOrderBloc!.productDetailsList,
                                invoicesParams: InvoicesParams(
                                  couponId: widget.rewardCouponsFixedValueModel!
                                      .data[index].id
                                      .toString(),
                                  time: widget.paymentBloc.state.time,
                                  notes: widget.notesText,
                                  deliveryMethodId:
                                      widget.paymentBloc.state.id!,
                                  userAddressId: context
                                      .read<LocationBloc>()
                                      .state
                                      .addressCurrent
                                      .id!,
                                ),
                              ),
                            );
                          } else {
                            widget.paymentBloc.add(
                              GetInvoicesDetails(
                                productList: context
                                    .read<BasketBloc>()
                                    .state
                                    .productList!,
                                invoicesParams: InvoicesParams(
                                  couponId: widget.rewardCouponsFixedValueModel!
                                      .data[index].id
                                      .toString(),
                                  time: widget.paymentBloc.state.time,
                                  notes: widget.notesText,
                                  deliveryMethodId:
                                      widget.paymentBloc.state.id!,
                                  userAddressId: context
                                      .read<LocationBloc>()
                                      .state
                                      .addressCurrent
                                      .id!,
                                ),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 1),
                              content: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.please_select_an_order_type,
                                  style: getRegularStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSizeApp.s14,
                                  ),
                                ),
                              ),
                              backgroundColor: ColorManager.primaryGreen,
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              color: ColorManager.primaryGreen,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "${widget.rewardCouponsFixedValueModel!.data[index].price}",
                              ),
                               TextSpan(
                                text: " ${AppLocalizations.of(context)!.point} = ",
                              ),
                              TextSpan(
                                text:
                                    "${widget.rewardCouponsFixedValueModel!.data[index].value}",
                              ),
                               TextSpan(
                                text: " ${AppLocalizations.of(context)!.curruncy}",
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return null;
                },
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black.withOpacity(0.2),
                ),
                itemCount: widget.rewardCouponsFixedValueModel!.data.length,
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
}
