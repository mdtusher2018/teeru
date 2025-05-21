class ApiEndpoints {
  static const String baseUrl = 'http://147.93.29.184:4010/api/v1/';

  // Users
  static const String createUser = 'users/create';
  static const String createUserVerifyOtp = 'users/create-user-verify-otp';
  static const String myProfile = 'users/my-profile';
  static const String deleteMyAccount = 'users/delete-my-account';
  static const String updateMyProfile = 'users/update-my-profile';
  static const String addCard = 'users/addCard';
  static const String myCards = 'users/myCards';

  // Auth
  static const String login = 'auth/login';
  static const String forgotPasswordOtpByEmail =
      'auth/forgot-password-otpByEmail';
  static const String forgotPasswordOtpMatch = 'auth/forgot-password-otp-match';
  static const String forgotPasswordReset = 'auth/forgot-password-reset';
  static const String changePassword = 'auth/change-password';

  // Review
  static const String addReview = 'review/add';

  // Settings
  static const String contactUs = 'settings/contactUs';
}
