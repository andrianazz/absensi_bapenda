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
                    Obx(
                      () => Text(
                        controller.userModel.value.nama ?? "Tidak Ada Nama",
                        style: poppins.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: () async {},
                        child: Text(
                          controller.userModel.value.unitKerja?.namaUnitKerja ??
                              "Tidak Ada Unit",
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.r),
                    ),
                    child: GestureDetector(
                      onTap: () async {},
                      child: ClipOval(
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                controller.defaultImage.value,
                              ),
                              fit: BoxFit.cover,
                            ),
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
                              controller.dataAbsenModel.value.absentoday
                                      ?.jamMasuk ??
                                  "-",
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
                              controller.dataAbsenModel.value.absentoday
                                      ?.jamSiang ??
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
                      color: const Color(0xffE4E4E4),
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
                              controller.dataAbsenModel.value.absentoday
                                      ?.jamSiang2 ??
                                  "-",
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
                              controller.dataAbsenModel.value.absentoday
                                      ?.jamPulang ??
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Riwayat Absen",
                  style: poppins.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Last 2 days",
                  style: poppins.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
                        Obx(
                          () => Column(
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
                                controller.dataAbsenModel.value.absenbefore?[0]
                                        .jamMasuk ??
                                    "-",
                                style: poppins.copyWith(
                                  fontSize: 14.sp,
                                  color: textBlueColor,
                                ),
                              ),
                              // Text(
                              //   masukC.mapFetchToday['status'] ?? "-",
                              //   style: poppins.copyWith(
                              //     fontSize: 14.sp,
                              //     color: textBlueColor,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Text(
                          controller.today,
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: textBlueColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Obx(
                      () => Column(
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
                            controller.dataAbsenModel.value.absenbefore?[0]
                                    .jamSiang ??
                                "-",
                            style: poppins.copyWith(
                              fontSize: 14.sp,
                              color: textBlueColor,
                            ),
                          ),
                          // Text(
                          //   siang1C.mapSiang1FetchToday['status'] ?? "-",
                          //   style: poppins.copyWith(
                          //     fontSize: 14.sp,
                          //     color: textBlueColor,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Obx(() => Column(
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
                              controller.dataAbsenModel.value.absenbefore?[0]
                                      .jamSiang2 ??
                                  "-",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textBlueColor,
                              ),
                            ),
                            // Text(
                            //   siang2C.mapSiang2FetchToday['status'] ?? "-",
                            //   style: poppins.copyWith(
                            //     fontSize: 14.sp,
                            //     color: textBlueColor,
                            //   ),
                            // ),
                          ],
                        )),
                    SizedBox(height: 20.h),
                    Obx(
                      () => Column(
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
                            controller.dataAbsenModel.value.absenbefore?[0]
                                    .jamPulang ??
                                "-",
                            style: poppins.copyWith(
                              fontSize: 14.sp,
                              color: textBlueColor,
                            ),
                          ),
                        ],
                      ),
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
                        Obx(
                          () => Column(
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
                                controller.dataAbsenModel.value.absenbefore?[1]
                                        .jamMasuk ??
                                    "-",
                                style: poppins.copyWith(
                                  fontSize: 14.sp,
                                  color: textBlueColor,
                                ),
                              ),
                              // Text(
                              //   masukC.mapFetchYesterday['status'] ?? "-",
                              //   style: poppins.copyWith(
                              //     fontSize: 14.sp,
                              //     color: textBlueColor,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Text(
                          controller.yesterday,
                          style: poppins.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: textBlueColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Obx(
                      () => Column(
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
                            controller.dataAbsenModel.value.absenbefore?[1]
                                    .jamSiang ??
                                "-",
                            style: poppins.copyWith(
                              fontSize: 14.sp,
                              color: textBlueColor,
                            ),
                          ),
                          // Text(
                          //   siang1C.mapSiang1FetchYesterday['status'] ?? "-",
                          //   style: poppins.copyWith(
                          //     fontSize: 14.sp,
                          //     color: textBlueColor,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Obx(() => Column(
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
                              controller.dataAbsenModel.value.absenbefore?[1]
                                      .jamSiang2 ??
                                  "-",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textBlueColor,
                              ),
                            ),
                            // Text(
                            //   siang2C.mapSiang2FetchYesterday['status'] ?? "-",
                            //   style: poppins.copyWith(
                            //     fontSize: 14.sp,
                            //     color: textBlueColor,
                            //   ),
                            // ),
                          ],
                        )),
                    SizedBox(height: 20.h),
                    Obx(
                      () => Column(
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
                            controller.dataAbsenModel.value.absenbefore?[1]
                                    .jamPulang ??
                                "-",
                            style: poppins.copyWith(
                              fontSize: 14.sp,
                              color: textBlueColor,
                            ),
                          ),
                          // Text(
                          //   pulangC.mapPulangFetchYesterday['status'] ?? "-",
                          //   style: poppins.copyWith(
                          //     fontSize: 14.sp,
                          //     color: textBlueColor,
                          //   ),
                          // ),
                        ],
                      ),
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
          items: [
            const TabItem(
              icon: Icons.home,
              title: 'Home',
            ),
            TabItem(
              icon: pageC.isLoading.isFalse
                  ? Icons.fingerprint
                  : Icons.restore_sharp,
              title: 'ABSEN',
            ),
            const TabItem(icon: Icons.people, title: 'Profile'),
          ],
          style: TabStyle.fixedCircle,
          initialActiveIndex: pageC.pageIndex.value,
          onTap: (int i) =>
              pageC.isLoading.isFalse ? pageC.changePage(i) : null,
        ),
      ),
    );
  }
}
