abstract class PartnerRoleList {
  static const PartnerRole farm =
      PartnerRole(PartnerRoleID.farm, PartnerRoleName.farm);
  static const PartnerRole farmGroup =
      PartnerRole(PartnerRoleID.farmGroup, PartnerRoleName.farmGroup);
  static const PartnerRole spinner =
      PartnerRole(PartnerRoleID.spinner, PartnerRoleName.spinner);
  static const PartnerRole broker =
      PartnerRole(PartnerRoleID.broker, PartnerRoleName.broker);
  static const PartnerRole transporter =
      PartnerRole(PartnerRoleID.transporter, PartnerRoleName.transporter);
  static const PartnerRole ginner =
      PartnerRole(PartnerRoleID.ginner, PartnerRoleName.ginner);
  static const PartnerRole mill =
      PartnerRole(PartnerRoleID.mill, PartnerRoleName.mill);
  static const PartnerRole unknown = PartnerRole(-1, "UNKNOWN");

  static PartnerRole getRoleById(int id) {
    switch (id) {
      case PartnerRoleID.farmGroup:
        return farmGroup;
      case PartnerRoleID.farm:
        return farm;
      case PartnerRoleID.spinner:
        return spinner;
      case PartnerRoleID.broker:
        return broker;
      case PartnerRoleID.transporter:
        return transporter;
      case PartnerRoleID.mill:
        return mill;
      case PartnerRoleID.ginner:
        return ginner;
    }
    return unknown;
  }

  static PartnerRole getRoleByName(String name) {
    switch (name) {
      case PartnerRoleName.farm:
        return farm;
      case PartnerRoleName.farmGroup:
        return farmGroup;
      case PartnerRoleName.spinner:
        return spinner;
      case PartnerRoleName.broker:
        return broker;
      case PartnerRoleName.transporter:
        return transporter;
      case PartnerRoleName.mill:
        return mill;
      case PartnerRoleName.ginner:
        return ginner;
    }
    return unknown;
  }
}

class PartnerRole {
  final String name;
  final int id;
  const PartnerRole(this.id, this.name);
}

abstract class PartnerRoleID {
  static const int farmGroup = 1;
  static const int ginner = 2;
  static const int spinner = 3;
  static const int broker = 4;
  static const int transporter = 5;
  static const int mill = 6;
  static const int brand = 7;
  static const int auditor = 8;
  static const int farmmonitor = 9;
  static const int finalProduct = 10;
  static const int farm = 11;
  static const int nonFarm = 12;
}

abstract class PartnerRoleName {
  static const String farmGroup = "FARM_GROUP";
  static const String ginner = "GINNER";
  static const String spinner = "SPINNER";
  static const String broker = "BROKER";
  static const String transporter = "TRANSPORTER";
  static const String mill = "MILL";
  static const String brand = "BRAND";
  static const String auditor = "AUDITOR";
  static const String farmmonitor = "FARM_MONITOR";
  static const String finalProduct = "FINAL_PRODUCT_ASSEMBLY";
  static const String farm = "FARM";
  static const String nonFarm = "NON_FARM";
}
