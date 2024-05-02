import 'package:usdol/app/core.dart';

class TransformHttpService extends BaseApiClient {
  Future<BaseResp<ProductModel>> getAssignProduct(String productId) async {
    return request<ProductModel>(
      Method.get,
      AppApi.getAssignProduct(productId),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return ProductModel.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> addTransform(TransformRequest req) async {
    return request<dynamic>(
      Method.post,
      AppApi.assignProduct,
      data: req.toRequest(),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<ProductDefinitionModel>> getSoldProductDefinition() async {
    return request<ProductDefinitionModel>(
      Method.get,
      AppApi.soldProductDefinition,
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
}
