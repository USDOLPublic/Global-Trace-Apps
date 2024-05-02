import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class MultiDropdownInput extends StatefulWidget {
  final List<InputItem> itemList;
  final List<InputItem>? selected;
  final bool isDisabled;
  final String label;
  final String hint;
  final double verticalMargin;
  final void Function(List<InputItem>?) onChanged;

  const MultiDropdownInput({
    Key? key,
    required this.itemList,
    required this.selected,
    this.isDisabled = false,
    this.label = "",
    this.hint = "",
    this.verticalMargin = 0,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<MultiDropdownInput> createState() => _MultiDropdownInputState();
}

class _MultiDropdownInputState extends State<MultiDropdownInput> {
  final List<ScrollController> _scrollControllerList = [];
  List<InputItem> _itemsSelected = [];

  @override
  void dispose() {
    if (_scrollControllerList.isNotEmpty) {
      for (var controller in _scrollControllerList) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  bool _isSelectedItem(InputItem? item) {
    return _itemsSelected.firstWhereOrNull((e) => e.value == item?.value) !=
        null;
  }

  void _onChangedItem(InputItem item) {
    if (_isSelectedItem(item)) {
      _itemsSelected.removeWhere((element) => element.value == item.value);
    } else {
      _itemsSelected.add(item);
    }
    widget.onChanged(_itemsSelected);
  }

  @override
  Widget build(BuildContext context) {
    _itemsSelected = widget.selected ?? [];
    List<DropdownMenuItem<InputItem>> dropItems =
        <DropdownMenuItem<InputItem>>[];
    for (var item in widget.itemList) {
      bool isSelected = _isSelectedItem(item);
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
      dropItems.add(
        DropdownMenuItem<InputItem>(
          key: ValueKey(item.value),
          value: item,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppProperties.circleRadius),
                  color: isSelected ? AppColors.grey100 : AppColors.white,
                ),
                child: Text(
                  item.displayLabel,
                  style: (item.isDisable ?? false)
                      ? textDisable
                      : isSelected
                          ? textSelectedStyle
                          : textNormalStyle,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return _buildDropDownFormItem(context, dropItems);
  }

  Widget _buildDropDownFormItem(
    BuildContext context,
    List<DropdownMenuItem<InputItem>> dropItems,
  ) {
    for (int i = 0; i < dropItems.length; i++) {
      _scrollControllerList.add(ScrollController());
    }
    List<DropdownMenuItem<InputItem>> valueSelected = dropItems
        .where((DropdownMenuItem<InputItem> it) => _isSelectedItem(it.value))
        .toList();
    DropdownMenuItem<InputItem>? firstValue;
    String otherCount = '';
    if (valueSelected.isNotEmpty) {
      firstValue = valueSelected.first;
      if (valueSelected.length > 1) {
        otherCount = '+${valueSelected.length - 1}';
      }
    }
    return DropdownButtonHideUnderline(
      child: IgnorePointer(
        ignoring: widget.isDisabled,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: widget.verticalMargin),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: AppProperties.inputHight,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.0,
                style: BorderStyle.solid,
                color: widget.isDisabled
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(AppProperties.circleRadius),
            ),
            color: widget.isDisabled ? AppColors.grey100 : AppColors.white,
          ),
          child: ButtonTheme(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: DropdownButton(
              borderRadius: BorderRadius.circular(AppProperties.circleRadius),
              elevation: AppElevation.popup,
              dropdownColor:
                  widget.isDisabled ? AppColors.grey100 : AppColors.white,
              hint: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.hint,
                  style: const TextStyle(
                    color: AppColors.green600,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              isExpanded: true,
              value: firstValue?.value,
              iconEnabledColor: widget.isDisabled
                  ? Theme.of(context).disabledColor
                  : AppColors.green800,
              items: dropItems,
              onChanged: (InputItem? val) {
                if (val != null) {
                  _onChangedItem(val);
                }
              },
              onTap: () {
                //Hide keyboard
                final FocusScopeNode currentScope = FocusScope.of(context);
                if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
              },
              selectedItemBuilder: (BuildContext context) {
                return widget.itemList.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      widget.label.isNotEmpty
                          ? Text(
                              widget.label,
                              style: TextStyle(
                                color: widget.isDisabled
                                    ? AppColors.grey300
                                    : AppColors.green800,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Expanded(
                        child: ScrollWrapper(
                          thumbVisibility: _scrollControllerList.isNotEmpty,
                          thickness: 2.0,
                          crossAxisMargin: -4,
                          color: AppColors.grey300,
                          controller: _scrollControllerList.elementAt(index),
                          child: SingleChildScrollView(
                            controller: _scrollControllerList.elementAt(index),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  item.displayLabel,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: AppColors.grey600,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (otherCount.isNotEmpty)
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    margin: const EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: AppColors.green600,
                                    ),
                                    child: Text(
                                      otherCount,
                                      style: const TextStyle(
                                        color: AppColors.grey600,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      widget.label.isNotEmpty
                          ? const SizedBox(height: 11)
                          : const SizedBox.shrink(),
                    ],
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
