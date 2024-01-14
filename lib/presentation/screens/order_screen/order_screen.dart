
import 'package:flutter/material.dart';
import 'package:pharma/presentation/screens/order_screen/widgets/card_order.dart';
import 'package:pharma/presentation/widgets/custom_app_bar_screen.dart';
import 'package:pharma/presentation/widgets/over_scroll_indicator.dart';
import 'package:pharma/translations.dart';

import '../../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../../core/services/services_locator.dart';
import '../guest_screen/guest_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          CustomAppBarScreen(sectionName: AppLocalizations.of(context)!.my_order),
          Expanded(
            child:  sl<AuthenticationBloc>().loggedIn?CustomOverscrollIndicator(
              child: ListView.builder(
                itemBuilder: (context, index) =>const CardOrder() ,
              itemCount:10,),
            ):const GuestScreen(),
          )
        ]),
      ),
    );
  }
}