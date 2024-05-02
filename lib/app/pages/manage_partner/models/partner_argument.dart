enum InvitePartnerType {
  broker,
  processing,
  transporter,
  childBroker,
}

class PartnerArgument {
  InvitePartnerType type;
  String name;
  String? suggestHint;
  bool hasChildPartner;
  String? country;
  String? province;
  String? district;
  String? address;
  String? registerTitle;

  PartnerArgument({
    required this.type,
    required this.name,
    this.suggestHint,
    this.hasChildPartner = false,
    this.country,
    this.province,
    this.district,
    this.address,
    this.registerTitle,
  });
}
