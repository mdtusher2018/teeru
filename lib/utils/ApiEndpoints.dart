class ApiEndpoints {
  static const String baseUrl = 'https://api.teerusn.com/api/v1/';
  static const String baseImageUrl = 'https://api.teerusn.com';

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

  // Event endpoints
  static const String allEvents = "event/all";
  static const String category = 'category';
  static const String specificCategoryEvent = 'event/speceficCategoryEvent/';
  static const String eventById = 'event/'; // Append event id dynamically
  static const String upcomingEvents = 'event/upcoming';

  // Ticket endpoints
  static const String myTickets = 'ticket/myTickets';
  static const String buyTicket = 'ticket/buy';
}
