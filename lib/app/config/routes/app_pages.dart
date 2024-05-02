import 'package:usdol/app/pages/home/bindings/home_labor_binding.dart';

import '../../core.dart';

part 'app_routes.dart';

class AppPages {
  static const intilial = Routes.main;
  static final routes = [
    GetPage<dynamic>(
      name: Routes.main,
      page: () => const MainView(),
      binding: MainBinding(),
      transition: Transition.zoom,
    ),
    GetPage<dynamic>(
      name: Routes.homeLabor,
      page: () => const HomeView<HomeLaborController>(),
      binding: HomeLaborBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.homeProduct,
      page: () => const HomeView<HomeProductController>(),
      binding: HomeProductBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.onboard,
      page: () => const OnboardView(),
      binding: OnboardBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.editProfile,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<void>(
      name: Routes.viewProfile,
      page: () => const ViewProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.resetPassword,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.selfAssessmentQuestion,
      page: () => const QuestionView(),
      binding: QuestionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.manageBusiness,
      page: () => const ManageBusinessView(),
      binding: ManageBusinessBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.addPartner,
      page: () => const AddPartnerView(),
      binding: AddPartnerBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.registerOarId,
      page: () => RegisterOarIdView(tagId: Get.parameters['tagId']),
      binding: RegisterOarIdBinding(),
      transition: Transition.leftToRight,
    ),
    GetPage<dynamic>(
      name: Routes.purchase,
      page: () => const PurchaseView(),
      binding: PurchaseBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.sell,
      page: () => const SellView(),
      binding: SellBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.scanner,
      page: () => const ScannerView(),
      binding: ScannerBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: Routes.transport,
      page: () => const TransportView(),
      binding: TransportBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.addChildPartner,
      page: () => const AddChildPartnerView(),
      binding: AddChildPartnerBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.editPassword,
      page: () => const EditPasswordView(),
      binding: EditPasswordBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.communityRiskScan,
      page: () => const RiskScanView(),
      binding: RiskScanBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.requestsInfo,
      page: () => const RequestsInfoView(),
      binding: RequestsInfoBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.detailsRequestsInfo,
      page: () => const DetailsRequestsView(),
      binding: DetailRequestBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.respondToRequest,
      page: () => const RespondToRequestView(),
      binding: RespondToRequestBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.addIndicator,
      page: () => const AddIndicatorsView(),
      binding: AddIndicatorsBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.addProductManually,
      page: () => const AddProductManuallyView(),
      binding: AddProductManuallyBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.purchaseProductList,
      page: () => const ProductListView<PurchaseProductListController>(),
      binding: PurchaseProductListBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.sellProductList,
      page: () => const ProductListView<SellProductListController>(),
      binding: SellProductListBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.transportProductList,
      page: () => const ProductListView<TransportProductListController>(),
      binding: TransportProductListBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.inputProductList,
      page: () => const ProductListView<InputProductListController>(),
      binding: InputProductListBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.outputProductList,
      page: () => const ProductListView<OutputProductListController>(),
      binding: OutputProductListBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.recordByProduct,
      page: () => const RecordProductView(),
      binding: RecordProductBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.transformation,
      page: () => const TransformView(),
      binding: TransformBinding(),
    ),
    GetPage<dynamic>(
      name: Routes.overview,
      page: () => const OverviewView(),
      binding: OverviewBinding(),
    ),
  ];
}
