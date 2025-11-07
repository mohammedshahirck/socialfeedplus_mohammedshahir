import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialfeedplus_mohammedshahir/core/services/api_services.dart';
import 'package:socialfeedplus_mohammedshahir/core/theme/app_colors.dart';
import 'package:socialfeedplus_mohammedshahir/features/auth/controllers/auth_controller.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/controllers/feed_controller.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/models/post_model.dart';



class CreatePostController extends GetxController {
  final FeedController feedController = Get.find<FeedController>();
  final AuthController authController = Get.find<AuthController>();
  final ApiService apiService = Get.find<ApiService>();
  final captionController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();
  RxBool isGeneratingCaption = false.obs;

  Future<void> pickImage(ImageSource source) async {
    final picked = await picker.pickImage(source: source, imageQuality: 70);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
    Get.back(); // close bottom sheet
  }

  Future<String> generateAICaption() async {
    try {
      isGeneratingCaption.value = true;
      final response = await apiService.getRequest('/quotes');
      if (response != null && response.statusCode == 200) {
        final data = response.data;
        final quotes = data['quotes'];

        if (quotes != null && quotes.isNotEmpty) {
          final randomIndex = Random().nextInt(quotes.length);
          final quote = quotes[randomIndex]['quote'];
          captionController.text = "✨$quote";
          return "✨ $quote";
        } else {
          return "⚠️ No quotes found";
        }
      } else {
        return "⚠️ Could not fetch caption";
      }
    } catch (e) {
      return "Error generating caption: $e";
    } finally {
      isGeneratingCaption.value = false;
    }
  }

  Future<void> post() async {
    final caption = captionController.text.trim();
    if (caption.isEmpty) {
      Get.snackbar(
        "Error",
        "Caption cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        colorText: AppColors.textLight,
        backgroundColor: Colors.grey.shade200,
      );
      return;
    }

    final post = PostModel(
      userName: authController.userEmail.value.isEmpty
          ? "Anonymous"
          : authController.userEmail.value,
      caption: caption,
      imageUrl: selectedImage.value?.path ?? "",
      timestamp: DateTime.now(),
    );

    await feedController.addPost(post);
    Get.back();
    Get.snackbar(
      "Posted!",
      "Your post was added successfully 🎉",
      snackPosition: SnackPosition.BOTTOM,
      colorText: AppColors.textLight,
      backgroundColor: Colors.grey.shade200,
    );
  }
}
