import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma/bloc/home_bloc/home_bloc.dart';
import 'package:pharma/core/app_router/app_router.dart';
import 'package:pharma/presentation/resources/assets_manager.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/screens/all_product/all_product_screen.dart';
import 'package:pharma/presentation/screens/basket_screen/basket_screen.dart';
import 'package:pharma/presentation/screens/basket_screen/basket_screen.dart';
import 'package:pharma/presentation/screens/home_screen/home_screen.dart';
import 'package:pharma/presentation/screens/product_details/product_details_screen.dart';

import '../all_section/all_section_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> childern = [
    const HomeScreen(),
    const ProductDetailsScreen(),
    const BasketScreen(),
    ALlSectionScreen(),
    AllLProductScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeScreen(),
      bottomNavigationBar: Container(
        height: 70,
        child: BottomNavigationBar(
            showUnselectedLabels: true,
          
            currentIndex: context.read<HomeBloc>().currentIndex,
            selectedItemColor: ColorManager.primaryGreen,
            unselectedItemColor: ColorManager.greyForUnSleactedItem,
            onTap: (value) {
              context.read<HomeBloc>().currentIndex = value;

              setState(() {
                if (value != 0) {
                  AppRouter.push(context, childern[value]);
                }
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    ImageManager.homeIcon,
                    color: context.read<HomeBloc>().currentIndex == 0
                        ? ColorManager.primaryGreen
                        : ColorManager.greyForUnSleactedItem,
                  ),
                  label: "المتجر"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    ImageManager.favoriteIcon,
                    color: context.read<HomeBloc>().currentIndex == 1
                        ? ColorManager.primaryGreen
                        : ColorManager.greyForUnSleactedItem,
                  ),
                  label: "المفضلة"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    ImageManager.basketIcon,
                    color: context.read<HomeBloc>().currentIndex == 2
                        ? ColorManager.primaryGreen
                        : ColorManager.greyForUnSleactedItem,
                  ),
                  label: "السلة"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    ImageManager.homeIcon,
                    color: context.read<HomeBloc>().currentIndex == 3
                        ? ColorManager.primaryGreen
                        : ColorManager.greyForUnSleactedItem,
                  ),
                  label: "طلباتي"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    ImageManager.profileIcon,
                    color: context.read<HomeBloc>().currentIndex == 4
                        ? ColorManager.primaryGreen
                        : ColorManager.greyForUnSleactedItem,
                  ),
                  label: "حسابي"),
            ]),
      ),
    );
  }
}
