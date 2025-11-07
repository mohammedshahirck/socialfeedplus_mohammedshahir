import 'package:get/get.dart';
import 'package:socialfeedplus_mohammedshahir/core/bindings/feed_binding.dart';
import 'package:socialfeedplus_mohammedshahir/core/bindings/post_binding.dart';
import 'package:socialfeedplus_mohammedshahir/core/bindings/route_binding.dart';
import 'package:socialfeedplus_mohammedshahir/features/auth/views/auth_screen.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/views/feed_screen.dart';
import 'package:socialfeedplus_mohammedshahir/features/create_post/views/create_post.dart';
import 'package:socialfeedplus_mohammedshahir/features/post_detail_page/views/post_detail_page.dart';

final appRoutes = [
  GetPage(
    name: '/auth',
    page: () => const AuthScreen(),
    binding: AuthBindings(),
  ),
  GetPage(name: '/feed', page: () => FeedScreen(), binding: FeedBinding()),
  GetPage(
    name: '/createPost',
    page: () => const CreatePostScreen(),
    binding: PostBinding(),
  ),
  GetPage(
    name: '/postDetail',
    page: () => PostDetailScreen(),
    binding: FeedBinding(),
  ),
];
