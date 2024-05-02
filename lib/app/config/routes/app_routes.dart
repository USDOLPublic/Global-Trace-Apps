part of 'app_pages.dart';

abstract class Routes {
  static const main = '/main_view';
  static const homeLabor = '/home_labor_view';
  static const homeProduct = '/home_product_view';
  static const login = '/login_view';
  static const register = '/register_view';
  static const onboard = '/onboard';
  static const editProfile = '/edit_profile';
  static const viewProfile = '/view_profile';
  static const resetPassword = '/reset_password_view';
  static const forgotPassword = '/forgot_password_view';
  static const selfAssessmentQuestion = '/self_assessment_question';
  static const manageBusiness = '/manage_business';
  static const addPartner = '/add_partner';
  static const registerOarId = '/register_oar_id/:tagId';
  static String registerOarIByTag(String tagId) => '/register_oar_id/$tagId';
  static const purchase = '/purchase';
  static const sell = '/sell';
  static const scanner = '/scanner';
  static const transport = '/transport';
  static const addChildPartner = '/add_child_partner';
  static const editPassword = '/edit_password';
  static const communityRiskScan = '/community_risk_scan';
  static const requestsInfo = '/requests_for_information';
  static const detailsRequestsInfo = '/details_requests';
  static const respondToRequest = '/respond_to_request';
  static const addIndicator = '/add_indicator';
  static const purchaseProductList = '/purchase_product_list';
  static const sellProductList = '/sell_product_list';
  static const transportProductList = '/transport_product_list';
  static const inputProductList = '/input_product_list';
  static const outputProductList = '/output_product_list';
  static const addProductManually = '/add_product_manually';
  static const recordByProduct = '/record_by_product';
  static const transformation = '/transformation';
  static const overview = '/overview';
}
