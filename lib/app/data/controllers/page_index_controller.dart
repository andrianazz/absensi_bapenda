import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:absensi_bapenda/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  // FirebaseAuth auth = FirebaseAuth.instance;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  void changePage(int i) async {
    switch (i) {
      case 0:
        pageIndex.value = 0;
        Get.offAllNamed(Routes.HOME);
        break;

      case 1:
        pageIndex.value = 1;

        Map<String, dynamic> dataResponse = await _determinePosition();
        Position position = dataResponse['position'];

        if (dataResponse['error'] == true) {
          Get.snackbar("Terjadi Kesalahan", dataResponse['message']);
        } else {
          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);

          String address =
              "${placemarks[0].name}, ${placemarks[0].subLocality}, ${placemarks[0].locality}";
          await updatePosition(position, address);
          await presence(position, address);
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
    // String uid = auth.currentUser!.uid;
    // await firestore.collection('pegawai').doc(uid).update(
    //   {
    //     'position': {
    //       'latitude': position.latitude,
    //       'longitude': position.longitude,
    //     },
    //     'address': address,
    //   },
    // );
  }

  Future<void> presence(Position position, String address) async {
    // String uid = auth.currentUser!.uid;
    // String now = DateFormat.yMd().format(DateTime.now()).replaceAll("/", "-");

    // CollectionReference<Map<String, dynamic>> presenceRef =
    //     firestore.collection('pegawai').doc(uid).collection("presence");

    // QuerySnapshot<Map<String, dynamic>> snapshot = await presenceRef.get();

    // double distanceInMeters = Geolocator.distanceBetween(position.latitude,
    //     position.longitude, 0.5477153324473172, 101.42622971181308);

    // String status = "Di Luar Area";

    // if (distanceInMeters <= 200) {
    //   status = "Di dalam Area";
    // }

    // if (snapshot.docs.isEmpty) {
    //   //Eksekusi Masuk
    //   await Get.defaultDialog(
    //     title: "Validasi Absen",
    //     middleText: "APAKAH ANDA YAKIN INGIN MELAKUKAN ABSEN MASUK HARI INI?",
    //     actions: [
    //       OutlinedButton(
    //         onPressed: () => Get.back(),
    //         child: const Text("CANCEL"),
    //       ),
    //       ElevatedButton(
    //           onPressed: () async {
    //             await presenceRef.doc(now).set(
    //               {
    //                 'date': DateTime.now().toIso8601String(),
    //                 'masuk': {
    //                   'date': DateTime.now().toIso8601String(),
    //                   'latitude': "${position.latitude}",
    //                   'longitude': "${position.longitude}",
    //                   'distance': distanceInMeters,
    //                   'address': address,
    //                   'status': status,
    //                 }
    //               },
    //             );

    //             Get.back();

    //             Get.snackbar("Berhasil", "ANDA BERHASIL MELAKUKAN ABSEN MASUK");
    //           },
    //           child: const Text("ABSEN")),
    //     ],
    //   );
    // } else {
    //   //Eksekusi Keluar
    //   DocumentSnapshot<Map<String, dynamic>> todayDocs =
    //       await presenceRef.doc(now).get();

    //   if (todayDocs.exists) {
    //     if (todayDocs.data()!['keluar'] == null) {
    //       await Get.defaultDialog(
    //         title: "Validasi Absen",
    //         middleText:
    //             "APAKAH ANDA YAKIN INGIN MELAKUKAN ABSEN KELUAR HARI INI?",
    //         actions: [
    //           OutlinedButton(
    //             onPressed: () => Get.back(),
    //             child: const Text("CANCEL"),
    //           ),
    //           ElevatedButton(
    //               onPressed: () async {
    //                 await presenceRef.doc(now).update(
    //                   {
    //                     'keluar': {
    //                       'date': DateTime.now().toIso8601String(),
    //                       'latitude': "${position.latitude}",
    //                       'longitude': "${position.longitude}",
    //                       'distance': distanceInMeters,
    //                       'address': address,
    //                       'status': status,
    //                     }
    //                   },
    //                 );

    //                 Get.back();

    //                 Get.snackbar(
    //                     "Berhasil", "ANDA BERHASIL MELAKUKAN ABSEN KELUAR");
    //               },
    //               child: const Text("ABSEN")),
    //         ],
    //       );
    //     } else {
    //       Get.snackbar("INFORMASI", "Anda sudah melakukan absen hari ini");
    //     }
    //   } else {
    //     await Get.defaultDialog(
    //       title: "Validasi Absen",
    //       middleText: "APAKAH ANDA YAKIN INGIN MELAKUKAN ABSEN MASUK HARI INI?",
    //       actions: [
    //         OutlinedButton(
    //           onPressed: () => Get.back(),
    //           child: const Text("CANCEL"),
    //         ),
    //         ElevatedButton(
    //             onPressed: () async {
    //               await presenceRef.doc(now).update(
    //                 {
    //                   'masuk': {
    //                     'date': DateTime.now().toIso8601String(),
    //                     'latitude': "${position.latitude}",
    //                     'longitude': "${position.longitude}",
    //                     'distance': distanceInMeters,
    //                     'address': address,
    //                     'status': status,
    //                   }
    //                 },
    //               );

    //               Get.back();

    //               Get.snackbar(
    //                   "Berhasil", "ANDA BERHASIL MELAKUKAN ABSEN MASUK");
    //             },
    //             child: const Text("ABSEN")),
    //       ],
    //     );
    //   }
    // }
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
}
