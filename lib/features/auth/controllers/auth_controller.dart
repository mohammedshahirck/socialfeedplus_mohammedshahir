import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socialfeedplus_mohammedshahir/core/theme/app_colors.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find<AuthController>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  RxBool isSignupMode = false.obs;
  RxBool isLoggedIn = false.obs;
  RxString userEmail = ''.obs;
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  @override
  void onReady() {
    checkLoginStatus();
    super.onReady();
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;

  void toggleConfirmPasswordVisibility() =>
      obscureConfirmPassword.value = !obscureConfirmPassword.value;

  void toggleAuthMode() {
    isSignupMode.value = !isSignupMode.value;
  }

  Future<void> signup(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', userNameController.text.trim());
      await prefs.setString('email', emailController.text.trim());
      await prefs.setString('password', passwordController.text.trim());

      Get.snackbar(
        'Success',
        'Account created! Please login.',
        colorText: AppColors.textLight,
        backgroundColor: Colors.grey.shade200,
        snackPosition: SnackPosition.BOTTOM,
      );
      isSignupMode.value = false;
      userNameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    }
  }

  Future<void> login(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString('userName');

      final savedPassword = prefs.getString('password');

      if (userNameController.text.trim() == savedEmail &&
          passwordController.text.trim() == savedPassword) {
        await prefs.setBool('isLoggedIn', true);
        isLoggedIn.value = true;
        userEmail.value = savedEmail ?? '';

        Get.offAllNamed('/feed');
        userNameController.clear();
        emailController.clear();
        passwordController.clear();
      } else {
        Get.snackbar(
          'Error',
          'Invalid email or password',
          backgroundColor: Colors.grey.shade200,
          colorText: AppColors.textLight,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    isLoggedIn.value = false;
    userEmail.value = '';
    Get.offAllNamed('/auth');
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;
    isLoggedIn.value = loggedIn;
    userEmail.value = prefs.getString('userName') ?? '';
    if (loggedIn) {
      Get.offAllNamed('/feed');
    } else {
      Get.offAllNamed('/auth');
    }
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(value.trim())) {
      return 'Only letters, numbers, and underscores allowed';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // Basic format check (you can adjust this for stricter rules)
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Must be at least 6 characters';
    if (!RegExp(r'[A-Za-z]').hasMatch(value) ||
        !RegExp(r'\d').hasMatch(value)) {
      return 'Include at least 1 letter & 1 number';
    }
    return null;
  }

  @override
  void onClose() {
    userNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
