import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usdol/app/core.dart';

class TextFieldInputController extends GetxController {
  final _inputInvalidMessage = "".obs;
  String get inputInvalidMessage => _inputInvalidMessage.value;
  set inputInvalidMessage(String val) => _inputInvalidMessage.value = val;

  final _inputValue = "".obs;
  String get inputValue => _inputValue.value;
  set inputValue(String val) => _inputValue.value = val;
}

class TextFieldInput extends GetView<TextFieldInputController> {
  final bool enabled;
  final bool readOnly;
  final double? width;
  final double? borderRadius;
  final bool autofocus;
  final AutovalidateMode? autovalidateMode;
  final int? maxLines;
  final int? maxLength;
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final String? counterText;
  final String? initialValue;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Widget? suffixIcon, prefixIcon;
  final TextInputAction? textInputAction;
  final TextEditingController? inputController;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? onFieldSubmitted;
  final BoxConstraints? suffixIconConstraints;
  final String? tagId;
  final List<TextInputFormatter>? inputFormatters;
  final Color disableBorderColor;
  final bool autoTrimValidator;
  final Color? inputBorderColor;
  final String? prefixText;
  final Widget? label;
  final double bottomOffset;

  TextFieldInput({
    Key? key,
    this.inputController,
    this.labelText,
    this.maxLength,
    this.focusNode,
    this.enabled = true,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.onFieldSubmitted,
    this.validator,
    this.hintText,
    this.errorText,
    this.margin,
    this.obscureText = false,
    this.suffixIcon,
    this.autofillHints,
    this.helperText,
    this.prefixIcon,
    this.initialValue,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.suffixIconConstraints,
    this.width,
    this.counterText,
    this.borderRadius,
    this.autovalidateMode,
    this.tagId,
    this.inputFormatters,
    this.disableBorderColor = AppColors.grey300,
    this.autoTrimValidator = true,
    this.inputBorderColor,
    this.prefixText,
    this.label,
    this.bottomOffset = 24,
  }) : super(key: key) {
    Get.put(TextFieldInputController(), tag: tagId);
  }

  @override
  String? get tag => tagId;

  @override
  Widget build(BuildContext context) {
    InputDecorationTheme inputTheme = Theme.of(context).inputDecorationTheme;
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      gapPadding: 0,
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius:
          BorderRadius.circular(borderRadius ?? AppProperties.circleRadius),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () {
            Color borderColor = !enabled
                ? disableBorderColor
                : inputBorderColor ??
                    (inputTheme.border?.borderSide.color ?? AppColors.green700);
            if (controller.inputInvalidMessage.isNotEmpty) {
              borderColor = Theme.of(context).colorScheme.error;
            }
            return Container(
              width: width,
              alignment: Alignment.centerLeft,
              // margin: margin,
              padding: const EdgeInsets.only(left: 0, right: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    borderRadius ?? AppProperties.circleRadius),
                color: !enabled ? disableBorderColor : (inputTheme.fillColor),
                border: Border.all(
                  width: 1,
                  color: borderColor,
                ),
              ),
              child: TextFormField(
                key: key,
                autovalidateMode: autovalidateMode,
                onTap: onTap,
                enabled: enabled,
                readOnly: readOnly,
                maxLines: maxLines,
                onChanged: (String? val) {
                  if (autoTrimValidator) {
                    val = val?.trim();
                  }
                  onChanged?.call(val ?? '');
                  controller.inputValue = val ?? '';
                  if (validator != null) {
                    String? errorMessage = validator?.call(val);
                    if (errorMessage != null) {
                      if (controller.inputInvalidMessage != errorMessage) {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          controller.inputInvalidMessage = errorMessage;
                        });
                      }
                    } else if (controller.inputInvalidMessage.isNotEmpty) {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        controller.inputInvalidMessage = "";
                      });
                    }
                  }
                },
                validator: (String? val) {
                  if (autoTrimValidator) {
                    val = val?.trim();
                  }
                  if (validator != null) {
                    String? errorMessage = validator?.call(val);
                    if (errorMessage != null) {
                      if (controller.inputInvalidMessage != errorMessage) {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          controller.inputInvalidMessage = errorMessage;
                        });
                      }
                      return errorMessage;
                    } else if (controller.inputInvalidMessage.isNotEmpty) {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        controller.inputInvalidMessage = "";
                      });
                    }
                  }
                  return null;
                },
                autofocus: autofocus,
                maxLength: maxLength,
                focusNode: focusNode,
                style: const TextStyle(
                  color: AppColors.grey600,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                controller: inputController,
                obscureText: obscureText,
                initialValue: initialValue,
                keyboardType: keyboardType,
                autofillHints: autofillHints,
                textInputAction: textInputAction,
                onFieldSubmitted: onFieldSubmitted,
                cursorColor: Theme.of(context).primaryColor,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  isCollapsed: true,
                  label: label,
                  alignLabelWithHint: true,
                  prefixText: prefixText,
                  labelStyle: TextStyle(
                    height: 5,
                    color: enabled
                        ? controller.inputValue.isNotEmpty
                            ? AppColors.green800
                            : AppColors.green600
                        : disableBorderColor,
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 21,
                    left: 10,
                    right: 10,
                    bottom: 21,
                  ),
                  fillColor: enabled ? inputTheme.fillColor : AppColors.grey100,
                  border: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  disabledBorder: outlineInputBorder,
                  errorBorder: outlineInputBorder,
                  focusedErrorBorder: outlineInputBorder,
                  errorStyle: const TextStyle(
                      height: 0, fontSize: 0.1, color: Colors.transparent),
                  // Custom input config
                  filled: !enabled,
                  hintText: hintText,
                  labelText: label != null ? null : labelText,
                  errorText: errorText,
                  // helperText: 'helperText',
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  // helperStyle: TextStyle(height: 0.55),
                  helperStyle: const TextStyle(height: 0),
                  counterText: counterText ?? '',
                  suffixIconConstraints: suffixIconConstraints,
                ),
                inputFormatters: (inputFormatters ?? [])
                  ..insertAll(0, [
                    FilteringTextInputFormatter.deny(RegExp(emojisUnicodes)),
                    NoLeadingSpaceFormatter(),
                  ]),
                scrollPadding: EdgeInsets.symmetric(vertical: bottomOffset),
              ),
            );
          },
        ),
        Obx(
          () {
            String message = controller.inputInvalidMessage;
            if (message.isEmpty) {
              return const SizedBox.shrink();
            } else {
              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Text(
                  message,
                  style: inputTheme.errorStyle,
                ),
              );
            }
          },
        ),
        if (helperText?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
            child: Text(
              helperText!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
      ],
    );
  }
}
