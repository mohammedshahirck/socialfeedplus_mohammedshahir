import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfeedplus_mohammedshahir/core/theme/app_text_styles.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/controllers/feed_controller.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/models/post_model.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/widgets/image_widget.dart';
import 'package:socialfeedplus_mohammedshahir/shared/widgets/like_widget.dart';


Widget postCard(
  BuildContext context,
  FeedController controller,
  PostModel post, {
  void Function()? onTap,
}) {
  // Create reactive wrappers for like state
  final RxBool isLiked = post.isLiked.obs;
  final RxInt likeCount = post.likeCount.obs;

  return GestureDetector(
    onTap: onTap,
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: const Color(0xFF7B61FF).withAlpha(100),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(
              post.userName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              controller.timeAgo(post.timestamp),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),

          // Post Image (supports local + network)
          if (post.imageUrl.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: postImage(post),
            ),

          // Caption
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              post.caption,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ),

          // Like + Comment Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                // Overshoot LikeButton
                LikeButton(
                  isLiked: isLiked,
                  likeCount: likeCount,
                  activeColor: Colors.redAccent,
                  inactiveColor: Colors.grey,
                  iconsScale: 1.1,
                  onPressed: (liked) {
                    // Update controller + persist to Hive
                    controller.toggleLike(post);
                  },
                  iconSize: 19,
                  textStyle: AppTextStyles.body,
                  activeIcon: 'assets/svg/heart-fill.svg',
                  icon: 'assets/svg/like_icon.svg',
                ),
                const SizedBox(width: 18),

                // Comment Button
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: null,
                ),
                Text("${(post.comments.isEmpty ? "" : post.comments.length)}"),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
