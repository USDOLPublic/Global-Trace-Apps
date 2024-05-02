import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';

class DateTimeInput extends StatelessWidget {
  final DateTime? selected;
  final String hint;
  final String label;
  final bool isDisabled;
  final bool isAllowingGreaterThanToday;
  final bool isOnlyDate;
  final String? formatDateTime;
  final Function(DateTime?) onChanged;

  const DateTimeInput({
    Key? key,
    this.selected,
    this.hint = "",
    this.label = "",
    this.isDisabled = false,
    this.isAllowingGreaterThanToday = true,
    this.isOnlyDate = false,
    this.formatDateTime,
    required this.onChanged,
  }) : super(key: key);

  void _selectOnClicked(BuildContext context) {
    //Hide keyboard
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    if (isDisabled) return;

    DateTime? maxDate;
    DateTime? currentSelected = selected;
    if (!isAllowingGreaterThanToday) {
      maxDate = DateTime.now();
      if (selected != null && selected!.isAfter(maxDate)) {
        currentSelected = maxDate;
        maxDate = maxDate.add(const Duration(seconds: 5));
      }
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DateTimeSelector(
        dateTimeInited: currentSelected,
        maxDate: maxDate,
        isOnlyDate: isOnlyDate,
        onSelected: (val) {
          LogUtil.d("Date Time Selected: " + (val?.toIso8601String() ?? "null"));
          // ignore: unnecessary_type_check
          if (val != null && val is DateTime) {
            onChanged(val);
          }
        },
        formatDateTime: AppProperties.dateFormatDefault,
      ),
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppProperties.circleRadius)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppProperties.inputHight,
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.green800),
        borderRadius: BorderRadius.circular(AppProperties.circleRadius),
        color: AppColors.white,
      ),
      child: InkWell(
        onTap: () => _selectOnClicked(context),
        child: Row(
          children: [
            Expanded(
              child: selected == null
                  ? Text(
                      hint,
                      style: const TextStyle(color: AppColors.green600),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        label.isEmpty
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  label,
                                  style: Theme.of(context).textTheme.bodySmall?.apply(
                                        color: AppColors.green800,
                                      ),
                                ),
                              ),
                        Text(
                          DateUtil.formatDateStr(
                            selected.toString(),
                            format: formatDateTime ?? AppProperties.dateTimeFormatDefault,
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w400).apply(color: AppColors.grey600),
                        ),
                      ],
                    ),
            ),
            const SizedBox(width: 16),
            SvgPicture.asset(AssetsConst.svgCalendar),
          ],
        ),
      ),
    );
  }
}
