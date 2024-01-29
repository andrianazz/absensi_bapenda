import 'package:absensi_bapenda/app/data/controllers/page_index_controller.dart';
import 'package:absensi_bapenda/app/modules/home/controllers/home_controller.dart';
import 'package:absensi_bapenda/theme/style.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PageIndexController pageC = Get.put(PageIndexController());
    HomeController homeC = Get.put(HomeController());

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(flex: 3),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: GestureDetector(
                  onTap: () async {},
                  child: Obx(
                    () => Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.r),
                        image: DecorationImage(
                          image: NetworkImage(
                            homeC.defaultProfile.value,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Obx(
                () => Column(
                  children: [
                    Text(
                      homeC.userModel.value.nama?.toUpperCase() ?? "Tidak ada Nama",
                      style: poppins.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {},
                      child: Text(
                        homeC.userModel.value.unitKerja?.namaUnitKerja! ?? "Tidak ada Unit Kerja",
                        style: poppins.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 3),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                width: double.infinity,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () async {
                    await controller.pickImage();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  child: Text(
                    "UBAH FOTO",
                    style: poppins.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    // launchUrl(Uri.parse("http://github.com/andrianazz"));
                    // Logout
                    // await controller.logout();
                  },
                  child: Text(
                    "Versi 1.1.0",
                    style: poppins.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        height: 60.h,
        items: const [
          TabItem(
            icon: Icons.home,
            title: 'Home',
          ),
          TabItem(icon: Icons.fingerprint, title: 'ABSEN'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        style: TabStyle.fixedCircle,
        initialActiveIndex: 2,
        activeColor: Colors.white,
        onTap: (int i) => pageC.changePage(i),
      ),
    );
  }
}
