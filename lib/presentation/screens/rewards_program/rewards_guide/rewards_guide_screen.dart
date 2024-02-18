import 'package:flutter/material.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/resources/font_app.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import 'package:pharma/presentation/screens/base_screen/base_screen.dart';
import 'package:pharma/presentation/screens/rewards_program/rewards_guide/widget/membership_levels_widget.dart';
import 'package:pharma/presentation/screens/rewards_program/rewards_guide/widget/rewards_guide_widget.dart';

class RewardsGuideScreen extends StatelessWidget {
  const RewardsGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreenScaffold(
      appbarTitle: "برنامج المكافئات \"مرحبا\"",
      isComeBack: true,
      body: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: ColorManager.white,
                  appBar: AppBar(
                    backgroundColor: ColorManager.white,
                    shadowColor: ColorManager.grayForMessage,
                    toolbarHeight: 0,
                    automaticallyImplyLeading: false,
                    bottom: TabBar(
                      labelPadding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: ColorManager.primaryGreen,
                      unselectedLabelColor: ColorManager.grayForMessage,
                      labelColor: ColorManager.primaryGreen,
                      labelStyle: getBoldStyle(
                          color: ColorManager.grayForMessage,
                          fontSize: FontSizeApp.s14),
                      tabs: const [
                        Tab(
                          child: Text("دليل المكافئات"),
                        ),
                        Tab(
                          child: Text("مستويات العضوية و مزاياها"),
                        ),
                      ],
                    ),
                  ),
                  body: const TabBarView(
                    children: [
                      RewardsGuideWidget(),
                      MembershipLevelsWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
