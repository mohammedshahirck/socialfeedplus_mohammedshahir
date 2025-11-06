import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:socialfeedplus_mohammedshahir/features/create_post/controllers/post_controller.dart';

void showImagePickerSheet(
  BuildContext context,
  CreatePostController controller,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C25),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                height: 5,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  "Take Photo",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => controller.pickImage(ImageSource.camera),
              ),
              const Divider(color: Colors.white12, height: 0),
              ListTile(
                leading: const Icon(
                  Icons.photo_library_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  "Choose from Gallery",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => controller.pickImage(ImageSource.gallery),
              ),
              const Divider(color: Colors.white12, height: 0),
              ListTile(
                title: const Center(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onTap: () => Get.back(),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      );
    },
  );
}
