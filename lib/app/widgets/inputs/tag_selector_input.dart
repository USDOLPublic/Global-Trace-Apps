import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class TagSelectorInput extends StatelessWidget {
  final List<InputItem> itemList;
  final InputItem? seleted;
  final bool isDisabled;
  final void Function(InputItem?) onChanged;

  const TagSelectorInput({
    Key? key,
    required this.itemList,
    required this.seleted,
    this.isDisabled = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildOptionGroup(context);
  }

  Widget _buildOptionGroup(BuildContext context) {
    if (itemList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      children: itemList.map((item) {
        bool isSelected = item.value == (seleted?.value ?? "");
        return _buildOptionItem(
          context,
          isSelected: isSelected,
          title: item.displayLabel,
          onTap: () {
            //Hide keyboard
            final FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
            if (isDisabled) return;
            onChanged(item);
          },
        );
      }).toList(),
    );
  }

  Widget _buildOptionItem(BuildContext context, {required bool isSelected, required String title, required void Function() onTap}) {
    TextStyle? textNormalStyle = const TextStyle(fontWeight: FontWeight.w600);
    TextStyle? textSelectedStyle = textNormalStyle.apply(color: Theme.of(context).primaryColor);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : AppColors.grey200,
          ),
        ),
        child: Text(
          title,
          style: isSelected ? textSelectedStyle : textNormalStyle,
        ),
      ),
    );
  }
}
