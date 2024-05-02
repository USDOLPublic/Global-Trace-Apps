import 'package:flutter/material.dart';

class PopupAction {
  final Widget child;
  final void Function() onTab;

  PopupAction({required this.child, required this.onTab});
}

class BasePopup extends StatelessWidget {
  final Widget? title;
  final Widget body;
  final List<Widget>? actions;
  final Axis axis;
  final double radius;
  final bool isSmallAlert;

  const BasePopup({
    Key? key,
    this.title,
    required this.body,
    this.actions,
    this.radius = 8,
    this.axis = Axis.horizontal,
    this.isSmallAlert = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding:
          const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null) ...[
            title!,
            const SizedBox(height: 18),
          ],
          isSmallAlert
              ? body
              : SizedBox(
                  width: double.maxFinite,
                  child: body,
                ),
          if (actions != null) ...[
            const SizedBox(height: 24),
            // buttons
            axis == Axis.vertical
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions!,
                  )
                : Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: actions!,
                  ),
          ],
        ],
      ),
    );
  }
}
