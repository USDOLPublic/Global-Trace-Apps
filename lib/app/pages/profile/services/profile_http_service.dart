import 'package:dio/dio.dart' as dio;
import 'package:usdol/app/core.dart';

class ProfileHttpService extends BaseApiClient {
  Future<BaseResp<List<CountryModel>>> getListCountry() {
    return request<List<CountryModel>>(
      Method.get,
      AppApi.countries + "&perPage=1000",
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue
              .map((dynamic e) =>
                  CountryModel.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<ProvinceModel>>> getProvinces(
      {required String countryId}) {
    return request<List<ProvinceModel>>(
      Method.get,
      AppApi.provinces + "countryId=" + countryId,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          List<ProvinceModel> countries = [];
          jsonValue
              .map((dynamic e) => countries
                  .add(ProvinceModel.fromJson(e as Map<String, dynamic>)))
              .toList();
          return countries;
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<DistrictModel>>> getDistricts(
      {required String provinceId}) {
    return request<List<DistrictModel>>(
      Method.get,
      AppApi.districts + "provinceId=" + provinceId,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          List<DistrictModel> countries = [];
          jsonValue
              .map((dynamic e) => countries
                  .add(DistrictModel.fromJson(e as Map<String, dynamic>)))
              .toList();
          return countries;
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> updateProfile({required ProfileRequestModel req}) {
    Map<String, dynamic> data = req.toJson();
    dio.Options optCustom = dio.Options();
    optCustom.contentType = ("application/json");
    return request<dynamic>(
      Method.put,
      AppApi.user,
      options: optCustom,
      data: data,
      onDeserialize: (dynamic jsonValue) {},
    );
  }

  Future<BaseResp<UserModel>> loadProfile() {
    return request<UserModel>(
      Method.get,
      AppApi.userMe,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return UserModel.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<List<String>>> getCommodities() {
    return request<List<String>>(
      Method.get,
      AppApi.commodities,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is List) {
          return jsonValue.map((dynamic e) => e.toString()).toList();
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> updatePassword(
      String oldPassword, String newPassword) {
    return request<dynamic>(
      Method.put,
      AppApi.changePassword,
      data: {"oldPassword": oldPassword, "newPassword": newPassword},
      onDeserialize: (dynamic jsonValue) {},
    );
  }

  Future<BaseResp<SearchOarIdRespModel>> searchOarId(OarIdReqModel reqModel) {
    Map<String, dynamic> data = reqModel.toJson();
    dio.Options optCustom = dio.Options();
    optCustom.contentType = ("application/json");
    return request<SearchOarIdRespModel>(
      Method.post,
      AppApi.facilitiesRegisterOarId,
      options: optCustom,
      data: data,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return SearchOarIdRespModel.fromJson(
              jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<OarIdResult>> rejectOarId(List<String> facilityIds) {
    String oarIdsStr = "";
    if (facilityIds.isNotEmpty) {
      oarIdsStr = facilityIds.join(",");
    }
    Map<String, dynamic> ids = <String, dynamic>{
      "ids": oarIdsStr,
    };
    return request<OarIdResult>(
      Method.get,
      AppApi.facilitiesRejectOarId,
      queryParameters: ids,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return OarIdResult.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<OarIdResult>> confirmOarId(String facilityId) {
    return request<OarIdResult>(
      Method.get,
      AppApi.facilitiesConfirmOarId,
      queryParameters: <String, dynamic>{"id": facilityId},
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return OarIdResult.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<OarIDRespModel>> facilitiesCheckOarID(
      CheckOarIdRequestModel oarId) {
    Map<String, dynamic>? data = oarId.toJson();
    dio.Options optCustom = dio.Options();
    optCustom.contentType = ("application/json");
    return request<OarIDRespModel>(
      Method.post,
      AppApi.facilitiesCheckOarId,
      options: optCustom,
      data: data,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map) {
          return OarIDRespModel.fromJson(jsonValue as Map<String, dynamic>);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> setFinishGuidance() {
    return request<dynamic>(
      Method.put,
      AppApi.finishGuidance,
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }

  Future<BaseResp<SeasonTimeModel>> getSessionTime() {
    return request<SeasonTimeModel>(
      Method.get,
      AppApi.seasonStartTime,
      onDeserialize: (dynamic jsonValue) {
        if (jsonValue is Map<String, dynamic>) {
          return SeasonTimeModel.fromJson(jsonValue);
        } else {
          return null;
        }
      },
    );
  }

  Future<BaseResp<dynamic>> deleteMyAccount() {
    return request<dynamic>(
      Method.delete,
      AppApi.deleteAccount,
      onDeserialize: (dynamic jsonValue) {
        return jsonValue;
      },
    );
  }
}
