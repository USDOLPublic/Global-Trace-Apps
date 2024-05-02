import 'package:usdol/app/core.dart';

class SellHttpService extends BaseApiClient {
  Future<BaseResp<List<SellPartner>>> getSellPartners() async {
    return request<List<SellPartner>>(
      Method.get,
      AppApi.sellPartners,
      onDeserialize: (dynamic jsonValue) {
        //Parse json (List Type)
        if (jsonValue is List) {
          return jsonValue
              .map((dynamic e) =>
                  SellPartner.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> addSell(SellRequest payload) async {
    return request<dynamic>(
      Method.post,
      AppApi.sell,
      data: payload.toRequest(),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<ProductModel>> getSellProduct(String productId) async {
    return request<ProductModel>(
      Method.get,
      AppApi.getSellProduct(productId),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return ProductModel.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }
}
