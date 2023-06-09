import 'package:absensi_bapenda/app/data/controllers/absensi_controller.dart';
import 'package:absensi_bapenda/app/data/controllers/masuk_controller.dart';
import 'package:absensi_bapenda/app/data/controllers/pulang_controller.dart';
import 'package:absensi_bapenda/app/data/controllers/siang1_controller.dart';
import 'package:absensi_bapenda/app/data/controllers/siang2_controller.dart';
import 'package:absensi_bapenda/app/data/models/absensi_model.dart';
import 'package:absensi_bapenda/app/data/models/masuk_model.dart';
import 'package:absensi_bapenda/app/data/models/pulang_model.dart';
import 'package:absensi_bapenda/app/data/models/siang1_model.dart';
import 'package:absensi_bapenda/app/data/models/siang2_model.dart';
import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:absensi_bapenda/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  MasukController masukC = Get.put(MasukController());
  Siang1Controller siang1C = Get.put(Siang1Controller());
  Siang2Controller siang2C = Get.put(Siang2Controller());
  PulangController pulangC = Get.put(PulangController());
  AbsensiController absensiC = Get.put(AbsensiController());

  HomeController homeC = Get.put(HomeController());

  RxInt pageIndex = 0.obs;

  void changePage(int i) async {
    switch (i) {
      case 0:
        pageIndex.value = 0;

        Get.offAllNamed(Routes.HOME);
        break;

      case 1:
        pageIndex.value = 1;

        //Cek Absensi hari ini
        Absensi absensi = await absensiC.getAbsensiToday();
        if (absensi.id == null) {
          print("hari ini belum ada");
          await absensiC.createAbsensiToday();
        }

        //check day is weekend
        bool isWeekend = await homeC.isWeekend();

        if (isWeekend) {
          Get.dialog(
            AlertDialog(
              title: const Text("Peringatan"),
              content: const Text(
                  "Hari ini adalah hari libur, Silahkan melakukan absen pada hari kerja"),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );

          break;
        }

        if (isTimeInRangeNotPagi()) {
          Get.dialog(
            AlertDialog(
              title: const Text("Peringatan"),
              content: const Text(
                  "Absen Masuk dibuka dari jam 05:00 - 08:00, Silahkan melakukan absen pada waktu yang telah ditentukan"),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        } else if (isTimeInRangeNotSiang1()) {
          Get.dialog(
            AlertDialog(
              title: const Text("Peringatan"),
              content: const Text(
                  "Absen Siang 1 dibuka dari jam 11:30 - 12:00, Silahkan melakukan absen pada waktu yang telah ditentukan"),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        } else if (isTimeInRangeNotSiang2()) {
          Get.dialog(
            AlertDialog(
              title: const Text("Peringatan"),
              content: const Text(
                  "Absen Siang 2 dibuka dari jam 13:00 - 14:00, Silahkan melakukan absen pada waktu yang telah ditentukan"),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        } else if (isTimeInRangeNotPulang()) {
          Get.dialog(
            AlertDialog(
              title: const Text("Peringatan"),
              content: const Text(
                  "Absen Pulang dibuka dari jam 16:00 - 23:59, Silahkan melakukan absen pada waktu yang telah ditentukan"),
              actions: [
                TextButton(
                  onPressed: () async {
                    Get.back();
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        } else {
          Map<String, dynamic> dataResponse = await _determinePosition();
          Position position = dataResponse['position'];

          if (dataResponse['error'] == true) {
            Get.snackbar("Terjadi Kesalahan", dataResponse['message']);
          } else {
            List<Placemark> placemarks = await GeocodingPlatform.instance
                .placemarkFromCoordinates(position.latitude, position.longitude,
                    localeIdentifier: "id_ID");

            String address =
                "${placemarks[placemarks.length - 1].street}, ${placemarks[placemarks.length - 1].subLocality}, ${placemarks[placemarks.length - 1].locality}";

            await updatePosition(position, address);
            await presence(position, address);
          }
        }

        break;
      case 2:
        pageIndex.value = 2;
        Get.offAllNamed(Routes.PROFILE);

        break;
      default:
        pageIndex.value = 0;
        Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> updatePosition(Position position, String address) async {
    print("updatePosition: $position");
    print("address: $address");
  }

  Future<void> presence(Position position, String address) async {
    //Koordinat setiap UPT dan Bapenda
    double distanceBapenda = Geolocator.distanceBetween(
        position.latitude, position.longitude, 0.523141, 101.440834);
    double distanceUPT1 = Geolocator.distanceBetween(
        position.latitude, position.longitude, 0.532123, 101.450668);
    double distanceUPT2 = Geolocator.distanceBetween(
        position.latitude, position.longitude, 0.560506, 101.440522);
    double distanceUPT3 = Geolocator.distanceBetween(
        position.latitude, position.longitude, 0.476278, 101.429556);
    double distanceUPT4 = Geolocator.distanceBetween(
        position.latitude, position.longitude, 0.500229, 101.412943);
    double distanceUPT5 = Geolocator.distanceBetween(
        position.latitude, position.longitude, 0.465298, 101.387372);

    //Status sebagai jalan / kantor
    String status = address;

    //Codition jika diluar jarak kantor
    if (homeC.userModel.value.unitKerjaId == 1) {
      if (distanceUPT1 <= 50) {
        status = "UPT 1";
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text("Peringatan"),
            content: const Text(
                "Anda berada diluar jarak kantor UPT1, Silahkan melakukan absen pada lokasi yang telah ditentukan"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
        return;
      }
    } else if (homeC.userModel.value.unitKerjaId == 2) {
      if (distanceUPT2 <= 50) {
        status = "UPT 2";
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text("Peringatan"),
            content: const Text(
                "Anda berada diluar jarak kantor UPT2, Silahkan melakukan absen pada lokasi yang telah ditentukan"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
        return;
      }
    } else if (homeC.userModel.value.unitKerjaId == 3) {
      if (distanceUPT3 <= 50) {
        status = "UPT 3";
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text("Peringatan"),
            content: const Text(
                "Anda berada diluar jarak  UPT 3, Silahkan melakukan absen pada lokasi yang telah ditentukan"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
        return;
      }
    } else if (homeC.userModel.value.unitKerjaId == 4) {
      if (distanceUPT4 <= 50) {
        status = "UPT 4";
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text("Peringatan"),
            content: const Text(
                "Anda berada diluar jarak kantor UPT 4, Silahkan melakukan absen pada lokasi yang telah ditentukan"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
        return;
      }
    } else if (homeC.userModel.value.unitKerjaId == 5) {
      if (distanceUPT5 <= 50) {
        status = "UPT 5";
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text("Peringatan"),
            content: const Text(
                "Anda berada diluar jarak kantor UPT 5, Silahkan melakukan absen pada lokasi yang telah ditentukan"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
        return;
      }
    } else if (homeC.userModel.value.unitKerjaId! >= 6) {
      if (distanceBapenda <= 100) {
        status = "Bapenda Pekanbaru";
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text("Peringatan"),
            content: const Text(
                "Anda berada diluar jarak kantor Bapenda, Silahkan melakukan absen pada lokasi yang telah ditentukan"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
        return;
      }
    }

    Masuk masuk = await masukC.getMasukToday();
    Siang1 siang1 = await siang1C.getSiang1Today();
    Siang2 siang2 = await siang2C.getSiang2Today();
    Pulang pulang = await pulangC.getPulangToday();

    //Memasukkan data ke dalam database
    if (isTimeInRangePagi()) {
      if (masuk.id == null) {
        Get.dialog(
          AlertDialog(
            title: const Text("ABSEN MASUK"),
            content: const Text("Apakah anda ingin melakukan absen masuk"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Tidak"),
              ),
              TextButton(
                onPressed: () async {
                  await masukC.postMasuk(
                    position,
                    distanceBapenda.toInt(),
                    status,
                  );
                },
                child: const Text("Absen"),
              ),
            ],
          ),
        );
      } else {
        Get.dialog(AlertDialog(
          title: const Text("Peringatan"),
          content: const Text("Anda sudah melakukan absen masuk"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("OK"),
            ),
          ],
        ));
      }
    } else if (isTimeInRangeSiang1()) {
      if (siang1.id == null) {
        // await masukC.postMasuk(position, status);
        Get.dialog(
          AlertDialog(
            title: const Text("ABSEN SIANG 1"),
            content: const Text("Apakah anda ingin melakukan absen Siang 1"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Tidak"),
              ),
              TextButton(
                onPressed: () async {
                  await siang1C.postSiang1(
                    position,
                    distanceBapenda.toInt(),
                    status,
                  );
                },
                child: const Text("Absen"),
              ),
            ],
          ),
        );
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text("Peringatan"),
            content: const Text("Anda sudah melakukan absen Siang 1"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    } else if (isTimeInRangeSiang2()) {
      if (siang2.id == null) {
        // await masukC.postMasuk(position, status);
        Get.dialog(
          AlertDialog(
            title: const Text("ABSEN SIANG 2"),
            content: const Text("Apakah anda ingin melakukan absen Siang 2"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Tidak"),
              ),
              TextButton(
                onPressed: () async {
                  await siang2C.postSiang2(
                    position,
                    distanceBapenda.toInt(),
                    status,
                  );
                },
                child: const Text("Absen"),
              ),
            ],
          ),
        );
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text("Peringatan"),
            content: const Text("Anda sudah melakukan absen Siang 2"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    } else if (isTimeInRangePulang()) {
      if (pulang.id == null) {
        Get.dialog(
          AlertDialog(
            title: const Text("ABSEN PULANG"),
            content: const Text("Apakah anda ingin melakukan absen Pulang"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Tidak"),
              ),
              TextButton(
                onPressed: () async {
                  await pulangC.postPulang(
                    position,
                    distanceBapenda.toInt(),
                    ' $address',
                  );

                  Get.offAllNamed(Routes.HOME);
                },
                child: const Text("Absen"),
              ),
            ],
          ),
        );
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text("Peringatan"),
            content: const Text("Anda sudah melakukan absen Pulang"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<Map<String, dynamic>> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return {
        'message': 'Location services are disabled.',
        'error': true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return {
          'message': 'Location permissions are denied',
          'error': true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return {
        'message':
            'Location permissions are permanently denied, we cannot request permissions.',
        'error': true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    return {
      'position': position,
      'message': 'Berhasil mendapatkan position',
      'error': false,
    };
  }

  bool isTimeInRangePagi() {
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, 5, 0);
    var endTime = DateTime(now.year, now.month, now.day, 8, 0);
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  bool isTimeInRangeSiang1() {
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, 11, 30);
    var endTime = DateTime(now.year, now.month, now.day, 12, 0);
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  bool isTimeInRangeSiang2() {
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, 13, 00);
    var endTime = DateTime(now.year, now.month, now.day, 14, 0);
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  bool isTimeInRangePulang() {
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, 16, 00);
    var endTime = DateTime(now.year, now.month, now.day, 23, 59);
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  bool isTimeInRangeNotPagi() {
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, 00, 01);
    var endTime = DateTime(now.year, now.month, now.day, 04, 59);
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  bool isTimeInRangeNotSiang1() {
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, 8, 1);
    var endTime = DateTime(now.year, now.month, now.day, 11, 29);
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  bool isTimeInRangeNotSiang2() {
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, 12, 01);
    var endTime = DateTime(now.year, now.month, now.day, 12, 59);
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  bool isTimeInRangeNotPulang() {
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, 14, 1);
    var endTime = DateTime(now.year, now.month, now.day, 15, 59);
    return now.isAfter(startTime) && now.isBefore(endTime);
  }
}
