class AppApi {
  static const String apiVer = "";
  //authentication
  static const String login = "$apiVer/auth/login/";
  static const String signup = "$apiVer/auth/signup/";
  static const String refreshToken = "$apiVer/auth/refresh-token/";
  static const String logout = "$apiVer/auth/logout/";
  static const String resetPassword = "$apiVer/reset-password/";
  static const String resetPasswordCheckToken = "$apiVer/reset-password/check-token";

  //users
  static const String userMe = "$apiVer/users/me/";
  static const String deleteAccount = "$apiVer/users/me";
  static const String changePassword = "$apiVer/users/change-password/";
  static const String user = "$apiVer/users";
  static const String finishGuidance = "$apiVer/users/finish-guidance";
  static const String seasonStartTime = "$apiVer/histories/season-start-time";

  //partner
  static const String purchasePartners = "$apiVer/partners/sellers";
  static const String sellPartners = "$apiVer/partners/purchasers";
  static const String transportPartners = "$apiVer/partners/transporters";
  static const String deletePartner = "$apiVer/partners/";
  static const String searchBrokerPartner = "$apiVer/partners/search/brokers";
  static const String searchTransporterPartner = "$apiVer/partners/search/transporters";
  static const String searchChildBrokerPartner = "$apiVer/partners/search/broker-partners";
  static const String searchFacilityPartner = "$apiVer/partners/search/facilities";
  static const String inviteFacilityPartner = "$apiVer/partners/invite";
  static const String inviteTransporterPartner = "$apiVer/partners/invite/transporters";
  static const String inviteBrokerPartner = "$apiVer/partners/invite/brokers";
  static const String invitePermission = "$apiVer/partners/roles";
  static const String businessPartner = "$apiVer/partners/all";
  static String businessPartnerRefer(String facilityId) => "$apiVer/facilities/$facilityId/business-partner";

  //purchase
  static const String sellerConfig = "$apiVer/events/purchases/required-sellers";
  static const String purchaseProductDefinition = "$apiVer/product-definitions/purchased-product-definitions";
  static String getPurchaseProduct(String id) => "$apiVer/events/purchases/products/$id";
  static const String purchase = "$apiVer/events/purchases";
  //sell
  static String getSellProduct(String id) => "$apiVer/events/sells/products/$id";
  static const String sell = "$apiVer/events/sells";
  //transport
  static String getTransportProduct(String id) => "$apiVer/events/transports/products/$id";
  static const String transport = "$apiVer/events/transports";
  //record by-product
  static const String recordByProduct = "$apiVer/events/record-by-product";
  //transformation
  static String getAssignProduct(String id) => "$apiVer/events/assign-products/products/$id";
  static const String assignProduct = "$apiVer/events/assign-products";
  static const String soldProductDefinition = "$apiVer/product-definitions/sold-product-definitions";

  //SAQ
  static const String selfAssessments = "$apiVer/self-assessments";
  static const String selfAssessmentAnswers = "$apiVer/self-assessments/answers";

  // Facility
  static const String facilitiesCheckOarId = "$apiVer/facilities/check-oarId";
  static const String facilitiesRegisterOarId = "$apiVer/facilities/register-oarIds";
  static const String facilitiesRejectOarId = "$apiVer/facilities/oar-ids/reject-match";
  static const String facilitiesConfirmOarId = "$apiVer/facilities/oar-ids/confirm-match";
  static const String facilities = "$apiVer/facilities";

  //Labor reports
  static const String facilitiesIndicators = "$apiVer/categories/all";
  static const String grievanceReport = "$apiVer/grievance-reports";
  static String viewReport(String id) => "$apiVer/grievance-reports/$id";
  static String reportResponse(String id) => "$apiVer/requests/$id/responses";
  static const String addRiskScan = "$apiVer/requests";

  // Country
  static const String countries = "$apiVer/locations/countries?";
  static const String provinces = "$apiVer/locations/provinces?";
  static const String districts = "$apiVer/locations/districts?";
  static const String commodities = "$apiVer/business-details/selected-commodities";

  // history
  static const String getHistory = "$apiVer/histories";

  // Calculate chart
  static const String calculationProductTradeChart = "$apiVer/calculations";
  static const String calculationMassBalanceChart = "$apiVer/calculations/mass-balance";
  static const String calculationMarginOfError = "$apiVer/calculations/margin-of-error";

  // Files
  static const String uploadFile = "$apiVer/upload/files";
}
