import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:socialfeedplus_mohammedshahir/core/theme/app_text_styles.dart';
import 'package:socialfeedplus_mohammedshahir/core/theme/theme_manager.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/controllers/feed_controller.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/widgets/logout_alert_dail.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/widgets/post_card.dart';
import 'package:socialfeedplus_mohammedshahir/shared/widgets/custom_appbar.dart';

class FeedScreen extends GetView<FeedController> {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Get.find<ThemeManager>();
    final scrollController = ScrollController();

    // Bind scroll listener reactively
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300) {
        controller.loadMore();
      }
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: 'SocialFeed+',
        centerTitle: false,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                themeManager.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: themeManager.toggleTheme,
            ),
          ),
          IconButton(
            onPressed: () => showLogoutDialog(() => Get.offAllNamed('/login')),
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/createPost'),
        backgroundColor: Color(0xFF7B61FF),
        child: const Icon(Icons.post_add_rounded, color: Colors.white),
      ),

      body: Obx(() {
        final posts = controller.visiblePosts;

        if (posts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/no post illustration.svg',
                  height: Get.height * 0.4,
                ),
                Text(
                  'No posts yet ',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading,
                ),
              ],
            ),
          );
        }

        return Obx(
          () => RefreshIndicator(
            onRefresh: () async => controller.refreshFeed(),
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(10),
              itemCount: posts.length + 1, // +1 for loader
              itemBuilder: (context, index) {
                if (index < posts.length) {
                  return postCard(
                    context,
                    controller,
                    posts[index],
                    onTap: () {
                      controller.setSelectedPost(posts[index]);
                      Get.toNamed('/postDetail');
                    },
                  );
                } else {
                  // Loader at bottom when more posts available
                  return Obx(
                    () => controller.hasMore.value
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : const SizedBox.shrink(),
                  );
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
