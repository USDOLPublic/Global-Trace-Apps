import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class LocationImportHelper {
  static final LocationImportHelper _instance =
      LocationImportHelper._internal();
  factory LocationImportHelper() {
    return _instance;
  }
  LocationImportHelper._internal();
  final CountryCacheService _countryCacheService = CountryCacheService();
  final ProvinceCacheService _provinceCacheService = ProvinceCacheService();
  final DistrictCacheService _districtCacheService = DistrictCacheService();

  Future<void> init() async {
    await Future.wait([
      _countryCacheService.init(),
      _provinceCacheService.init(),
      _districtCacheService.init(),
    ]);
  }

  Future<void> importData() async {
    bool isImported = Prefs.getBool(Defines.importLocationDataKey);
    if (isImported) return;
    DateTime startImport = DateTime.now();
    List<bool> results = await Future.wait([
      _importCountryData(),
      _importProvinceData(),
      _importDistrictData(),
    ]);
    if (!results.contains(false)) {
      await Prefs.saveBool(Defines.importLocationDataKey, true);
      LogUtil.d(
          "_ Import Data Done: ${DateTime.now().millisecond - startImport.millisecond}");
    }
  }

  Future<bool> _importCountryData() async {
    try {
      String data = await rootBundle.loadString(AssetsConst.countries);
      List<dynamic> listData = jsonDecode(data) as List<dynamic>;
      Map<String, CountryModel> dataImport = <String, CountryModel>{};
      for (var element in listData) {
        CountryModel country =
            CountryModel.fromJson(element as Map<String, dynamic>);
        dataImport[country.id ?? ''] = country;
      }
      await _countryCacheService.repo.assignAll(dataImport);
      return true;
    } catch (e) {
      LogUtil.e("_ Import Country Data Error: $e");
      return false;
    }
  }

  Future<bool> _importProvinceData() async {
    try {
      String data = await rootBundle.loadString(AssetsConst.provinces);
      List<dynamic> listData = jsonDecode(data) as List<dynamic>;
      Map<String, ProvinceModel> dataImport = <String, ProvinceModel>{};
      for (var element in listData) {
        ProvinceModel province =
            ProvinceModel.fromJson(element as Map<String, dynamic>);
        dataImport[province.id ?? ''] = province;
      }
      await _provinceCacheService.repo.assignAll(dataImport);
      return true;
    } catch (e) {
      LogUtil.e("_ Import Province Data Error: $e");
      return false;
    }
  }

  Future<bool> _importDistrictData() async {
    try {
      String data = await rootBundle.loadString(AssetsConst.districts);
      List<dynamic> listData = jsonDecode(data) as List<dynamic>;
      Map<String, DistrictModel> dataImport = <String, DistrictModel>{};
      for (var element in listData) {
        DistrictModel district =
            DistrictModel.fromJson(element as Map<String, dynamic>);
        dataImport[district.id ?? ''] = district;
      }
      await _districtCacheService.repo.assignAll(dataImport);
      return true;
    } catch (e) {
      LogUtil.e("_ Import District Data Error: $e");
      return false;
    }
  }

  ///
  /// Search data
  ///

  List<InputItem> getCountries({String language = ''}) {
    var countries = _countryCacheService.repo.getAllValues();
    if (countries.isEmpty) {
      importData();
      countries = _countryCacheService.repo.getAllValues();
    }
    return _sortCountries(countries.values.toList(), language: language);
  }

  List<InputItem> _sortCountries(
    List<CountryModel> countries, {
    String language = '',
  }) {
    if (countries.isNotEmpty) {
      countries.sort((a, b) => (a.country ?? '').compareTo((b.country ?? '')));

      var pakistan = countries
          .firstWhereOrNull((i) => (i.countryCode ?? '') == pakistanCode);
      var other =
          countries.firstWhereOrNull((i) => (i.id ?? '') == otherCountry.id);
      // Sort country Pakistan to top and other country to bottom
      countries.removeWhere(
          (i) => i.countryCode == pakistanCode || i.id == otherCountry.id);
      if (pakistan != null) {
        countries.insert(0, pakistan);
      }
      if (other != null) {
        countries.add(other);
      }
      List<InputItem> resultCountry = [];
      for (CountryModel country in countries) {
        resultCountry.add(InputItem(
            displayLabel: country.getDisplayName(language: language),
            value: country.id ?? '',
            code: country.countryCode));
      }
      return resultCountry;
    }
    return [];
  }

  List<ProvinceModel> getProvinces(String? countryId) {
    final provinces = _provinceCacheService.repo.getAllValues();
    return provinces.values
        .where((element) => element.countryId == countryId)
        .toList();
  }

  List<DistrictModel> getDistricts(String? provinceId) {
    final districts = _districtCacheService.repo.getAllValues();
    return districts.values
        .where((element) => element.provinceId == provinceId)
        .toList();
  }
}
