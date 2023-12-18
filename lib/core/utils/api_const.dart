class ApiConst {
  static const String baseUrl = "https://control.farmy.peaklink.site/public/api";

  ///Auth
  static const String login = "/auth/login";
  static const String logout = "/auth/logout";
  static const String generateOtp = "/auth/generate-otp";
  static const String verifyOtp = "/auth/verify-otp";
  static const String changePassword = "/auth/change-password";

  static const String signUp = "/users";

  ///Categories
  static const String getAllCategoties = "/categories";
  static String getSubCategories(int id) => "/categories/$id";
  static String getProductBySubCategoryId(int id) => "/sub_categories/$id";


  ///Address
  static const String getUserAddresses = "/user_addresses";
  static const String addUserAddresses = "/user_addresses";
}
