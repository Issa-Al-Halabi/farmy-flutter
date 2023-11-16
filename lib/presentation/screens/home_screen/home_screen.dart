import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/presentation/resources/assets_manager.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/resources/font_app.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/custom_app_bar.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/custom_home_cursel.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/custom_section_name.dart';
import 'package:pharma/presentation/widgets/custom_category.dart';
import 'package:pharma/presentation/widgets/custom_prdouct_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Column(
          children: [
            const CustomAppBar(),
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
                                        "التوصيل الى :",
                                        style: getSemiBoldStyle(
                                                color:
                                                    ColorManager.grayForMessage,
                                                fontSize: FontSizeApp.s10)!
                                            .copyWith(height: 1),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "دمشق - الميدان - بناء الادخار ",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: getMoreBoldStyle(
                                                  fontSize: FontSizeApp.s13,
                                                  color: ColorManager
                                                      .primaryGreen)!
                                              .copyWith(height: 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              ImageManager.goForAllAdress,
                              height: 13,
                              width: 13,
                              color: ColorManager.grayForMessage,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
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
                            "asffffffffffffffffffffffffffffasسffffffffffffffffffffffffffffasffffffffffffffffffffffffffffasffffffffffffffffffffffffffffasffffffffffffffffffffffffffff",
                            style: getMoreBoldStyle(
                              color: ColorManager.grayForMessage,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 33, vertical: 13),
                    child: CustomSectionName(sectionName: "الاقسام"),
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
                          categoryName: "الفواكهالفوالفواكهالفواكهالفواكهالفو",
                        );
                      },
                    ),
                  ),
                  CustomHomeCursel(
                    height: 0.5.sw,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 33, vertical: 13),
                    child: CustomSectionName(sectionName: "المنتجات المقترحة"),
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
                              start: index == 0 ? 0 : 15),
                          child: const CustomProductCard(isDisCount: true),
                        );
                      },
                    ),
                  ),
                  CustomHomeCursel(
                    height: 0.5.sw,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 33, vertical: 13),
                    child: CustomSectionName(sectionName: "الحسومات"),
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
                              start: index == 0 ? 0 : 15),
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
    );
  }
}