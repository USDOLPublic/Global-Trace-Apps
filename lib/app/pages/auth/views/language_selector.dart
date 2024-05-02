import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usdol/app/core.dart';

class LanguageSelector extends StatefulWidget {
  final List<InputItem> itemList;
  final InputItem seleted;
  final bool isDisabled;
  final String label;
  final String hint;
  final double verticalMargin;
  final void Function(InputItem?) onChanged;

  const LanguageSelector({
    Key? key,
    required this.itemList,
    required this.seleted,
    this.isDisabled = false,
    this.label = "",
    this.hint = "",
    this.verticalMargin = 0,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<InputItem>> menuItems = <PopupMenuItem<InputItem>>[];
    for (var item in widget.itemList) {
      bool isSelected = (item.value == (widget.seleted.value));
      TextStyle? textNormalStyle = const TextStyle(
        color: AppColors.grey600,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
      TextStyle? textDisable = const TextStyle(
        color: AppColors.grey200,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
      TextStyle? textSelectedStyle = textNormalStyle;
      menuItems.add(
        PopupMenuItem<InputItem>(
          key: ValueKey(item.value),
          value: item,
          padding: const EdgeInsets.only(left: 14),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppProperties.circleRadius),
              color: isSelected ? AppColors.green600 : AppColors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.icon != null)
                  SvgPicture.asset(
                    item.icon!,
                    height: 24,
                  ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    item.displayLabel,
                    style: (item.isDisable ?? false)
                        ? textDisable
                        : isSelected
                            ? textSelectedStyle
                            : textNormalStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return PopupMenuButton<InputItem>(
      child: _buildMenu(context, widget.seleted),
      itemBuilder: (BuildContext context) => menuItems,
      padding: const EdgeInsets.all(4.0),
      constraints: const BoxConstraints(minWidth: 10),
      onSelected: widget.onChanged,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppProperties.circleRadius),
        ),
      ),
      elevation: AppElevation.card,
    );
  }

  Widget _buildMenu(BuildContext context, InputItem? selected) {
    if (selected == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(AppProperties.circleRadius),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            widget.seleted.icon!,
            height: 24,
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.arrow_drop_down,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
