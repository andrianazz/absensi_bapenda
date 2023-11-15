import 'dart:convert';
import 'dart:io';

import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:absensi_bapenda/app/routes/app_pages.dart';
import 'package:absensi_bapenda/theme/variable.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  late SharedPreferences pref;

  File? _imageFile;
  final picker = ImagePicker();

  d.Dio dio = d.Dio();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File compressedImage = await compressImage(File(pickedFile.path));

      _imageFile = compressedImage;

      await uploadImage(_imageFile);
    }
  }

  Future<File> compressImage(File imageFile) async {
    final tempDir = await getTemporaryDirectory();
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg',
      quality: 70,
    );

    File fileCompressed = File(compressedFile!.path);
    return fileCompressed;
  }

  Future<void> uploadImage(File? imageFile) async {
    HomeController homeC = Get.put(HomeController());
    pref = await SharedPreferences.getInstance();

    if (imageFile == null) return;

    String url = '$baseUrlAPI/images';

    try {
      d.FormData formData = d.FormData.fromMap({
        'image': await d.MultipartFile.fromFile(imageFile.path),
        'nik': homeC.userModel.value.nik,
      });

      // print(url);
      await dio.post(url, data: formData);

      // print('Image uploaded successfully');

      // set prefuser and change attibute imageUrl
      homeC.userModel.value.imageUrl = "";
      homeC.userModel.value.imageUrl = '${homeC.userModel.value.nik}.jpg';
      homeC.mapUser['data']['imageUrl'] = homeC.userModel.value.imageUrl;

      // print((homeC.mapUser['data']));

      String user = jsonEncode({'data': homeC.mapUser['data']});

      pref.clear();
      await pref.setString('user', user);

      Get.forceAppUpdate();
      Get.offAllNamed(Routes.HOME);

      // Restart.restartApp(webOrigin: Routes.HOME);
    } catch (error) {
      // print('Failed to upload image: $error');
    }
  }
}
