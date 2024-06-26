import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/bloc/my_rates/my_rates_bloc.dart';
import 'package:pharma/bloc/my_rates/my_rates_event.dart';
import 'package:pharma/bloc/my_rates/my_rates_state.dart';
import 'package:pharma/core/services/services_locator.dart';
import 'package:pharma/core/utils/formatter.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/resources/font_app.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import 'package:pharma/presentation/screens/my_evaluation/widgets/custom_details_evaluation_row.dart';
import 'package:pharma/presentation/widgets/custom_app_bar_screen.dart';
import 'package:pharma/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:pharma/translations.dart';

class MyEvaluationScreen extends StatelessWidget {
  const MyEvaluationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      sl<MyRatesBloc>()
        ..add(GetMyRates()),
      child: BlocConsumer<MyRatesBloc, MyRatesState>(
          builder: (context, state) {
            if (state.getUserRatesModel != null) {
              return SafeArea(
                child: Scaffold(
                  body: Column(
                    children: [
                      CustomAppBarScreen(
                        sectionName: AppLocalizations.of(context)!.my_Reviews,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 21.h),
                          child: ListView.builder(
                            itemCount: state.getUserRatesModel!.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: 15.w,
                                  end: 21.w,
                                  bottom: 17.h,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                        const Color(0xFF000000).withOpacity(
                                            0.18),
                                        offset: const Offset(0, 2),
                                        blurRadius: 4.0,
                                      )
                                    ],
                                  ),
                                  width: 1.sw,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 21.h,
                                      horizontal: 15.w,
                                    ),
                                    child: Column(
                                      children: [
                                        CustomDetailsEvaluationsRow(
                                          label: AppLocalizations.of(context)!
                                              .order_Number,
                                          valueOfLabel:
                                          "${state.getUserRatesModel!
                                              .data[index].orderNumber}",
                                        ),
                                        CustomDetailsEvaluationsRow(
                                          label: AppLocalizations.of(context)!
                                              .order_Date,
                                          valueOfLabel: Formatter.formatDate(state.getUserRatesModel!.data[index].createdAt),
                                        ),
                                        CustomDetailsEvaluationsRow(
                                          label: AppLocalizations.of(context)!
                                              .site,
                                          valueOfLabel:
                                          "${state.getUserRatesModel!
                                              .data[index].total}",
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .evaluation,
                                              style: getBoldStyle(
                                                  color: ColorManager
                                                      .grayForMessage,
                                                  fontSize: FontSizeApp.s13),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            RatingBar.builder(
                                              ignoreGestures: true,
                                              itemSize: 22,
                                              initialRating: state
                                                  .getUserRatesModel!
                                                  .data[index].rate
                                                  .toDouble(),
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              // itemPadding: const EdgeInsets.symmetric(horizontal: 22.0),
                                              itemBuilder: (context, _) =>
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (value) {},
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else{
              return const Scaffold(body: SizedBox());
            }
          },
          listener: (context, state) {
    if (state.isSuccess) {
    LoadingDialog().closeDialog(context);
    }
    if (state.isLoading) {
    LoadingDialog().openDialog(context);
    }
    },
    ),);
  }
}
