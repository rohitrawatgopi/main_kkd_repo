class ApiEndpoints {
  static String baseUrl = "https://api.kkdstributors.net/";

  static String loginURL = "api/user/login";
  static String singnUpURL = "api/user/signup";
  static String getCategories = "api/user/get-categories";
  static String aadhar = "api/user/upload-aadhar";
  static String passbook = "api/user/upload-passbook";
  static String panCard = "api/user/upload-pan";
  static String getUser = "api/user/get-user";
  static String getPermotion = "api/user/get-promotions";
  static String updateUser = "api/user/update-profile";
  static String qr = "api/user/scan-qr";
  static String product = "api/user/get-products";
  static String withdraw = "api/user/create-withdrawal-req";
  static String offer = "api/user/get-offer-products";
  static String getPandingWithdrawl = "api/user/get-pending-withdrawals";
  static String deleteAccount = "api/user/app/request-delete";
  static String forgotPassward = "api/user/app/forgotPassward";
  static String sendOTP = "api/user/forgot-password/send-otp";
  static String verify = "api/user/forgot-password/verify-otp";
  static String upadtePassword = "api/user/forgot-password/set-new-password";
  static String termsPrivacy =
      "https://kkd-rgm5.onrender.com/terms-and-privacy";

  // static String ProductCategoryFilter = api/user/get-products?category=6875f67f84a4b9bf99e6bbe3";
  // static String ProductCategoryFilter = api/user/get-products?category=6875f67f84a4b9bf99e6bbe3";
  // static String ProductSearchFilter = api/user/get-products?search=butter";
  // static String ProductPageLimit = api/user/get-products?page=2&limit=5";
}
