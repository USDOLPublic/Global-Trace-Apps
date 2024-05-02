import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:usdol/app/core.dart';

class CoordinateModel {
  double lat;
  double lng;

  CoordinateModel({required this.lat, required this.lng});
}

class GPSCoordinatesInput extends StatelessWidget {
  final String hint;
  final String label;
  final bool isDisabled;
  final CoordinateModel? selected;
  final Function(CoordinateModel?) onChanged;

  final _isDetecting = false.obs;
  bool get isDetecting => _isDetecting.value;
  set isDetecting(bool value) => _isDetecting.value = value;

  GPSCoordinatesInput({
    Key? key,
    this.hint = "",
    this.label = "",
    this.isDisabled = false,
    this.selected,
    required this.onChanged,
  }) : super(key: key);

  void _selectOnClicked(BuildContext context) async {
    //Hide keyboard
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    if (isDisabled || isDetecting) return;

    isDetecting = true;
    Position? pos = await GeolocatorUtil.getLastKnowPosition(
      context,
      isEnableGotoAppSetting: true,
    );
    if (pos != null) {
      onChanged(CoordinateModel(
        lat: pos.latitude,
        lng: pos.longitude,
      ));
    }
    isDetecting = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppProperties.inputHight,
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
            color: isDisabled ? AppColors.grey300 : AppColors.green800),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  label,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.apply(
                                        color: AppColors.green800,
                                      ),
                                ),
                              ),
                        Text(
                          "${selected?.lat.toStringAsFixed(5)}, ${selected?.lng.toStringAsFixed(5)}",
                          style: const TextStyle(fontWeight: FontWeight.w400)
                              .apply(color: AppColors.grey600),
                        ),
                      ],
                    ),
            ),
            const SizedBox(width: 16),
            Obx(() {
              if (isDetecting) {
                return const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.green600,
                  ),
                );
              } else {
                return IconButton(
                  key: const ValueKey("getGPSCoordinates"),
                  onPressed: () => _selectOnClicked(context),
                  icon: SvgPicture.asset(
                    AssetsConst.svgMyLocationIcon,
                    colorFilter: isDisabled
                        ? const ColorFilter.mode(
                            AppColors.grey300, BlendMode.srcIn)
                        : null,
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
