import 'package:usdol/app/core.dart';

enum EditProfileType {
  fromOnboard,
  fromProfile,
}

class EditProfileArguments {
  EditProfileType type;
  UserModel? profile;
  String pageTitle;
  EditProfileArguments({required this.type, this.profile, required this.pageTitle});
}
