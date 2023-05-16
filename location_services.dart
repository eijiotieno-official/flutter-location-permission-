import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LocationServices {
  Future<bool> grantLocation() async {
    bool isGranted = false;
    await isLocationGranted().then(
      (granted) async {
        if (granted == false) {
          PermissionStatus permissionStatus =
              await Permission.location.request();
          if (permissionStatus == PermissionStatus.permanentlyDenied) {
            Fluttertoast.showToast(
              backgroundColor: Colors.red,
              gravity: ToastGravity.CENTER,
              msg: "Allow location permission",
            );
            await openAppSettings();
          } else if (permissionStatus == PermissionStatus.granted) {
            isGranted = true;
          }
        } else {
          isGranted = true;
        }
      },
    );
    return isGranted;
  }

  Future<bool> isLocationGranted() async {
    bool isGranted = await Permission.location.status.isGranted;

    return isGranted;
  }
}
