import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/bloc/location_bloc/location_bloc.dart';
import 'package:pharma/bloc/location_bloc/location_state.dart';
import 'package:pharma/core/app_router/app_router.dart';
import 'package:pharma/presentation/resources/assets_manager.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/resources/font_app.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/custom_app_bar.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/custom_home_cursel.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/custom_section_name.dart';
import 'package:pharma/presentation/screens/location_screen/location_screen.dart';
import 'package:pharma/presentation/widgets/custom_category.dart';
import 'package:pharma/presentation/widgets/custom_prdouct_card.dart';
import 'package:pharma/presentation/widgets/custom_app_drawer.dart';
import 'package:pharma/translations.dart';

import '../all_section/all_section_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (scaffoldKey.currentState?.isDrawerOpen == true) {
          scaffoldKey.currentState?.closeDrawer();
        } else {}
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: const CustomAppDrawer(),
        body: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Column(
            children: [
              CustomAppBar(scaffoldKey: scaffoldKey),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 13),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: const Border(
                              left: BorderSide(color: ColorManager.lightGray),
                              right: BorderSide(color: ColorManager.lightGray),
                              top: BorderSide(
                                  color: ColorManager
                                      .lightGray), // White border at the top
                              bottom: BorderSide(
                                  color: ColorManager
                                      .lightGray), // White border at the bottom
                            )),
                        width: 1.sw,
                        height: 61,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageManager.location,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .delivery_to,
                                          style: getSemiBoldStyle(
                                                  color: ColorManager
                                                      .grayForMessage,
                                                  fontSize: FontSizeApp.s10)!
                                              .copyWith(height: 1),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    BlocBuilder<LocationBloc,LocationState>(
                                      builder:(context, state) => Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                             context.read<LocationBloc>().addressCurrent.floor??"noo",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: getBoldStyle(
                                                      fontSize: FontSizeApp.s13,
                                                      color: ColorManager
                                                          .primaryGreen)!
                                                  .copyWith(height: 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  AppRouter.push(
                                      context, const LocationScreen());
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: ColorManager.grayForMessage,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      // padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 1.sw,
                          height: 61,
                          color: ColorManager.lightGray,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 6),
                            child: Text(
                              "خدمة التوصيل متوفرة من الساعة 9 صباحاً حتى الساعة 10 مساءً, من الممكن اختيار الطلب الآن والتوصيل صباحاً",
                              style: getBoldStyle(
                                color: ColorManager.grayForMessage,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 33, vertical: 13),
                      child: CustomSectionName(
                        sectionName: AppLocalizations.of(context)!.sections,
                        onTap: () {
                          AppRouter.push(context, ALlSectionScreen());
                        },
                      ),
                    ),
                    SizedBox(
                      height: 305,
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 19),
                        itemCount: 19,
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 23,
                                mainAxisSpacing: 20,
                                mainAxisExtent: 97,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return const CustomCategory(
                            categoryName: "الخضار و الأعشاب",
                          );
                        },
                      ),
                    ),
                    CustomHomeCursel(
                      height: 0.5.sw,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 33, vertical: 13),
                      child: CustomSectionName(
                        sectionName:
                            AppLocalizations.of(context)!.suggested_products,
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      height: 238,
                      width: 1.sw,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.only(
                                bottom: 10, start: index == 0 ? 0 : 15),
                            child: const CustomProductCard(isDisCount: true),
                          );
                        },
                      ),
                    ),
                    CustomHomeCursel(
                      height: 0.5.sw,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 33, vertical: 13),
                      child: CustomSectionName(
                        sectionName: AppLocalizations.of(context)!.discounts,
                        onTap: () {},
                      ),
                    ),
                    SizedBox(
                      height: 238,
                      width: 1.sw,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.only(
                                bottom: 10, start: index == 0 ? 0 : 15),
                            child: const CustomProductCard(isDisCount: true),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
