import 'package:flutter/material.dart';

class RowInputWidget extends StatelessWidget {
  const RowInputWidget({
    super.key,
    required this.firstInput,
    required this.secondInput,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
  });
  final Widget firstInput;
  final Widget secondInput;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 5, child: firstInput),
          const SizedBox(width: 8),
          Expanded(flex: 3, child: secondInput),
        ],
      ),
    );
  }
}
