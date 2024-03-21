import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/resources/font_app.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import 'package:pharma/presentation/resources/values_app.dart';
import 'package:pharma/translations.dart';

class RewardsActivityTicketBuyContent extends StatelessWidget {
  final String point;

  const RewardsActivityTicketBuyContent({Key? key, required this.point})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(
            top: 5.h,
          ),
          alignment: Alignment.center,
          width: 175.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: ColorManager.grayForMessage,
            borderRadius: BorderRadius.circular(
              RadiusApp.r6.r,
            ),
          ),
          child: Text(
            textAlign: TextAlign.center,
            "$point ${AppLocalizations.of(context)!.point}",
            style: getBoldStyle(
              color: ColorManager.white,
              fontSize: FontSizeApp.s18.sp,
              height: 1.6.h,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          height: 27.h,
          width: 219.w,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(PaddingApp.p3),
          decoration: BoxDecoration(
            color: ColorManager.primaryGreen,
            borderRadius: BorderRadius.circular(
              RadiusApp.r5.r,
            ),
          ),
          child: Text(
            "شراء",
            style: getBoldStyle(
              color: ColorManager.white,
              fontSize: FontSizeApp.s14.sp,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
