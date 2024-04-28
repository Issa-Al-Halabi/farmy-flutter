import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/bloc/products_bloc/products_bloc.dart';
import 'package:pharma/core/app_enum.dart';
import 'package:pharma/core/app_router/app_router.dart';
import 'package:pharma/core/services/services_locator.dart';
import 'package:pharma/models/sub_category_response.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import 'package:pharma/presentation/screens/product_details/product_details_screen.dart';
import 'package:pharma/presentation/widgets/custom_no_dataa.dart';
import 'package:pharma/presentation/widgets/custom_prdouct_card.dart';
import 'package:pharma/presentation/widgets/custom_product_shimmer.dart';
import 'package:pharma/translations.dart';

import '../../../bloc/basket_bloc/basket_bloc.dart';
import '../../../models/product_response.dart';
import '../../resources/color_manager.dart';
import '../../widgets/custom_app_bar_screen.dart';
import '../basket_screen/basket_screen.dart';

class AllProductScreen extends StatefulWidget {
  final List<SubCategoryResponse>? subCategoryList;
  final int index;

  const AllProductScreen(
      {super.key, required this.subCategoryList, required this.index});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductsBloc>()
        ..add(GetProductsBySubCategoryId(
            id: widget.subCategoryList![widget.index].id!)),
      child: AllProductBody(
          subCategoryList: widget.subCategoryList, index: widget.index),
    );
  }
}

class AllProductBody extends StatefulWidget {
  final List<SubCategoryResponse>? subCategoryList;
  int index;

  AllProductBody(
      {super.key, required this.subCategoryList, required this.index});

  @override
  State<AllProductBody> createState() => _AllLProductBodyState();
}

class _AllLProductBodyState extends State<AllProductBody> {
  // late TabController _tabController;
  late Map<int, bool> isAdd;

