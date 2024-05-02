import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';

class MenuEndDrawerIcon extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const MenuEndDrawerIcon({Key? key, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const ValueKey('menuButton'),
      onPressed: () {
        if (scaffoldKey != null) {
          scaffoldKey!.currentState?.openEndDrawer();
        } else {
          Scaffold.of(context).openEndDrawer();
        }
      },
      icon: SvgPicture.asset(AssetsConst.svgMenu),
    );
  }
}
