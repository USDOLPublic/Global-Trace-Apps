import 'package:usdol/app/core.dart';

class PurchaseHttpService extends BaseApiClient {
  Future<BaseResp<List<PurchasePartner>>> getPurchasePartners() async {
    return request<List<PurchasePartner>>(
      Method.get,
      AppApi.purchasePartners,
      onDeserialize: (dynamic jsonValue) {
        //Parse json (List Type)
        if (jsonValue is List) {
          return jsonValue
              .map((dynamic e) =>
                  PurchasePartner.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> addPurchase(PurchaseRequest req) async {
    return request<dynamic>(
      Method.post,
      AppApi.purchase,
      data: req.toRequest(),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<ProductDefinitionModel>>
      getPurchaseProductDefinition() async {
    return request<ProductDefinitionModel>(
      Method.get,
      AppApi.purchaseProductDefinition,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return ProductDefinitionModel.fromJson(
              jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<PurchaseSellerConfig>> getSellerConfig() async {
    return request<PurchaseSellerConfig>(
      Method.get,
      AppApi.sellerConfig,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return PurchaseSellerConfig.fromJson(
              jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<ProductModel>> getPurchaseProduct(
      String productId) async {
    return request<ProductModel>(
      Method.get,
      AppApi.getPurchaseProduct(productId),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return ProductModel.fromJson(
              jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }
}
