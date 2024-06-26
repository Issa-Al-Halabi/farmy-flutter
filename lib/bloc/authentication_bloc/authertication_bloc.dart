import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../core/app_enum.dart';
import '../../data/data_resource/local_resource/data_store.dart';
import '../../data/repository/user_repository.dart';
import '../../models/login_response.dart';
import '../../models/otp_verify_response.dart';
import '../../models/params/forget_password_params.dart';
import '../../models/params/otp_confirm_params.dart';
import '../../models/params/reset_password_params.dart';
import '../../models/params/sign_up_params.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  LoginResponse? loginResponse;
  OtpVerifyResponse? otpVerifyResponse;
  bool loggedIn = true;
  bool isCheckPolicy = false;
  OtpConfirmParams otpConfirmParams = OtpConfirmParams();
  SignUpParams signUpParams = SignUpParams();

  AuthenticationBloc(
    this.userRepository,
  ) : super(AuthenticationState()) {
    on<AuthenticationEvent>((event, emit) async {
      final PackageInfo info = await PackageInfo.fromPlatform();
      if (event is AppStarted) {
        print('!!!!!!!!!!!');
        DataStore.instance.setVersion(info.version);
        final bool hasToken = await userRepository.hasToken();
        await Future.delayed(const Duration(seconds: 3)).then((value) {
          /// he logged in -> go to home page
          if (hasToken) {
            loggedIn = true;
            loginResponse = DataStore.instance.userInfo;
            emit(state.copyWith(
                authenticationScreenStates: AuthenticationScreenStates.authenticationAuthenticated,
            ),
            );
          }

          /// he did not login -> go {as guest or see if he logged out or start from start}
          else {
            /// want to enter as a guest
            if (loggedIn == false) {
              emit(state.copyWith(
                  authenticationScreenStates:
                      AuthenticationScreenStates.authenticationGuest));
            }

            /// want to enter { from on boarding or to login if he already logged out }
            else {
              emit(state.copyWith(
                  authenticationScreenStates:
                      DataStore.instance.isShowOnBoarding == true
                          ? AuthenticationScreenStates.authenticationLoggedOut
                          : AuthenticationScreenStates
                              .authenticationUnauthenticated));
            }
          }
        });
      }
      if (event is LoggedGuest) {
        loggedIn = false;
        // emit(state.copyWith(
        //     authenticationScreenStates:AuthenticationScreenStates.authenticationGuest));
      }
      if (event is TapOnPressed) {
        emit(state.copyWith(index: event.index));
      }
      if (event is Login) {
        emit(state.copyWith(isLoading: true));
        final response = await userRepository.logIn(
          loginParams: event.loginParams,
        );
        response.fold((l) {
          emit(state.copyWith(error: l, signUp: true));
        }, (r) async {
          loggedIn = true;
          loginResponse = r;
          DataStore.instance.setUserInfo(loginResponse!);
          DataStore.instance.setToken(loginResponse!.token ?? "");

          // FirebaseNotificationsHandler().refreshFcmToken().then((value) async {
          //   userRepository.saveFCMToken(value);
          //
          // });
          emit(state.copyWith(
              authenticationScreenStates:
                  AuthenticationScreenStates.authenticationAuthenticated,
              login: true));
        });
      }
      if (event is LoggedOut) {
        emit(state.copyWith(authenticationScreenStates: AuthenticationScreenStates.authenticationInitialized));
        await userRepository.logout().then((value) {
          userRepository.deleteToken();
          DataStore.instance.deleteUserInfo();
          emit(state.copyWith(authenticationScreenStates: AuthenticationScreenStates.authenticationLoggedOut));
        });
      }
      if (event is DeleteAccount) {
        emit(state.copyWith(isLoading: true));
        final response =
            await userRepository.deleteAccount(event.deleteAccountParams);
        response.fold((l) {
          emit(state.copyWith(error: l));
        }, (r) {
          userRepository.deleteToken();
          DataStore.instance.deleteUserInfo();
          emit(state.copyWith(
              authenticationScreenStates:
                  AuthenticationScreenStates.authenticationLoggedOut,
              isDeleteAccount: true));
        });
      }
      if (event is RequestOtp) {
        emit(state.copyWith(isLoading: true));
        final response =
            await userRepository.signUpPhoneNumber(event.phoneNumber);
        response.fold((l) {
          emit(state.copyWith(error: l));
        }, (r) {
          otpVerifyResponse = r;
          emit(state.copyWith(sendOtp: true));
        });
      }
      if (event is ConfirmOtp) {
        emit(state.copyWith(isLoading: true));

        otpConfirmParams.phone = otpVerifyResponse?.phone;

        otpConfirmParams.code = event.code;
        final response = await userRepository.confirmOtp(otpConfirmParams);
        response.fold((l) {
          emit(state.copyWith(error: l));
        }, (r) {
          // signUpParams.phone = otpConfirmParams.phone;
          emit(state.copyWith(confirmOtp: true));
        });
      }
      if (event is ForgetPassword) {
        emit(state.copyWith(isLoading: true));
        ForgetPasswordParams forgetPasswordParams = ForgetPasswordParams(
          phone: otpVerifyResponse?.phone,
          newPassword: event.password,
          newPasswordConfirm: event.repeatPassword,
        );
        var response =
            await userRepository.forgetPassword(forgetPasswordParams);
        response.fold((l) {
          emit(state.copyWith(error: l));
        }, (r) {
          emit(state.copyWith(isSuccess: true));
        });
      }
      if (event is SignUp) {
        emit(state.copyWith(isLoading: true));
        var response = await userRepository.signUp(signUpParams);
        response.fold((l) {
          emit(state.copyWith(error: l));
        }, (r) {
          // FirebaseNotificationsHandler().refreshFcmToken().then((value) async {
          //   userRepository.saveFCMToken(value);
          // });
          emit(state.copyWith(signUp: true));
        });
      }
      if (event is ReSendCode) {
        emit(state.copyWith(isReSend: true));
        final response = await userRepository.signUpPhoneNumber(event.phone);
        response.fold((l) {
          emit(state.copyWith(error: l));
        }, (r) {
          otpVerifyResponse = r;
          emit(state.copyWith(sendOtp: true));
        });
      }
      if (event is ChangeCheckPolice) {
        emit(state.copyWith(isCheckPolicy: event.isCheck));
      }
      if (event is ResetPassword) {
        emit(state.copyWith(isLoading: true));

        ResetPasswordParams forgetPasswordParams = ResetPasswordParams(

            password: event.password,
            repeatPassword: event.repeatPassword,
            oldPassword: event.oldPassword);
        var response = await userRepository.resetPassword(forgetPasswordParams);
        response.fold((l) {
          emit(state.copyWith(error: l));
        }, (r) {
          userRepository.deleteToken();
          DataStore.instance.deleteUserInfo();
          emit(state.copyWith(resetPassword: true,authenticationScreenStates: AuthenticationScreenStates.authenticationLoggedOut));
        });
      }
      if(event is ChangeLang){
        emit(state.copyWith(authenticationScreenStates: AuthenticationScreenStates.authenticationInitialized));
      }
    });
  }
}
