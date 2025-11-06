import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfeedplus_mohammedshahir/core/theme/app_colors.dart';
import 'package:socialfeedplus_mohammedshahir/features/auth/controllers/auth_controller.dart';



void showLogoutDialog(VoidCallback onConfirm) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: Get.context!,
      builder: (_) => CupertinoAlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
              AuthController.to.logout();
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  } else {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to log out?",
      backgroundColor: Get.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      radius: 12,
      contentPadding: EdgeInsets.all(20),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
          AuthController.to.logout();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.error,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text("Logout", style: TextStyle(color: Colors.white)),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
