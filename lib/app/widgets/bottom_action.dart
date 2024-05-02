import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class BottomAction extends StatelessWidget {
  const BottomAction({
    Key? key,
    this.titleBtn = '',
    this.isEnableBtn = true,
    this.onPress,
    this.childContent,
  }) : super(key: key);

  final bool isEnableBtn;
  final String titleBtn;
  final void Function()? onPress;
  final Widget? childContent;

  @override
  Widget build(BuildContext context) {
    ButtonStyle btnStyle = ElevatedBtnStyle.disable();
    if (isEnableBtn) {
      btnStyle = ElevatedBtnStyle.enable();
    }
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.k4B4B45.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, -3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 6, 24, 0),
      child: SafeArea(
        minimum: const EdgeInsets.only(bottom: 6),
        child: childContent ??
            ElevatedButton(
              key: const ValueKey("bottomAction"),
              style: btnStyle,
              onPressed: onPress == null
                  ? null
                  : () {
                      if (isEnableBtn) {
                        onPress?.call();
                      }
                    },
              child: Text(titleBtn),
            ),
      ),
    );
  }
}
