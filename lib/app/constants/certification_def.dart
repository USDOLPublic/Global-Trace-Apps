import 'dart:io';
import 'package:usdol/app/core.dart';
import 'package:intl/intl.dart';

late List<InputItem> cottonsCertification;
late List<InputItem> gradeGinnerForPurchaseOfCotton;
late List<InputItem> gradeOtherForPurchase;
late List<InputItem> weightUnits;
late List<InputItem> ginnerPurchaseWeightUnits;
late List<InputItem> ginnerTransportWeightUnits;
late List<InputItem> ginnerAssignLotWeightUnits;
late List<InputItem> currencyUnits;
late List<InputItem> profileCertificationsDef;
late InputItem massBalanceDef;
late InputItem productSegregationDef;
late InputItem defaultWeightUnit;
late InputItem defaultCurrency;
late List<InputItem> reconciliationDurationsDef;
late List<InputItem> chainOfCustodyDef;
late List<SeverityModel> listSeverityDef;
late List<PriorityModel> listPriorityDef;

class Certification {
  static void definition() {
    cottonsCertification = <InputItem>[
      InputItem(value: "ABRAPA", displayLabel: S.current.abrapa),
      InputItem(value: "BASF e3", displayLabel: S.current.basfE3),
      InputItem(
          value: "Better Cotton Initiative (BCI)",
          displayLabel: S.current.betterCotton),
      InputItem(value: "Cleaner Cotton", displayLabel: S.current.cleanerCotton),
      InputItem(
          value: "Cotton made in Africa (CmiA)",
          displayLabel: S.current.cottonMadeInAfrica),
      InputItem(value: "Fairtrade", displayLabel: S.current.fairtrade),
      InputItem(
          value: "Fairtrade Organic", displayLabel: S.current.fairtradeOrganic),
      InputItem(
          value: "Field to Market", displayLabel: S.current.fieldToMarket),
      InputItem(value: "ISCC", displayLabel: S.current.iscc),
      InputItem(value: "myBMP", displayLabel: S.current.myBMP),
      InputItem(value: "Organic Cotton", displayLabel: S.current.organicCotton),
      InputItem(
          value: "Recycled Cotton", displayLabel: S.current.recycledCotton),
      InputItem(value: "REEL Cotton", displayLabel: S.current.reelCotton),
      InputItem(
          value: "Regenerative Cotton",
          displayLabel: S.current.regenerativeCotton),
      InputItem(
          value: "Transitional Cotton",
          displayLabel: S.current.transitionalCotton),
      InputItem(
          value: "United States Cotton Trust Protocol",
          displayLabel: S.current.usCotton),
      InputItem(
          value: "Conventional Cotton",
          displayLabel: S.current.conventionalCotton),
    ];
    gradeGinnerForPurchaseOfCotton = <InputItem>[
      InputItem(
          value: "Seed Cotton Super", displayLabel: S.current.seedCottonSuper),
      InputItem(
          value: "Seed Cotton Grade 1",
          displayLabel: S.current.seedCottonGrade1),
      InputItem(
          value: "Seed Cotton Grade 2",
          displayLabel: S.current.seedCottonGrade2),
      InputItem(
          value: "Seed Cotton Grade 3",
          displayLabel: S.current.seedCottonGrade3),
      InputItem(
          value: "Seed Cotton Grade 4",
          displayLabel: S.current.seedCottonGrade4),
      InputItem(
          value: "Seed Cotton Grade 5",
          displayLabel: S.current.seedCottonGrade5),
    ];

    gradeOtherForPurchase = <InputItem>[
      InputItem(
          value: "Lint Cotton Super", displayLabel: S.current.lintCottonSuper),
      InputItem(
          value: "Lint Cotton Grade 1",
          displayLabel: S.current.lintCottonGrade1),
      InputItem(
          value: "Lint Cotton Grade 2",
          displayLabel: S.current.lintCottonGrade2),
      InputItem(
          value: "Lint Cotton Grade 3",
          displayLabel: S.current.lintCottonGrade3),
      InputItem(
          value: "Lint Cotton Grade 4",
          displayLabel: S.current.lintCottonGrade4),
      InputItem(
          value: "Lint Cotton Grade 5",
          displayLabel: S.current.lintCottonGrade5),
    ];

    weightUnits = <InputItem>[
      InputItem(value: "Kg", displayLabel: S.current.kg),
      InputItem(value: "M", displayLabel: S.current.m),
      InputItem(value: "Unit", displayLabel: S.current.unitUpcase),
      InputItem(value: "Lbs", displayLabel: S.current.lbs),
    ];

    ginnerPurchaseWeightUnits = <InputItem>[
      InputItem(value: "Kg", displayLabel: S.current.kg),
      InputItem(value: "Lbs", displayLabel: S.current.lbs),
    ];

    ginnerTransportWeightUnits = <InputItem>[
      InputItem(value: "Kg", displayLabel: S.current.kg),
      InputItem(value: "Lbs", displayLabel: S.current.lbs),
    ];

    ginnerAssignLotWeightUnits = <InputItem>[
      InputItem(value: "Kg", displayLabel: S.current.kg),
      InputItem(value: "Unit", displayLabel: S.current.unitUpcase),
      InputItem(value: "Lbs", displayLabel: S.current.lbs),
    ];

    currencyUnits = <InputItem>[
      InputItem(value: "PKR", displayLabel: S.current.pkr),
      InputItem(value: "USD", displayLabel: S.current.usd),
    ];

    massBalanceDef = InputItem(
      value: 'Mass balance',
      displayLabel: S.current.massBalance,
      code: 'MASS_BALANCE',
    );

    productSegregationDef = InputItem(
      value: 'Product Segregation',
      displayLabel: S.current.productSegregation,
      code: 'PRODUCT_SEGREGATION',
    );

    chainOfCustodyDef = [productSegregationDef, massBalanceDef];

    profileCertificationsDef = <InputItem>[
      InputItem(value: "GRS", displayLabel: S.current.cottonCertificationGRS),
      InputItem(value: "BCI", displayLabel: S.current.cottonCertificationBCI),
      InputItem(value: "GOTS", displayLabel: S.current.cottonCertificationGOTS),
      InputItem(
          value: "Organic cotton",
          displayLabel: S.current.cottonCertificationOrganic),
      InputItem(
          value: "Leather Working Group",
          displayLabel: S.current.cottonCertificationLeather),
      InputItem(
          value: "OEKO Tex", displayLabel: S.current.cottonCertificationOEKO),
      InputItem(
          value: "Other", displayLabel: S.current.cottonCertificationOther),
    ];

    defaultWeightUnit = InputItem(value: "Kg", displayLabel: S.current.kg);

    defaultCurrency = InputItem(value: "PKR", displayLabel: S.current.pkr);

    reconciliationDurationsDef = <InputItem>[
      InputItem(value: "1 Month", displayLabel: S.current.valueMonth(1)),
      InputItem(value: "2 Month", displayLabel: S.current.valueMonths(2)),
      InputItem(value: "3 Month", displayLabel: S.current.valueMonths(3)),
      InputItem(value: "4 Month", displayLabel: S.current.valueMonths(4)),
      InputItem(value: "5 Month", displayLabel: S.current.valueMonths(5)),
      InputItem(value: "6 Month", displayLabel: S.current.valueMonths(6)),
      InputItem(value: "7 Month", displayLabel: S.current.valueMonths(7)),
      InputItem(value: "8 Month", displayLabel: S.current.valueMonths(8)),
      InputItem(value: "9 Month", displayLabel: S.current.valueMonths(9)),
      InputItem(value: "10 Month", displayLabel: S.current.valueMonths(10)),
      InputItem(value: "11 Month", displayLabel: S.current.valueMonths(11)),
      InputItem(value: "12 Month", displayLabel: S.current.valueMonths(12)),
    ];

    listSeverityDef = [
      SeverityModel(
        id: const Uuid().v1(),
        name: S.current.highSevrity,
        index: 0,
        color: 0xffFF8888,
        value: 3,
      ),
      SeverityModel(
        id: const Uuid().v1(),
        name: S.current.mediumSevrity,
        index: 1,
        color: 0xffF2B062,
        value: 2,
      ),
      SeverityModel(
        id: const Uuid().v1(),
        name: S.current.lowSevrity,
        index: 2,
        color: 0xff36C67E,
        value: 1,
      ),
    ];

    listPriorityDef = [
      PriorityModel(
        id: const Uuid().v1(),
        displayName: "1",
        value: 1,
      ),
      PriorityModel(
        id: const Uuid().v1(),
        displayName: "2",
        value: 2,
      ),
      PriorityModel(
        id: const Uuid().v1(),
        displayName: "3",
        value: 3,
      ),
      PriorityModel(
        id: const Uuid().v1(),
        displayName: "4",
        value: 4,
      ),
      PriorityModel(
        id: const Uuid().v1(),
        displayName: "5",
        value: 5,
      ),
    ];
  }
}

