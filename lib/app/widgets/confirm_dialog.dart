import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String denyText;
  final String approveText;
  final Function? onApproval;
  final Function? onDenial;

  const ConfirmDialog({
    Key? key,
    this.title = "",
    this.message = "",
    this.denyText = "Cancel",
    this.approveText = "Yes",
    this.onApproval,
    this.onDenial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> actionWidgets = <Widget>[];
    actionWidgets.add(TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        onDenial?.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Text(denyText),
      ),
    ));
    actionWidgets.add(ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
        onApproval?.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Text(approveText),
      ),
    ));

    return BasePopup(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700),
        textAlign: TextAlign.start,
      ),
      body: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      actions: actionWidgets,
    );
  }
}