  @override
  void initState() {
    // _tabController =
    //     TabController(length: widget.subCategoryList!.length, vsync: this);
    isAdd = {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return DefaultTabController(
          length: widget.subCategoryList!.length,
          initialIndex: widget.index,
          child: SafeArea(
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomAppBarScreen(
                      sectionName: widget
                          .subCategoryList![widget.index].subCategoryName!),
                  SizedBox(
                    width: 1.sw,
                    child: TabBar(
                      onTap: (value) {
                        context.read<ProductsBloc>().add(
                              GetProductsBySubCategoryId(
                                id: widget.subCategoryList![value].id!,
                              ),
                            );
                      },
                      isScrollable: true,
                      indicatorColor: ColorManager.primaryGreen,
                      labelColor: ColorManager.primaryGreen,
                      unselectedLabelColor: ColorManager.grayForMessage,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: widget.subCategoryList!.map((title) {
                        return Tab(
                          text: title.subCategoryName,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: IndexedStack(
                      children: widget.subCategoryList!.map((title) {
                        return state.screenState == ScreenState.loading
                            ? const CustomProductShimmer()
                            : state.screenState == ScreenState.success
                                ? state.productsList.isNotEmpty
                                    ? Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          GridView.builder(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8.h,
                                              horizontal: 5.w,
                                            ),
                                            itemCount:
                                                state.productsList.length,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              // childAspectRatio: 15 / 2,
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 26,
                                              mainAxisExtent: 232,
                                            ),
                                            itemBuilder: (context, index) {
                                              isAdd.putIfAbsent(
                                                  index,
                                                  () => context
                                                      .read<BasketBloc>()
                                                      .mutableProducts
                                                      .any((element) =>
                                                          element.id ==
                                                          state
                                                              .productsList[
                                                                  index]
                                                              .id));
                                              return Center(
                                                child: InkWell(
                                                  onLongPress: () {
                                                    if (context
                                                        .read<BasketBloc>()
                                                        .mutableProducts
                                                        .isEmpty) {
                                                      AppRouter.push(
                                                        context,
                                                        ProductDetailsScreen(
                                                          id: state
                                                              .productsList[
                                                                  index]
                                                              .id,
                                                        ),
                                                      );
                                                    } else {
                                                      if (!context
                                                          .read<BasketBloc>()
                                                          .mutableProducts
                                                          .any((element) =>
                                                              element.id ==
                                                              state
                                                                  .productsList[
                                                                      index]
                                                                  .id)) {
                                                        context
                                                            .read<BasketBloc>()
                                                            .add(AddToBasket(
                                                                product: [
                                                                  ProductResponse(
                                                                    quantity: 1,
                                                                    image: state
                                                                        .productsList[
                                                                            index]
                                                                        .image,
                                                                    id: state
                                                                        .productsList[
                                                                            index]
                                                                        .id,
                                                                    discountPrice: state
                                                                        .productsList[
                                                                            index]
                                                                        .discountPrice,
                                                                    discountStatus: state
                                                                        .productsList[
                                                                            index]
                                                                        .discountStatus,
                                                                    availabilityOfProduct: state
                                                                        .productsList[
                                                                            index]
                                                                        .availabilityOfProduct,
                                                                    nameOfProduct: state
                                                                        .productsList[
                                                                            index]
                                                                        .nameOfProduct,
                                                                    price: state
                                                                        .productsList[
                                                                            index]
                                                                        .price,
                                                                    sellerName: state
                                                                        .productsList[
                                                                            index]
                                                                        .sellerName,
                                                                  )
                                                                ]));
                                                        setState(() {
                                                          isAdd[index] =
                                                              !isAdd[index]!;
                                                        });
                                                      }
                                                    }
                                                  },
                                                  onTap: () {
                                                    AppRouter.push(
                                                      context,
                                                      ProductDetailsScreen(
                                                        id: state
                                                            .productsList[index]
                                                            .id,
                                                      ),
                                                    );
                                                  },
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      CustomProductCard(
                                                        productInfo:
                                                            state.productsList[
                                                                index],
                                                      ),
                                                      isAdd[index]!
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Container(
                                                                        color: Colors.green,
                                                                        width: 20,
                                                                        height: 20,
                                                                        child: Center(
                                                                            child: Text(
                                                                          "1",
                                                                          style:
                                                                              getBoldStyle(color: Colors.white),
                                                                        ))),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      if (context
                                                                          .read<
                                                                              BasketBloc>()
                                                                          .mutableProducts
                                                                          .any((element) =>
                                                                              element.id ==
                                                                              state.productsList[index].id)) {
                                                                        context.read<BasketBloc>().add(DeleteProduct(state
                                                                            .productsList[index]
                                                                            .id));
                                                                        setState(
                                                                            () {
                                                                          isAdd[index] =
                                                                              !isAdd[index]!;
                                                                        });
                                                                      }
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .red,
                                                                        width:
                                                                            20,
                                                                        height:
                                                                            20,
                                                                        child: const Icon(
                                                                            Icons
                                                                                .remove,
                                                                            color:
                                                                                Colors.white,
                                                                            size: 20),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          context
                                                  .read<BasketBloc>()
                                                  .mutableProducts
                                                  .isNotEmpty
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    child: SizedBox(
                                                      width: 1.sw - 100,
                                                      child: Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          Container(
                                                            height: 40.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: ColorManager
                                                                  .primaryGreen,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                            child: Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .view_basket,
                                                                    style:
                                                                        getBoldStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    "( ${context.read<BasketBloc>().finalPrice().toString()} ${AppLocalizations.of(context)!.curruncy} ) ",
                                                                    style:
                                                                        getBoldStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: -10,
                                                            left: -5,
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color:
                                                                    ColorManager.yellow,
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Text(
                                                                  context
                                                                      .read<
                                                                          BasketBloc>()
                                                                      .mutableProducts
                                                                      .length
                                                                      .toString(),
                                                                  style:
                                                                      getBoldStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      AppRouter.push(context,
                                                          const BasketScreen());
                                                    },
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      )
                                    : CustomNoData(
                                        noDataStatment:
                                            AppLocalizations.of(context)!
                                                .thereIsNoProduct)
                                : const SizedBox();
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