class TransactionType {
  static const int purchase = 1;
  static const int sale = 2;
  static const int transport = 3;
  static const int transformation = 4;
  static const int recordByProduct = 5;
}

const String nonParticipating = "Non-participating";

const String pakistanCode = "PK";

const String saqKey = 'saq';

const String nonFarmTitle = 'Non-participating farm';

const int defaultRatioEstimatedLint = 35;

const List<String> unitsOfLengthDef = ['feet', 'inch', 'm'];

String percentRegPattern =
    ("[0-9${NumberFormat.decimalPattern(Platform.localeName).symbols.DECIMAL_SEP}]");
String decimalRegPattern =
    ("[0-9${NumberFormat.decimalPattern(Platform.localeName).symbols.DECIMAL_SEP}]");
String percentSymbols =
    NumberFormat.decimalPattern(Platform.localeName).symbols.PERCENT;

CountryModel otherCountry = CountryModel(
  id: '70beea98-e08c-4ba3-800c-d20bb6fa7247',
  countryCode: "OTHER",
  country: "Other",
);
ProvinceModel otherProvince = ProvinceModel(
  id: '46d0173c-c5b5-451e-8d2e-8cfc6bad3e0f',
  provinceCode: "N/A",
  province: "N/A",
);
DistrictModel otherDistricts = DistrictModel(
  id: '1bba9e49-0700-4178-bf67-17b20c0ca5db',
  districtCode: 999999999,
  district: "N/A",
);
