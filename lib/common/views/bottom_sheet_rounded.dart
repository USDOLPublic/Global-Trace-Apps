import 'package:flutter/material.dart';

class BottomSheetRounded extends StatelessWidget {
  final Widget title;
  final Icon? leadingIcon;
  final Icon? rightActionIcon;
  final Widget? leadingWidget;
  final Widget? rightActionWidget;
  final Widget body;
  final double? heightContent;
  final Function? onLeadingClicked;
  final Function? onRightActionClicked;
  final bool isWrapContent;

  const BottomSheetRounded({
    Key? key,
    required this.title,
    required this.body,
    this.heightContent = 0,
    this.leadingIcon,
    this.rightActionIcon,
    this.onLeadingClicked,
    this.onRightActionClicked,
    this.leadingWidget,
    this.rightActionWidget,
    this.isWrapContent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: isWrapContent ? MainAxisSize.min : MainAxisSize.max,
      children: <Widget>[
        Row(
          children: <Widget>[
            leadingWidget != null
                ? TextButton(
                    onPressed: () {
                      if (onLeadingClicked != null) {
                        onLeadingClicked?.call();
                      }
                      Navigator.of(context).pop();
                    },
                    child: leadingWidget!)
                : IconButton(
                    icon: leadingIcon == null
                        ? Icon(
                            Icons.close,
                            color: Theme.of(context).primaryColor,
                          )
                        : leadingIcon!,
                    onPressed: () {
                      if (onLeadingClicked != null) {
                        onLeadingClicked?.call();
                      }
                      Navigator.of(context).pop();
                    },
                  ),
            Expanded(child: title),
            rightActionWidget != null
                ? TextButton(
                    onPressed: () {
                      if (onRightActionClicked != null) {
                        onRightActionClicked?.call();
                      }
                      Navigator.of(context).pop();
                    },
                    child: rightActionWidget!)
                : rightActionIcon != null
                    ? IconButton(
                        icon: rightActionIcon!,
                        onPressed: () {
                          if (onRightActionClicked != null) {
                            onRightActionClicked?.call();
                          }
                          Navigator.of(context).pop();
                        },
                      )
                    : const SizedBox(width: 42),
          ],
        ),
        isWrapContent
            ? body
            : Expanded(
                child: body,
              ),
      ],
    );
  }
}
