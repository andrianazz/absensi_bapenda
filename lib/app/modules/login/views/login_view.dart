import 'package:absensi_bapenda/theme/color.dart';
import 'package:absensi_bapenda/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            children: [
              SizedBox(height: 20.h),
              Image.asset("assets/images/ic_bapenda.png"),
              SizedBox(height: 20.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Datang",
                    style: poppins.copyWith(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Aplikasi Absensi THL Bapenda",
                    style: poppins.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: textGreyColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Image.asset(
                "assets/images/img_login.png",
                fit: BoxFit.contain,
                width: 176.w,
                height: 201.h,
              ),
              SizedBox(height: 20.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NIK",
                    style: poppins.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: textGreyColor),
                  ),
                  SizedBox(height: 6.h),
                  TextFormField(
                    controller: controller.nikC,
                    keyboardType: TextInputType.number,
                    maxLength: 16,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field NIK tidak boleh kosong';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      prefixIcon: Icon(Icons.person_rounded, color: iconColor),
                      hintText: "NIK",
                      hintStyle: poppins.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: textGreyColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Password",
                    style: poppins.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: textGreyColor),
                  ),
                  SizedBox(height: 6.h),
                  Obx(
                    () => TextFormField(
                      obscureText: controller.obsecureText.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field PASSWORD tidak boleh kosong';
                        }
                        return null;
                      },
                      controller: controller.passC,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        prefixIcon: Icon(Icons.lock, color: iconColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obsecureText.value
                                ? Icons.lock_outline_rounded
                                : Icons.lock_open_rounded,
                          ),
                          onPressed: () {
                            controller.changeObsecureText();
                          },
                        ),
                        hintText: "Password",
                        hintStyle: poppins.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: textGreyColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Obx(
                () => ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        controller.isLoading.value == false
                            ? blueButtonColor
                            : Colors.grey),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                  onPressed: controller.isLoading.value == false
                      ? () async {
                          // Do something when the form is submitted
                          if (controller.formKey.currentState!.validate()) {
                            await controller.loginAPI(
                              controller.nikC.text,
                              controller.passC.text,
                            );
                          }
                        }
                      : null,
                  child: controller.isLoading.value == false
                      ? Text(
                          'Login',
                          style: poppins.copyWith(
                              fontSize: 14.sp, fontWeight: FontWeight.w600),
                        )
                      : CircularProgressIndicator(
                          strokeWidth: 3.w,
                          color: Colors.white,
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
