class ApiUrl {
  static String baseUrl = 'https://staging.kodago.com/api_v2/';
  // static String baseUrl = 'https://www.kodago.com/api_v2/';
  /// auth api url
  static String loginUrl = '${baseUrl}authentication/login';
  static String registerUrl = '${baseUrl}authentication/register';
  static String resendOtpUrl = '${baseUrl}authentication/resendotp';
  static String forgotResendUrl = '${baseUrl}authentication/forgot_resendotp';
  static String verifyOtpUrl = '${baseUrl}authentication/otpverify';
  static String forgotPasswordUrl = '${baseUrl}authentication/forgot_password';
  static String forgotResetApiUrl = '${baseUrl}authentication/forgot_reset';

  /// profile
  static String getProfileUrl = '${baseUrl}authentication/get_profile';
  static String updateProfileUrl = '${baseUrl}authentication/edit_profile';
  static String updateImageUrl = "${baseUrl}authentication/update_user_image";
  static String changePasswordUrl = '${baseUrl}authentication/change_password';

  /// feeds
  static String feedsUrl = '${baseUrl}groups/feeds';

  /// notification
  static String notificationUrl = '${baseUrl}groups/notifications';
  static String deleteNotificationApi = "${baseUrl}groups/read_notification";

  /// group
  static String groupUrl = '${baseUrl}groups/index';
  static String groupDetailsUrl = '${baseUrl}groups/members';
  static String updateGroupNameUrl = '${baseUrl}groups/update_group';
  static String exitGroupUrl = 'groups/member_action';
  static String updateGroupImageUrl = "${baseUrl}groups/update_group_image";

  /// file rack
  static String createFileRackUrl = '${baseUrl}sheets/createSheet';
  static String fileRackListUrl = '${baseUrl}sheets/index';
  static String deleteFileRackUrl = '${baseUrl}sheets/deleteSheet';
}
