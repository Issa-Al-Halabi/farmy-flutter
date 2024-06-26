import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pharma/models/profile_model.dart';
import '../../core/utils/api_const.dart';
import '../../models/login_response.dart';
import '../../models/otp_verify_response.dart';
import '../../models/params/delete_account_params.dart';
import '../../models/params/forget_password_params.dart';
import '../../models/params/login_params.dart';
import '../../models/params/otp_confirm_params.dart';
import '../../models/params/reset_password_params.dart';
import '../../models/params/sign_up_params.dart';
import '../data_resource/local_resource/data_store.dart';
import '../data_resource/remote_resource/api_handler/base_api_client.dart';

class UserRepository {
  Future<Either<String, LoginResponse>> logIn({LoginParams? loginParams}) async {
    print('+++++++++++');
    print(loginParams!.deviceToken);
    print('+++++++++++');

    return BaseApiClient.post<LoginResponse>(
        url: ApiConst.login,
        formData: loginParams.toJson(),
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return LoginResponse.fromJson(e['data']);
        });
  }

  void deleteToken() async {
    DataStore.instance.deleteToken();
  }

  Future<bool> hasToken() async {
    return DataStore.instance.hasToken;
  }

  void saveToken(String token) {
    DataStore.instance.setToken(token);
  }

  Future<Either<String, OtpVerifyResponse>> signUpPhoneNumber(
      String phoneNumber) async {
    return BaseApiClient.post<OtpVerifyResponse>(
        url: ApiConst.generateOtp,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        formData: {
          "phone": phoneNumber,
        },
        converter: (e) {
          return OtpVerifyResponse.fromJson(e['data']);
        });
  }

  Future<Either<String, bool>> confirmOtp(
      OtpConfirmParams? otpConfirmParams) async {
    return BaseApiClient.post<bool>(
        url: ApiConst.verifyOtp,
        queryParameters: otpConfirmParams?.toJson(),
        converter: (e) {
          return true;
        });
  }

  Future<Either<String, bool>> forgetPassword(
      ForgetPasswordParams forgetPasswordParams) async {
    return BaseApiClient.post<bool>(
        url: ApiConst.changePassword,
        formData: forgetPasswordParams.toJson(),
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return true;
        });
  }

  Future<Either<String, bool>> logout() async {
    return BaseApiClient.post<bool>(
        url: ApiConst.logout,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return true;
        });
  }

  Future<Either<String, bool>> deleteAccount(
      DeleteAccountParams deleteAccountParams) async {
    return BaseApiClient.post<bool>(
        url: ApiConst.deleteAccount,
        formData: deleteAccountParams.toJson(),
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return true;
        });
  }

  Future<Either<String, String>> signUp(SignUpParams? signUpParams) async {
    return BaseApiClient.post<String>(
        url: ApiConst.signUp,
        formData: FormData.fromMap(signUpParams!.toJson()),
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return e['data']['name'];
        });
  }

  static Future<Either<String, LoginResponse>> editProfile(
      ProfileModel profileModel) async {
    print(profileModel.toJson());
    print(FormData.fromMap(profileModel.toJson()));

    return BaseApiClient.post<LoginResponse>(
        url: ApiConst.updateProfile,
        formData: FormData.fromMap(profileModel.toJson()),
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return LoginResponse.fromJson(e['data']);
        });
  }

  static Future<Either<String, ProfileModel>> getProfile() {
    return BaseApiClient.get<ProfileModel>(
        url: ApiConst.profile,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        converter: (e) {
          return ProfileModel.fromJson(e['data']);
        });
  }
  Future<Either<String, bool>> resetPassword(
      ResetPasswordParams forgetPasswordParams) async {
    return BaseApiClient.post<bool>(
        url: ApiConst.resetPassword,
        queryParameters: {
          'lang': DataStore.instance.lang,
        },
        formData:  {
            "old_password":forgetPasswordParams.oldPassword,
            "password":forgetPasswordParams.password,
            "password_confirmation":forgetPasswordParams.repeatPassword

        },
        converter: (e) {
          return true;
        });}
}
