import 'package:usdol/app/core.dart';

class TransportHttpService extends BaseApiClient {
  Future<BaseResp<List<TransportPartner>>> getTransportPartners() async {
    return request<List<TransportPartner>>(
      Method.get,
      AppApi.transportPartners,
      onDeserialize: (dynamic jsonValue) {
        //Parse json (List Type)
        if (jsonValue is List) {
          return jsonValue
              .map((dynamic e) =>
                  TransportPartner.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> addTransport(TransportRequest payload) async {
    return request<dynamic>(
      Method.post,
      AppApi.transport,
      data: payload.toRequest(),
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<ProductModel>> getTransportProduct(String productId) async {
    return request<ProductModel>(
      Method.get,
      AppApi.getTransportProduct(productId),
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
