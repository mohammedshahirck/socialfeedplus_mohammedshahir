import 'package:get/get.dart';
import 'package:socialfeedplus_mohammedshahir/core/bindings/auth_binding.dart';
import 'package:socialfeedplus_mohammedshahir/features/auth/views/auth_screen.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/feed_screen.dart';

final appRoutes = [
  GetPage(
    name: '/auth',
    page: () => const AuthScreen(),
    binding: AuthBindings(),
  ),
  GetPage(name: '/feed', page: () => const FeedScreen()),
];
