import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/screens/home_screen/widgets/custom_app_bar.dart';

import '../../widgets/custom_back_to_previos.dart';
import 'widgets/custom_sub_category.dart';

class ALlSectionScreen extends StatelessWidget {
  List<String> tabTitles = [
    "خضارو وفواكه ومكسرات",
    "مكسرات",
    "فواكه",
    "فواكه",
    "فواكه",
    "فواكه"
  ];
  ALlSectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      initialIndex: 0,
      child: Scaffold(
        body: SizedBox(
          // height: 420,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const CustomBackToPrevios(sectionName: "جميع الاقسام"),
              SizedBox(
                width: 1.sw,
                child: TabBar(
                  onTap: (value) {},
                  isScrollable: true,
                  indicatorColor: ColorManager.primaryGreen,
                  labelColor: ColorManager.primaryGreen,
                  unselectedLabelColor: ColorManager.grayForMessage,
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: tabTitles.map((title) {
                    return Tab(
                      text: title,
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  children: tabTitles.map((title) {
                    return CustomSubCategory();
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}