import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/bloc/setting_bloc/setting_bloc.dart';
import 'package:pharma/core/app_router/app_router.dart';
import 'package:pharma/core/utils/formatter.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import 'package:pharma/presentation/screens/auth_screen/account_screen.dart';

import '../../../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../translations.dart';
import '../../../widgets/custom_button.dart';

class CustomDeliveryService extends StatelessWidget {
  const CustomDeliveryService({super.key});

  @override
  Widget build(BuildContext context) {
    return sl<AuthenticationBloc>().loggedIn
        ? Padding(
            padding:  EdgeInsetsDirectional.only(
              start: 13.w,
              end: 13.w,
              top: 13.h,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                alignment: Alignment.center,
                color: ColorManager.lightGray,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: getBoldStyle(
                      color: ColorManager.grayForMessage,
                    ),
                    children: [
                      TextSpan(text:"${AppLocalizations.of(context)!.delivery_service_is_available_from_now_on} "),
                      TextSpan(text:Formatter.extractHour(context.read<SettingBloc>().settingModel!.data!.openingTimes!.startTime)),
                      TextSpan(text:" ${AppLocalizations.of(context)!.in_the_morning_until_noon} "),
                      TextSpan(text:Formatter.extractHour(context.read<SettingBloc>().settingModel!.data!.openingTimes!.endTime)),
                      TextSpan(text:" ${AppLocalizations.of(context)!.in_the_evening_it_is_possible_to_choose_to_order_now_and_have_it_delivered_in_the_morning} "),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 1.sw,
                //height: 61,
                color: ColorManager.lightGray,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcome_to,
                        style: getBoldStyle(
                          color: ColorManager.primaryGreen,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.sign_now_or_create,
                        style: getBoldStyle(
                          color: ColorManager.grayForMessage,
                        ),
                      ),
                      CustomButton(
                        label: AppLocalizations.of(context)!.sign_in,
                        width: 1.sw / 2,
                        onTap: () {
                          AppRouter.push(
                            context,
                            const AccountScreen(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
