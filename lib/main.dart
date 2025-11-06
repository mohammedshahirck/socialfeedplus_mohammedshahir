import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfeedplus_mohammedshahir/core/routes/app_routes.dart';
import 'package:socialfeedplus_mohammedshahir/core/theme/theme_manager.dart';
import 'package:socialfeedplus_mohammedshahir/features/auth/controllers/auth_controller.dart';

void main() async {
  runApp(SocialFeedApp());
}

class SocialFeedApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  SocialFeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeManager themeManager = Get.put(ThemeManager());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SocialFeed+',
      themeMode: themeManager.themeMode,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        cardColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        cardColor: const Color(0xFF1E1E1E),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/auth',
      getPages: appRoutes,
    );
  }
}
