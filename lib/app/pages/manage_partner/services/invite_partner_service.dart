import 'package:usdol/app/core.dart';
import 'package:dio/dio.dart' as dio;

class InvitePartnerService extends BaseApiClient {
  Future<BaseResp<dynamic>> addPartner(
    InvitePartnerReq req,
    InvitePartnerType type,
  ) {
    String addPartnerEndpoint = '';
    switch (type) {
      case InvitePartnerType.broker:
        addPartnerEndpoint = AppApi.inviteBrokerPartner;
        break;
      case InvitePartnerType.transporter:
        addPartnerEndpoint = AppApi.inviteTransporterPartner;
        break;
      case InvitePartnerType.processing:
      case InvitePartnerType.childBroker:
        addPartnerEndpoint = AppApi.inviteFacilityPartner;
        break;
    }
    Map<String, dynamic> data = req.toJson();
    dio.Options optCustom = dio.Options();
    optCustom.contentType = ("application/json");
    return request<dynamic>(
      Method.post,
      addPartnerEndpoint,
      data: data,
      options: optCustom,
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<List<FacilityRespModel>>> searchFacilities(
    String key,
    InvitePartnerType type,
  ) {
    String searchPartnerEndpoint = '';
    switch (type) {
      case InvitePartnerType.broker:
        searchPartnerEndpoint = AppApi.searchBrokerPartner;
        break;
      case InvitePartnerType.processing:
        searchPartnerEndpoint = AppApi.searchFacilityPartner;
        break;
      case InvitePartnerType.transporter:
        searchPartnerEndpoint = AppApi.searchTransporterPartner;
        break;
      case InvitePartnerType.childBroker:
        searchPartnerEndpoint = AppApi.searchChildBrokerPartner;
        break;
    }

    return request<List<FacilityRespModel>>(
      Method.get,
      searchPartnerEndpoint,
      queryParameters: <String, dynamic>{
        "key": key,
      },
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue != null && jsonValue is List) {
          return jsonValue
              .map((dynamic e) =>
                  FacilityRespModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<FacilityRespModel>>> getBusinessPartners() {
    return request<List<FacilityRespModel>>(
      Method.get,
      AppApi.businessPartner,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((dynamic e) =>
                  FacilityRespModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> deletePartner(String partnerId) {
    return request<dynamic>(
      Method.delete,
      AppApi.deletePartner + partnerId,
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<List<FacilityRespModel>>> getChildReferFacilities(
      String falicityId) {
    return request<List<FacilityRespModel>>(
      Method.get,
      AppApi.businessPartnerRefer(falicityId),
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue != null && jsonValue is List) {
          return jsonValue
              .map((dynamic e) =>
                  FacilityRespModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<InvitePartnerPermission>>> getInvitePermission() {
    return request<List<InvitePartnerPermission>>(
      Method.get,
      AppApi.invitePermission,
      queryParameters: <String, dynamic>{
        'canInvite': true,
      },
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue != null && jsonValue is List) {
          return jsonValue
              .map((dynamic e) =>
                  InvitePartnerPermission.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }
}
