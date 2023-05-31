import 'package:absensi_bapenda/app/data/controllers/page_index_controller.dart';
import 'package:absensi_bapenda/theme/color.dart';
import 'package:absensi_bapenda/theme/style.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PageIndexController pageC = Get.put(PageIndexController());

    return Scaffold(
      key: controller.scaffoldKey,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 30.h),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ANDRIAN WAHYU",
                      style: poppins.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Pengendalian Pajak Daerah",
                      style: poppins.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.r),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await controller.logout();
                    },
                    child: ClipOval(
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: Center(
                          child: Image.network(
                            "https://ui-avatars.com/api/?name=Andrian+Wahyu&background=0D8ABC&bold=true&color=fff&rounded=true",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: cardBlueColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Absen Pagi",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: textWhiteColor,
                              ),
                            ),
                            Text(
                              "06:00",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textWhiteColor,
                              ),
                            )
                          ],
                        ),
                        Container(
                            width: 2.w, height: 35.h, color: lineBlueColor),
                        Column(
                          children: [
                            Text(
                              "Absen Siang 1",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: textWhiteColor,
                              ),
                            ),
                            Text(
                              "-",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textWhiteColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      height: 2.h,
                      color: lineBlueColor,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Absen Siang 2",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: textWhiteColor,
                              ),
                            ),
                            Text(
                              "13:30",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textWhiteColor,
                              ),
                            )
                          ],
                        ),
                        Container(
                            width: 2.w, height: 35.h, color: lineBlueColor),
                        Column(
                          children: [
                            Text(
                              "Absen Pulang",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: textWhiteColor,
                              ),
                            ),
                            Text(
                              "16:00",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textWhiteColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              height: 4.h,
              color: const Color(0xffE4E4E4),
            ),
            SizedBox(height: 20.h),
            Text(
              "Riwayat Absen",
              style: poppins.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.h),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: cardBlueLightColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Absen Pagi",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textBlueColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "06:00",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textBlueColor,
                              ),
                            ),
                            Text(
                              "Bapenda",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textBlueColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Senin, 24 Mei 2023",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: textBlueColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Absen Siang 1",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "-",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                          ),
                        ),
                        Text(
                          "-",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Absen Siang 2",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "14:00",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                          ),
                        ),
                        Text(
                          "Sekretariat",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Absen Pulang",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "16:00",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                          ),
                        ),
                        Text(
                          "UPT Sekretariat",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: cardBlueLightColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Absen Pagi",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textBlueColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "06:00",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textBlueColor,
                              ),
                            ),
                            Text(
                              "Bapenda",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textBlueColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Minggu, 23 Mei 2023",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: textBlueColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Absen Siang 1",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "-",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                          ),
                        ),
                        Text(
                          "-",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Absen Siang 2",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "-",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                          ),
                        ),
                        Text(
                          "-",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Absen Pulang",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "16:00",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                          ),
                        ),
                        Text(
                          "UPT Sekretariat",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            color: textBlueColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => ConvexAppBar(
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
          initialActiveIndex: pageC.pageIndex.value,
          onTap: (int i) => pageC.changePage(i),
        ),
      ),
    );
  }
}
