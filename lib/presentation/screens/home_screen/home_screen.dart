import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/presentation/resources/assets_manager.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/resources/font_app.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                        horizontal: 21, vertical: 13),
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
                            Container(
                              color: Colors.amber,
                              child: Image.asset(
                                ImageManager.location,
                                height: 30,
                                width: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.amber,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "التوصيل الى :",
                                          style: getSemiBoldStyle(
                                                  color: ColorManager.lightGray,
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
                            ),
                            Image.asset(
                              ImageManager.goForAllAdress,
                              height: 13,
                              width: 13,
                              color: ColorManager.lightGray,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 1.sw,
                        height: 61,
                        color: ColorManager.grayForMessage,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 6),
                          child: Text(
                            "asffffffffffffffffffffffffffffasسffffffffffffffffffffffffffffasffffffffffffffffffffffffffffasffffffffffffffffffffffffffffasffffffffffffffffffffffffffff",
                            style: getMoreBoldStyle(
                              color: ColorManager.lightGray,
                            ),
                          ),
                        ),
                      ),
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
