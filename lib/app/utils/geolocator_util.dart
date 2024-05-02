import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:usdol/app/core.dart';

class GeolocatorUtil {
  static Future<bool> isAllowedPermission(BuildContext context, {bool isEnableGotoAppSetting = false}) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      LogUtil.e('Location services are disabled.');
      await Get.dialog<void>(
        BasePopup(
          title: Text(
            S.of(context).locationIsOff,
            style: const TextStyle(fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
          body: Text(S.of(context).turnOnLocation),
          actions: [
            TextButton(
              onPressed: () async {
                Get.back<void>();
              },
              child: Text(S.of(context).ok),
            ),
          ],
        ),
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      LogUtil.e('Location permissions are permanently denied, we cannot request permissions.');
      if (isEnableGotoAppSetting) {
        await Get.dialog<void>(
          BasePopup(
            title: Text(
              S.of(context).unableToAccessLocation,
              style: const TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.start,
            ),
            body: Text(S.of(context).locationAccessDenied),
            actions: [
              TextButton(
                onPressed: () async {
                  Get.back<void>();
                  await Geolocator.openAppSettings();
                  await Geolocator.openLocationSettings();
                },
                child: Text(S.of(context).ok),
              ),
            ],
          ),
        );
      }
      return false;
    }
    return true;
  }

  static Future<Position?> getCurrentPosition(BuildContext context, {bool isEnableGotoAppSetting = false}) async {
    try {
      bool isAllowed = await isAllowedPermission(context, isEnableGotoAppSetting: isEnableGotoAppSetting);
      if (isAllowed) {
        return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low,
            timeLimit: const Duration(
              milliseconds: 15000,
            ));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Position?> getLastKnowPosition(
    BuildContext context, {
    bool isEnableGotoAppSetting = false,
  }) async {
    try {
      bool isAllowed = await isAllowedPermission(context,
          isEnableGotoAppSetting: isEnableGotoAppSetting);
      if (isAllowed) {
        return await Geolocator.getLastKnownPosition();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getCurrentIsoCountry(BuildContext context, {bool isEnableGotoAppSetting = false}) async {
    bool isAllowed = await isAllowedPermission(context, isEnableGotoAppSetting: isEnableGotoAppSetting);
    if (isAllowed) {
      Position pos = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      // ignore: unnecessary_null_comparison
      if (placemarks != null && placemarks.isNotEmpty) {
        return placemarks[0].isoCountryCode;
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  static Future<String> getCurrentCountry(BuildContext context, {bool isEnableGotoAppSetting = false}) async {
    bool isAllowed = await isAllowedPermission(context, isEnableGotoAppSetting: isEnableGotoAppSetting);
    if (isAllowed) {
      Position pos = await Geolocator.getCurrentPosition();
      List<Placemark>? placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      // ignore: unnecessary_null_comparison
      if (placemarks != null && placemarks.isNotEmpty) {
        return placemarks[0].country ?? "";
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  static Future<String> getAddressInfo(BuildContext context, {required Position latLng, bool isEnableGotoAppSetting = false}) async {
    bool isAllowed = await isAllowedPermission(context, isEnableGotoAppSetting: isEnableGotoAppSetting);
    if (isAllowed) {
      List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        List<String> addressInfor = [];
        Placemark place = placemarks.first;
        if (place.street != null && place.street!.isNotEmpty) {
          addressInfor.add(place.street!);
        }
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          addressInfor.add(place.subLocality!);
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          addressInfor.add(place.locality!);
        }
        if (place.country != null && place.country!.isNotEmpty) {
          addressInfor.add(place.country!);
        }
        return addressInfor.join(", ");
      } else {
        return "";
      }
    } else {
      return "";
    }
  }
}
