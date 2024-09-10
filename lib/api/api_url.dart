class ApiUrl {
  static String baseUrl = 'https://staging.kodago.com/api_v2/';
  // static String baseUrl = 'https://www.kodago.com/api_v2/';
  static String loginUrl = '${baseUrl}authentication/login';
  static String registerUrl = '${baseUrl}authentication/register';
  static String resendOtpUrl = '${baseUrl}authentication/resendotp';
  static String forgotResendUrl = '${baseUrl}authentication/forgot_resendotp';
  static String verifyOtpUrl = '${baseUrl}authentication/otpverify';
  static String forgotPasswordUrl = '${baseUrl}authentication/forgot_password';
  static String forgotResetApiUrl = '${baseUrl}authentication/forgot_reset';
}
