import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma/bloc/authentication_bloc/authentication_state.dart';
import 'package:pharma/presentation/resources/color_manager.dart';
import 'package:pharma/presentation/screens/auth_screen/%20widgets/button_auth.dart';
import 'package:pharma/presentation/screens/auth_screen/%20widgets/input_field_auth.dart';
import 'package:pharma/presentation/screens/auth_screen/%20widgets/background_auth.dart';
import 'package:pharma/presentation/widgets/dialogs/error_dialog.dart';
import 'package:pharma/translations.dart';
import 'package:pharma/core/app_router/app_router.dart';
import 'package:pharma/presentation/resources/style_app.dart';
import '../../../bloc/authentication_bloc/authentication_event.dart';
import '../../../bloc/authentication_bloc/authertication_bloc.dart';
import '../../../core/app_validators.dart';
import '../../resources/assets_manager.dart';
import '../../widgets/password_input_field_auth.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  Color getColor(Set<MaterialState> states) {
    return Colors.white;
  }

  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.signUp == true) {
            AppRouter.pop(context);
          }
        },
        builder: (context, state) => BackGroundAuth(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formState,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(AppLocalizations.of(context)!.new_account,
                          style:
                              getBoldStyle(color: Colors.white, fontSize: 25)),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InputFieldAuth(
                                    textDirection: TextDirection.ltr,
                                    hintText:
                                        AppLocalizations.of(context)!.fName,
                                    onChange: (value) {
                                      context
                                          .read<AuthenticationBloc>()
                                          .signUpParams
                                          .fName = value;
                                    },
                                    validator: (value) {
                                      return AppValidators
                                          .validateFirstNameFields(
                                              context, value);
                                    }
                                    //   width: 1.sw-260,
                                    ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: InputFieldAuth(
                                    textDirection: TextDirection.ltr,
                                    hintText:
                                        AppLocalizations.of(context)!.lName,
                                    onChange: (value) {
                                      context
                                          .read<AuthenticationBloc>()
                                          .signUpParams
                                          .lName = value;
                                    },
                                    validator: (value) {
                                      return AppValidators
                                          .validateLastNameFields(
                                              context, value);
                                    }
                                    // width: 1.sw-260,
                                    // width: 140,
                                    ),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      InputFieldAuth(
                          textDirection: TextDirection.ltr,
                          hintText: AppLocalizations.of(context)!.hint_phone,
                          keyboardType: TextInputType.phone,
                          isPhone: true,
                          icon: Image.asset(
                            ImageManager.flagOfSyria,
                            height: 20,
                            width: 20,
                          ),
                          onChange: (value) {
                            context
                                .read<AuthenticationBloc>()
                                .signUpParams
                                .phone = value;
                          },
                          validator: (value) {
                            return AppValidators.validatePhoneFields(
                                context, value);
                          }),
                      const SizedBox(
                        height: 21,
                      ),
                      PasswordInputFieldAuth(
                          hintText: AppLocalizations.of(context)!.password,
                          contentPadding: EdgeInsets.only(right: 13.w),
                          onChange: (value) {
                            context
                                .read<AuthenticationBloc>()
                                .signUpParams
                                .password = value;
                          },
                          validator: (value) {
                            return AppValidators.validatePasswordFields(
                                context, value);
                          }),
                      const SizedBox(
                        height: 21,
                      ),
                      PasswordInputFieldAuth(
                          hintText:
                              AppLocalizations.of(context)!.confirm_password,
                          contentPadding: EdgeInsets.only(right: 13.w),
                          onChange: (value) {
                            context
                                .read<AuthenticationBloc>()
                                .signUpParams
                                .confirmPassword = value;
                          },
                          validator: (value) {
                            return AppValidators.validateRepeatPasswordFields(
                                context,
                                context
                                    .read<AuthenticationBloc>()
                                    .signUpParams
                                    .password,
                                value);
                          }),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            checkColor: ColorManager.primaryGreen,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),

                            // value: isChecked,
                            onChanged: (bool? value) {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(ChangeCheckPolice(value!));
                              // setState(() {
                              //   isChecked = value!;
                              // });
                            },
                            value: state.isCheckPolicy,
                          ),
                          InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: 1.sw - 130,
                              // height: 50,
                              child: Text(
                                AppLocalizations.of(context)!.police,
                                style: getSemiBoldStyle(color: Colors.white),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 31,
                      ),
                      ButtonAuth(
                          label: AppLocalizations.of(context)!.register,
                          onTap: () {
                            if (state.isCheckPolicy) {
                              if (_formState.currentState!.validate()) {
                                context
                                    .read<AuthenticationBloc>()
                                    .add(SignUp());
                              }
                            } else {
                              ErrorDialog.openDialog(context,
                                  AppLocalizations.of(context)!.approve);
                            }
                          }),
                      const SizedBox(
                        height: 13,
                      ),
                      ButtonAuth(
                          label: AppLocalizations.of(context)!.back,
                          onTap: () {
                            AppRouter.pop(context);
                          }),
                      const SizedBox(
                        height: 13,
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
