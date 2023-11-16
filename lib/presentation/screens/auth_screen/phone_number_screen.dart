import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:pharma/core/app_router/app_router.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import 'package:pharma/presentation/screens/auth_screen/%20widgets/button_auth.dart';
import 'package:pharma/presentation/screens/auth_screen/%20widgets/input_field_auth.dart';
import '../../../translations.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen>with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Column(
        children: [
          const SizedBox(
            height: 93,
          ),
          Text(AppLocalizations.of(context)!.reset_password,
              style: getBoldStyle(color: Colors.white, fontSize: 29)),
          const SizedBox(
            height: 58,
          ),
          InputFieldAuth(
            hintText: AppLocalizations.of(context)!.phone,
            suffixIcon: const CountryCodePicker(
                showCountryOnly: true,
                flagWidth: 20,
enabled: false,
                initialSelection: 'SY',
            )
          ),
          const SizedBox(
            height: 24,
          ),

          const SizedBox(
            height: 31,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 310,
                height: 81,
                child: Text(AppLocalizations.of(context)!.reset_link,
                    style: getSemiBoldStyle(color: Colors.white,fontSize: 14),maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

            ],
          ),
          const SizedBox(
            height: 64,
          ),
          ButtonAuth(
              label: AppLocalizations.of(context)!.done,
              onTap: () {

              }),
          const SizedBox(
            height: 13,
          ),
          ButtonAuth(
              label: AppLocalizations.of(context)!.resend,
              onTap: () {
                AppRouter.pop(context);

                //   AppRouter.push(context, AccountScreen());
              }),
          const SizedBox(
            height: 13,
          )
        ],
      ),
    );
  }
}