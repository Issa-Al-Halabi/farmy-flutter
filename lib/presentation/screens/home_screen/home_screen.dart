import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/bloc/home_bloc/home_bloc.dart';
import 'package:pharma/core/app_enum.dart';
import 'package:pharma/core/app_router/app_router.dart';
import 'package:pharma/core/utils/app_value_const.dart';

import 'package:pharma/presentation/screens/home_screen/widgets/custom_app_bar.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/custom_delivery_address.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/custom_delivery_servies.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/custom_home_cursel.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/custom_section_name.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/cutsom_home_shimmer.dart';
import 'package:pharma/presentation/screens/product_details/product_details_screen.dart';
import 'package:pharma/presentation/widgets/custom_category.dart';
import 'package:pharma/presentation/widgets/custom_prdouct_card.dart';
import 'package:pharma/presentation/widgets/custom_app_drawer.dart';
import 'package:pharma/translations.dart';

import '../../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../../core/services/services_locator.dart';
import '../all_section/all_section_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.scaffoldKey.currentState?.isDrawerOpen == true) {
          widget.scaffoldKey.currentState?.closeDrawer();
        } else {}
        return true;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            key: widget.scaffoldKey,
            drawer: const CustomAppDrawer(),
            body: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Column(
                children: [
                  CustomAppBar(scaffoldKey: widget.scaffoldKey),
                  state.screenState == ScreenState.loading
                      ? const CustomHomeShimmer()
                      : state.screenState == ScreenState.success
                          ? Expanded(
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: [
                                  sl<AuthenticationBloc>().loggedIn
                                      ? const CustomDeliveryAddress()
                                      : const SizedBox(),
                                  const CustomDeliveryService(),
                                  state.homeData!.homeCategoriesList!.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: AppVAlueConst
                                                  .homeVerticalPadding),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 33,
                                                        vertical: 0),
                                                child: CustomSectionName(
                                                  sectionName:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .sections,
                                                  onTap: () {
                                                    AppRouter.push(
                                                        context,
                                                        ALlSectionScreen(
                                                          index: 0,
                                                          tabControllerLength: state
                                                                  .homeData!
                                                                  .homeCategoriesList!
                                                                  .length +
                                                              1,
                                                        ));
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 300,
                                                child: GridView.builder(
                                                  shrinkWrap: true,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 19),
                                                  itemCount: state
                                                      .homeData!
                                                      .homeCategoriesList!
                                                      .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisSpacing: 23,
                                                          mainAxisSpacing: 15,
                                                          mainAxisExtent: 97,
                                                          crossAxisCount: 2),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CustomCategory(
                                                      onTap: () {
                                                        AppRouter.push(
                                                            context,
                                                            ALlSectionScreen(
                                                              index: index + 1,
                                                              tabControllerLength: state
                                                                      .homeData!
                                                                      .homeCategoriesList!
                                                                      .length +
                                                                  1,
                                                            ));
                                                      },
                                                      categoryImage: state
                                                          .homeData!
                                                          .homeCategoriesList![
                                                              index]
                                                          .imageUrl,
                                                      categoryName: state
                                                                  .homeData!
                                                                  .homeCategoriesList![
                                                                      index]
                                                                  .name !=
                                                              null
                                                          ? state
                                                              .homeData!
                                                              .homeCategoriesList![
                                                                  index]
                                                              .name!
                                                          : "",
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                                  state.homeData!.homeBannerListTopSection!
                                          .isNotEmpty
                                      ? CustomHomeCursel(
                                          verticalPadding: state
                                                  .homeData!
                                                  .homeSuggestedProductsList!
                                                  .isNotEmpty
                                              ? 0
                                              : 0,
                                          bannerList: state.homeData!
                                              .homeBannerListTopSection,
                                          height: 164,
                                        )
                                      : const SizedBox(),
                                  state.homeData!.homeSuggestedProductsList!
                                          .isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: AppVAlueConst
                                                  .homeVerticalPadding),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 33,
                                                        vertical: 0),
                                                child: CustomSectionName(
                                                  sectionName:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .suggested_products,
                                                  onTap: () {},
                                                ),
                                              ),
                                              SizedBox(
                                                height: 259,
                                                width: 1.sw,
                                                child: ListView.builder(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 13,
                                                      horizontal: 15),
                                                  itemCount: state
                                                      .homeData!
                                                      .homeSuggestedProductsList!
                                                      .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        AppRouter.push(
                                                            context,
                                                            ProductDetailsScreen(
                                                              id: state
                                                                  .homeData!
                                                                  .homeSuggestedProductsList![
                                                                      index]
                                                                  .id,
                                                            ));
                                                      },
                                                      child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional.only(
                                                                  bottom: 0,
                                                                  start:
                                                                      index == 0
                                                                          ? 0
                                                                          : 15),
                                                          child: CustomProductCard(
                                                              isSellerFound: state
                                                                          .homeData!
                                                                          .homeSuggestedProductsList![
                                                                              index]
                                                                          .sellerName !=
                                                                      null
                                                                  ? true
                                                                  : false,
                                                              isDisCount:
                                                                  state.homeData!.homeSuggestedProductsList![index].discountStatus == "1"
                                                                      ? true
                                                                      : false,
                                                              productInfo: state
                                                                  .homeData!
                                                                  .homeSuggestedProductsList![index])),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                                  state.homeData!.homeBannerListBottomSection!
                                          .isNotEmpty
                                      ? CustomHomeCursel(
                                          verticalPadding: state
                                                  .homeData!
                                                  .homeSuggestedProductsList!
                                                  .isNotEmpty
                                              ? 0
                                              : 10,
                                          bannerList: state.homeData!
                                              .homeBannerListBottomSection,
                                          height: 164,
                                        )
                                      : const SizedBox(),
                                  state.homeData!.homeDiscountedProductsList!
                                          .isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: AppVAlueConst
                                                  .homeVerticalPadding),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 33,
                                                        vertical: 0),
                                                child: CustomSectionName(
                                                  sectionName:
                                                      AppLocalizations.of(
                                                              context)!
                                                          .discounts,
                                                  onTap: () {},
                                                ),
                                              ),
                                              SizedBox(
                                                height: 259,
                                                width: 1.sw,
                                                child: ListView.builder(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 13,
                                                      horizontal: 15),
                                                  itemCount: state
                                                      .homeData!
                                                      .homeDiscountedProductsList!
                                                      .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        AppRouter.push(
                                                            context,
                                                            ProductDetailsScreen(
                                                              id: state
                                                                  .homeData!
                                                                  .homeDiscountedProductsList![
                                                                      index]
                                                                  .id,
                                                            ));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .only(
                                                                    bottom: 0,
                                                                    start: index ==
                                                                            0
                                                                        ? 0
                                                                        : 15),
                                                        child: CustomProductCard(
                                                            isSellerFound: state
                                                                        .homeData!
                                                                        .homeDiscountedProductsList![
                                                                            index]
                                                                        .sellerName !=
                                                                    null
                                                                ? true
                                                                : false,
                                                            isDisCount: state
                                                                        .homeData!
                                                                        .homeDiscountedProductsList![
                                                                            index]
                                                                        .discountStatus ==
                                                                    "1"
                                                                ? true
                                                                : false,
                                                            productInfo: state
                                                                    .homeData!
                                                                    .homeDiscountedProductsList![
                                                                index]),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            )
                          : state.screenState == ScreenState.error
                              ?
                              // todo error try again
                              const Text("try again")
                              : const SizedBox()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
