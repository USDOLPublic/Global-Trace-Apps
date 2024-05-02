import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';
import 'package:usdol/plugins/typeahead/flutter_typeahead.dart';

class SearchInput<T> extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode searchFocus;
  final void Function(String)? onChanged;
  final FutureOr<Iterable<T>> Function(String) suggestionsCallback;
  final Widget Function(BuildContext, T) itemBuilder;
  final void Function(T) onSuggestionSelected;
  final String labelText;

  const SearchInput({
    Key? key,
    required this.searchController,
    required this.searchFocus,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
    required this.labelText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: AppColors.grey600,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
    InputBorder searchOutLineBorder = OutlineInputBorder(
      gapPadding: 0,
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(AppProperties.circleRadius),
    );
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppProperties.circleRadius),
        color: AppColors.white,
        border: Border.all(
          width: 1,
          color: AppColors.green800,
        ),
      ),
      child: TypeAheadFormField<T>(
        key: const ValueKey('inputSearch'),
        noItemsFoundBuilder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: Row(
              children: [
                const Icon(Icons.warning_rounded),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(S.of(context).noResultFound),
                ),
              ],
            ),
          );
        },
        suggestionsBoxDecoration: SuggestionsBoxDecoration(borderRadius: BorderRadius.circular(8)),
        loadingBuilder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 36,
              child: Center(
                child: ThreeBounceLoading(),
              ),
            ),
          );
        },
        keepSuggestionsOnLoading: false,
        textFieldConfiguration: TextFieldConfiguration(
          controller: searchController,
          focusNode: searchFocus,
          style: textStyle,
          decoration: InputDecoration(
            counterText: '',
            labelText: labelText,
            labelStyle: const TextStyle(
              height: 5,
              color: AppColors.green600,
            ),
            filled: true,
            contentPadding: const EdgeInsets.only(
              top: 21,
              left: 10,
              right: 10,
              bottom: 21,
            ),
            suffixIcon: SizedBox(
              height: 24,
              width: 24,
              child: Row(
                children: [
                  const SizedBox(
                    height: 24,
                    width: 12,
                  ),
                  SvgPicture.asset(
                    AssetsConst.iconSearchBlack,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            border: searchOutLineBorder,
            focusedBorder: searchOutLineBorder,
            enabledBorder: searchOutLineBorder,
            disabledBorder: searchOutLineBorder,
            errorBorder: searchOutLineBorder,
            focusedErrorBorder: searchOutLineBorder,
          ),
          onChanged: onChanged,
          inputFormatters: [FilteringTextInputFormatter.deny(RegExp(emojisUnicodes))],
        ),
        debounceDuration: const Duration(milliseconds: 500),
        suggestionsCallback: suggestionsCallback,
        itemBuilder: itemBuilder,
        onSuggestionSelected: onSuggestionSelected,
      ),
    );
  }
}
