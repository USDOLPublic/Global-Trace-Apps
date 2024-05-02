import 'package:usdol/app/core.dart';

class LocationInputController extends GetxController {
  final Rxn<InputItem> _countrySelected = Rxn<InputItem>();
  InputItem? get countrySelected => _countrySelected.value;
  set countrySelected(InputItem? value) {
    _countrySelected.value = value;
    if (countrySelected?.value == otherCountry.id) {
      provinceSelected = InputItem(
        value: otherProvince.id ?? '',
        displayLabel: otherProvince.province ?? '',
      );
      _getProvinces();
      districtSelected = InputItem(
        value: otherDistricts.id ?? '',
        displayLabel: otherDistricts.district ?? '',
      );
    } else {
      _getProvinces();
      provinceSelected = null;
      districtSelected = null;
    }
    _onChanged();
  }

  final Rxn<InputItem> _provinceSelected = Rxn<InputItem>();
  InputItem? get provinceSelected => _provinceSelected.value;
  set provinceSelected(InputItem? value) {
    _provinceSelected.value = value;
    _getDistricts();
    districtSelected = null;
    _onChanged();
  }

  final Rxn<InputItem> _districtSelected = Rxn<InputItem>();
  InputItem? get districtSelected => _districtSelected.value;
  set districtSelected(InputItem? value) {
    _districtSelected.value = value;
    _onChanged();
  }

  final RxList<InputItem> _countries = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get countries => _countries.value;
  set countries(List<InputItem> value) => _countries.value = value;

  final RxList<InputItem> _providerState = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get providerState => _providerState.value;
  set providerState(List<InputItem> value) => _providerState.value = value;

  final RxList<InputItem> _districts = <InputItem>[].obs;
  // ignore: invalid_use_of_protected_member
  List<InputItem> get districts => _districts.value;
  set districts(List<InputItem> value) => _districts.value = value;

  String _languageCode = '';
  bool _isHasInit = false;
  bool _isSkipValidate = false;

  @override
  void onInit() {
    if (!_isHasInit) {
      _languageCode = Prefs.getString(
        Defines.languageKey,
        defaultValue: 'en',
      );
      _getCountries();
      super.onInit();
      _isHasInit = true;
    }
  }

  void _getCountries() async {
    countries = LocationImportHelper().getCountries(
      language: _languageCode,
    );
    _countries.refresh();
  }

  void _getProvinces() {
    if (countrySelected?.value == null) {
      return;
    }

    List<ProvinceModel> provinces =
        LocationImportHelper().getProvinces(countrySelected?.value);
    providerState.clear();
    for (var e in provinces) {
      providerState.add(
        InputItem(
          displayLabel: e.getDisplayName(language: _languageCode),
          value: e.id ?? '',
        ),
      );
    }
    _providerState.refresh();
  }

  void _getDistricts() {
    if (provinceSelected?.value == null) {
      return;
    }

    List<DistrictModel> districtData = LocationImportHelper().getDistricts(
      provinceSelected?.value,
    );
    districts.clear();
    for (var e in districtData) {
      districts.add(
        InputItem(
          displayLabel: e.getDisplayName(language: _languageCode),
          value: e.id ?? '',
        ),
      );
    }
    _districts.refresh();
  }

  void setSelect({
    String? countryId,
    String? provinceId,
    String? districtId,
    bool? isSkipValidate,
  }) {
    if (countryId != null) {
      countrySelected = _countries.firstWhereOrNull(
        (element) => element.value == countryId,
      );
    }
    if (provinceId != null && countrySelected != null) {
      provinceSelected = providerState.firstWhereOrNull(
        (element) => element.value == provinceId,
      );
    }
    if (districtId != null && provinceSelected != null) {
      districtSelected = districts.firstWhereOrNull(
        (element) => element.value == districtId,
      );
    }
    if (isSkipValidate != null) {
      _isSkipValidate = isSkipValidate;
    }
  }

  void reset() {
    countrySelected = null;
    provinceSelected = null;
    districtSelected = null;
  }

  void _onChanged() {}

  bool isValid() {
    if (_isSkipValidate) return true;
    return countrySelected?.value == otherCountry.id ||
        (countrySelected?.value != otherCountry.id &&
            provinceSelected != null &&
            districtSelected != null);
  }
}
