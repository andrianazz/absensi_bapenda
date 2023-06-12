import 'package:absensi_bapenda/app/data/controllers/masuk_controller.dart';
import 'package:absensi_bapenda/app/data/controllers/page_index_controller.dart';
import 'package:absensi_bapenda/app/data/controllers/pulang_controller.dart';
import 'package:absensi_bapenda/app/data/controllers/siang1_controller.dart';
import 'package:absensi_bapenda/app/data/controllers/siang2_controller.dart';
import 'package:absensi_bapenda/app/data/models/masuk_model.dart';
import 'package:absensi_bapenda/app/data/models/pulang_model.dart';
import 'package:absensi_bapenda/app/data/models/siang1_model.dart';
import 'package:absensi_bapenda/app/data/models/siang2_model.dart';
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
    MasukController masukC = Get.put(MasukController());
    Siang1Controller siang1C = Get.put(Siang1Controller());
    Siang2Controller siang2C = Get.put(Siang2Controller());
    PulangController pulangC = Get.put(PulangController());

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
                        onTap: () async {
                          await controller.logout();
                        },
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
                        FutureBuilder<Masuk>(
                            future: masukC.getMasukwithUserId(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData) {
                                return Column(
                                  children: [
                                    const CircularProgressIndicator(),
                                    Text(
                                      "Coba Update Lagi",
                                      style: poppins.copyWith(fontSize: 8.sp),
                                    ),
                                  ],
                                );
                              }

                              return Column(
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
                                    snapshot.data!.jamMasuk ?? "-",
                                    style: poppins.copyWith(
                                      fontSize: 14.sp,
                                      color: textWhiteColor,
                                    ),
                                  )
                                ],
                              );
                            }),
                        Container(
                            width: 2.w, height: 35.h, color: lineBlueColor),
                        FutureBuilder<Siang1>(
                            future: siang1C.getSiang1withUserId(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData) {
                                return Column(
                                  children: [
                                    const CircularProgressIndicator(),
                                    Text(
                                      "Coba Update Lagi",
                                      style: poppins.copyWith(fontSize: 8.sp),
                                    ),
                                  ],
                                );
                              }

                              return Column(
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
                                    snapshot.data!.jamSiang ?? "-",
                                    style: poppins.copyWith(
                                      fontSize: 14.sp,
                                      color: textWhiteColor,
                                    ),
                                  )
                                ],
                              );
                            }),
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
                        FutureBuilder<Siang2>(
                            future: siang2C.getSiang2withUserId(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData) {
                                return Column(
                                  children: [
                                    const CircularProgressIndicator(),
                                    Text(
                                      "Coba Update Lagi",
                                      style: poppins.copyWith(fontSize: 8.sp),
                                    ),
                                  ],
                                );
                              }

                              return Column(
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
                                    snapshot.data!.jamSiang2 ?? "-",
                                    style: poppins.copyWith(
                                      fontSize: 14.sp,
                                      color: textWhiteColor,
                                    ),
                                  )
                                ],
                              );
                            }),
                        Container(
                            width: 2.w, height: 35.h, color: lineBlueColor),
                        FutureBuilder<Pulang>(
                            future: pulangC.getPulangwithUserId(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData) {
                                return Column(
                                  children: [
                                    const CircularProgressIndicator(),
                                    Text(
                                      "Coba Update Lagi",
                                      style: poppins.copyWith(fontSize: 8.sp),
                                    ),
                                  ],
                                );
                              }

                              return Column(
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
                                    snapshot.data!.jamPulang ?? "-",
                                    style: poppins.copyWith(
                                      fontSize: 14.sp,
                                      color: textWhiteColor,
                                    ),
                                  )
                                ],
                              );
                            }),
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
                        FutureBuilder<Masuk>(
                            future: masukC.getMasukwithUserId(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (!snapshot.hasData) {
                                return Column(
                                  children: [
                                    const CircularProgressIndicator(),
                                    Text(
                                      "Coba Update Lagi",
                                      style: poppins.copyWith(fontSize: 8.sp),
                                    ),
                                  ],
                                );
                              }
                              return Column(
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
                                    snapshot.data!.jamMasuk ?? "-",
                                    style: poppins.copyWith(
                                      fontSize: 14.sp,
                                      color: textBlueColor,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.status ?? "-",
                                    style: poppins.copyWith(
                                      fontSize: 14.sp,
                                      color: textBlueColor,
                                    ),
                                  ),
                                ],
                              );
                            }),
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
                    FutureBuilder<Siang1>(
                        future: siang1C.getSiang1withUserId(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                semanticsValue: "Coba Update Lagi",
                              ),
                            );
                          }
                          return Column(
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
                                snapshot.data!.jamSiang ?? "-",
                                style: poppins.copyWith(
                                  fontSize: 14.sp,
                                  color: textBlueColor,
                                ),
                              ),
                              Text(
                                snapshot.data!.status ?? "-",
                                style: poppins.copyWith(
                                  fontSize: 14.sp,
                                  color: textBlueColor,
                                ),
                              ),
                            ],
                          );
                        }),
                    SizedBox(height: 20.h),
                    FutureBuilder<Siang2>(
                        future: siang2C.getSiang2withUserId(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                semanticsValue: "Coba Update Lagi",
                              ),
                            );
                          }
                          return Column(
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
                                snapshot.data!.jamSiang2 ?? "-",
                                style: poppins.copyWith(
                                  fontSize: 14.sp,
                                  color: textBlueColor,
                                ),
                              ),
                              Text(
                                snapshot.data!.status ?? "-",
                                style: poppins.copyWith(
                                  fontSize: 14.sp,
                                  color: textBlueColor,
                                ),
                              ),
                            ],
                          );
                        }),
                    SizedBox(height: 20.h),
                    FutureBuilder<Pulang>(
                      future: pulangC.getPulangwithUserId(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              semanticsValue: "Coba Update Lagi",
                            ),
                          );
                        }
                        return Column(
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
                              snapshot.data!.jamPulang ?? "-",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textBlueColor,
                              ),
                            ),
                            Text(
                              snapshot.data!.status ?? "-",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textBlueColor,
                              ),
                            ),
                          ],
                        );
                      },
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
                        FutureBuilder<Masuk>(
                            future: masukC.getMasukYesterday(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (!snapshot.hasData) {
                                return Column(
                                  children: [
                                    const CircularProgressIndicator(),
                                    Text(
                                      "Coba Update Lagi",
                                      style: poppins.copyWith(fontSize: 8.sp),
                                    ),
                                  ],
                                );
                              }
                              return Column(
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
                                    snapshot.data!.jamMasuk ?? "-",
                                    style: poppins.copyWith(
                                      fontSize: 14.sp,
                                      color: textBlueColor,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.status ?? "-",
                                    style: poppins.copyWith(
                                      fontSize: 14.sp,
                                      color: textBlueColor,
                                    ),
                                  ),
                                ],
                              );
                            }),
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
                    FutureBuilder<Siang1>(
                        future: siang1C.getSiang1Yesterday(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                semanticsValue: "Coba Update Lagi",
                              ),
                            );
                          }
                          return Column(
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
                                snapshot.data!.jamSiang ?? "-",
                                style: poppins.copyWith(
                                  fontSize: 14.sp,
                                  color: textBlueColor,
                                ),
                              ),
                              Text(
                                snapshot.data!.status ?? "-",
                                style: poppins.copyWith(
                                  fontSize: 14.sp,
                                  color: textBlueColor,
                                ),
                              ),
                            ],
                          );
                        }),
                    SizedBox(height: 20.h),
                    FutureBuilder<Siang2>(
                        future: siang2C.getSiang2Yesterday(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                semanticsValue: "Coba Update Lagi",
                              ),
                            );
                          }
                          return Column(
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
                                snapshot.data!.jamSiang2 ?? "-",
                                style: poppins.copyWith(
                                  fontSize: 14.sp,
                                  color: textBlueColor,
                                ),
                              ),
                              Text(
                                snapshot.data!.status ?? "-",
                                style: poppins.copyWith(
                                  fontSize: 14.sp,
                                  color: textBlueColor,
                                ),
                              ),
                            ],
                          );
                        }),
                    SizedBox(height: 20.h),
                    FutureBuilder<Pulang>(
                      future: pulangC.getPulangYesterday(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              semanticsValue: "Coba Update Lagi",
                            ),
                          );
                        }
                        return Column(
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
                              snapshot.data!.jamPulang ?? "-",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textBlueColor,
                              ),
                            ),
                            Text(
                              snapshot.data!.status ?? "-",
                              style: poppins.copyWith(
                                fontSize: 14.sp,
                                color: textBlueColor,
                              ),
                            ),
                          ],
                        );
                      },
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
                title: 'ABSEN'),
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
