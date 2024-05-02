import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class ThreeBounceLoading extends StatelessWidget {
  Color? color;
  ThreeBounceLoading({Key? key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    color ??= Theme.of(context).primaryColor;
    return SpinKitThreeBounce(color: color, size: 26);
  }
}
