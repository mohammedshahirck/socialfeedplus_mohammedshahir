import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:socialfeedplus_mohammedshahir/core/routes/app_routes.dart';
import 'package:socialfeedplus_mohammedshahir/core/services/api_services.dart';
import 'package:socialfeedplus_mohammedshahir/core/theme/app_theme.dart';
import 'package:socialfeedplus_mohammedshahir/core/theme/theme_manager.dart';
import 'package:socialfeedplus_mohammedshahir/features/auth/controllers/auth_controller.dart';
import 'package:socialfeedplus_mohammedshahir/features/create_post/models/comment_model.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/models/post_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PostModelAdapter());
  Hive.registerAdapter(CommentModelAdapter());
  await Hive.openBox<PostModel>('posts');
  Get.put(ApiService(), permanent: true);
  Get.put(AuthController(), permanent: true);
  Get.put(ThemeManager(), permanent: true);
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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/auth',
      getPages: appRoutes,
    );
  }
}
